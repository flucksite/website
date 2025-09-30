# Load .env file before any other config or app code
require "lucky_env"
LuckyEnv.load?(".env")

# Require your shards here
require "lucky"
require "carbon"
require "lucky_vite"
