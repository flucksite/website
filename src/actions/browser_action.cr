abstract class BrowserAction < Lucky::Action
  include Lucky::ProtectFromForgery

  # By default all actions are required to use underscores.
  # Add `include Lucky::SkipRouteStyleCheck` to your actions if you wish to ignore this check for specific routes.
  include Lucky::EnforceUnderscoredRoute

  # Set language from cookies or params
  include SetLanguage

  # Security headers
  include SecurityHeaders

  accepted_formats [:html, :json], default: :html
end
