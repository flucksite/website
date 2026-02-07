require "colorize"
require "levenshtein"

missing_asset = ARGV.first
asset_paths = ARGV[1].split(",")

best_match = Levenshtein::Finder.find(missing_asset, asset_paths, tolerance: 4)

puts %("#{missing_asset}" does not exist in the manifest.).colorize(:red)

if best_match
  puts %(Did you mean "#{best_match}"?).colorize(:yellow).bold
else
  puts "Make sure the asset exists and you have compiled your assets.".colorize(:red)

  if asset_paths.any?
    puts "\nAvailable assets:".colorize(:dim)
    asset_paths.sort.first(15).each do |path|
      puts "  • #{path}".colorize(:dim)
    end
    if asset_paths.size > 15
      puts "  ... and #{asset_paths.size - 15} more".colorize(:dim)
    end
  end
end

raise "There was a problem finding the asset"
