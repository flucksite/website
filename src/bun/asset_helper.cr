require "./config"

module Lucky::AssetHelpers
  # ASSET_MANIFEST = {} of String => String
  # CONFIG         = {has_loaded_manifest: false}

  # Loads the asset manifest at compile time.
  #
  # Call this once in src/app.cr:
  # ```
  # Lucky::AssetHelpers.load_manifest
  # ```
  macro load_manifest(config_path = "")
    {{ run "./asset_manifest_builder", config_path }}
    {% CONFIG[:has_loaded_manifest] = true %}
  end

  # Returns the path to an asset with fingerprinting.
  #
  # ```
  # # In a page or component:
  # img src: asset("images/logo.png")
  # script src: asset("js/app")
  # css_link asset("css/app")
  # ```
  #
  # Assets are checked at compile time. If not found, you'll get a
  # helpful error with suggestions.
  #
  # NOTE: This macro requires a `StringLiteral`. For dynamic paths,
  # use `dynamic_asset` instead.
  macro asset(path)
    {% unless CONFIG[:has_loaded_manifest] %}
      {% raise "No manifest loaded. Call 'Lucky::AssetHelpers.load_manifest'" %}
    {% end %}

    {% if path.is_a?(StringLiteral) %}
      {% if Lucky::AssetHelpers::ASSET_MANIFEST[path] %}
        Lucky::Server.settings.asset_host + {{ Lucky::AssetHelpers::ASSET_MANIFEST[path] }}
      {% else %}
        {% asset_paths = Lucky::AssetHelpers::ASSET_MANIFEST.keys.join(",") %}
        {{ run "./missing_asset", path, asset_paths }}
      {% end %}
    {% elsif path.is_a?(StringInterpolation) %}
      {% raise <<-ERROR

      The 'asset' macro doesn't work with string interpolation.

      Try this:
        ▸ Use the 'dynamic_asset' method instead

      ERROR
      %}
    {% else %}
      {% raise <<-ERROR

      The 'asset' macro requires a literal string like "js/app", instead got: #{path}

      Try this:
        ▸ If you're using a variable, switch to a literal string
        ▸ If you can't use a literal string, use the 'dynamic_asset' method instead

      ERROR
      %}
    {% end %}
  end

  # Returns the path to an asset (allows string interpolation).
  #
  # ```
  # img src: dynamic_asset("images/icon-#{icon_name}.png")
  # ```
  #
  # NOTE: This method does NOT check assets at compile time.
  def dynamic_asset(path : String) : String
    fingerprinted = Lucky::AssetHelpers::ASSET_MANIFEST[path]?

    if fingerprinted
      Lucky::Server.settings.asset_host + fingerprinted
    else
      raise "Missing asset: #{path}"
    end
  end

  # Class method variant for use outside pages/components.
  #
  # ```
  # Lucky::AssetHelpers.dynamic_asset("images/logo.png")
  # ```
  def self.dynamic_asset(path : String) : String
    fingerprinted = ASSET_MANIFEST[path]?

    if fingerprinted
      Lucky::Server.settings.asset_host + fingerprinted
    else
      raise "Missing asset: #{path}"
    end
  end

  # Returns all the CSS entrypoints from the manifest.
  def self.css_entry_points
    ASSET_MANIFEST.keys.select(&.ends_with?(".css"))
  end
end
