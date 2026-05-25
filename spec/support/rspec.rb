# frozen_string_literal: true

RSpec.configure do |config|
  # Use the recommended non-monkey patched syntax.
  config.disable_monkey_patching!

  # Use and configure rspec-expectations.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4.
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # Use and configure rspec-mocks.
  config.mock_with :rspec do |mocks|
    # Prevent mocking methods that don't exist on the real object.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # `:focus` metadata isolates a subset; runs everything when nothing is tagged.
  config.filter_run_when_matching :focus

  # Persist state to support --only-failures and --next-failure.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # config.warnings = true

  # Show more verbose output when running an individual spec file.
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples to surface slow specs.
  config.profile_examples = 10

  # Random order surfaces order dependencies; reproduce with --seed N.
  config.order = :random

  # Seed global randomization so --seed reproduces flaky failures.
  Kernel.srand config.seed
end
