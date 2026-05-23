# frozen_string_literal: true

source "https://rubygems.org"

gem "hanami", "~> 2.3.0"
gem "hanami-controller", "~> 2.3.0"
gem "hanami-router", "~> 2.3.0"
gem "hanami-validations", "~> 2.3.0"
gem "hanami-view", "~> 2.3.0"

gem "dry-types", "~> 1.7"
gem "dry-operation", ">= 1.0.1"
gem "puma"
gem "rake"

<<<<<<< Updated upstream
=======
# Frontend
gem "bun_bun_bundle", "~> 0.13.0"

# i18n
gem "i18n", "~> 1.14"

# Content + forms
gem "marquery", "~> 0.1.0"
gem "otori", "~> 0.1.0"
gem "commonmarker", "~> 2.4"
gem "pagy", "~> 43.5"

# Observability + security
gem "sentry-ruby", "~> 5.21"
gem "rack-attack", "~> 6.7"

>>>>>>> Stashed changes
group :development do
  gem "hanami-webconsole", "~> 2.3.0"
end

group :development, :test do
  gem "dotenv"
end

group :cli, :development do
  gem "hanami-reloader", "~> 2.3.0"
end

group :cli, :development, :test do
  gem "hanami-rspec", "~> 2.3.0"
end

group :test do
  # Web integration
  gem "capybara"
  gem "rack-test"
end
