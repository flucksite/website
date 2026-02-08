require "./shards"

require "./bun/asset_helper"

# Load the asset manifest
Lucky::AssetHelpers.load_manifest

require "../config/server"
require "../config/**"
require "./models/base_model"
require "./models/mixins/**"
require "./models/**"
require "./queries/mixins/**"
require "./queries/**"
require "./operations/mixins/**"
require "./operations/**"
require "./serializers/base_serializer"
require "./serializers/**"
require "./emails/base_email"
require "./emails/**"
require "./actions/mixins/**"
require "./actions/**"
require "./components/mixins/**"
require "./components/base_component"
require "./components/**"
require "./pages/**"
require "../db/migrations/**"
require "./app_server"
