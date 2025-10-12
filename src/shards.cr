# Load .env file before any other config or app code
require "lucky_env"
LuckyEnv.load?(".env")

# Require your shards here
require "lucky"
require "avram/lucky"
require "carbon"

require "lucky_favicon"
require "lucky_vite"
require "rosetta"
require "email_octopus"
require "prosopo"
require "cmark"
