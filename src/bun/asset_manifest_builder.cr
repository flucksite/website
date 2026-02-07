require "json"
require "colorize"
require "./config"

struct Lucky::AssetManifestBuilder
  MAX_RETRIES =   20
  RETRY_AFTER = 0.25

  property retries = 0
  getter manifest_path : String
  getter config : Lucky::Bun::Config

  def initialize
    @config = Lucky::Bun::Config.load
    @manifest_path = resolve_manifest_path
  end

  def build_with_retry
    retry_or_raise_error unless manifest_exists?
    build_manifest
  end

  private def resolve_manifest_path
    File.expand_path(File.join(config.out_dir, "manifest.json"))
  end

  private def retry_or_raise_error
    raise_missing_manifest_error unless retries < MAX_RETRIES

    self.retries += 1
    sleep(RETRY_AFTER)
    build_with_retry
  end

  private def build_manifest
    parse_manifest.each do |key, value|
      asset_path = expand_asset_path(value.as_s)
      manifest_key = normalize_key(key)

      puts %({% Lucky::AssetHelpers::ASSET_MANIFEST["#{manifest_key}"] = "#{asset_path}" %})
    end
  end

  private def expand_asset_path(file : String) : String
    File.join(config.public_path, file)
  end

  private def normalize_key(key : String) : String
    key
  end

  private def parse_manifest
    JSON.parse(File.read(manifest_path)).as_h
  end

  private def manifest_exists?
    File.exists?(manifest_path)
  end

  private def raise_missing_manifest_error
    message = <<-ERROR
    #{"Manifest not found:".colorize(:red)} #{manifest_path}

    #{"Make sure you have compiled your assets:".colorize(:yellow)}
      bun run build   # production build
      bun run dev     # development with watch

    ERROR

    puts message
    raise "Asset manifest not found"
  end
end

begin
  Lucky::AssetManifestBuilder.new.build_with_retry
rescue e
  puts e.message.try(&.colorize(:red))
  raise e
end
