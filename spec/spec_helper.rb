if ENV["CI"]
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    %w[spec].each do |ignore_path|
      add_filter(ignore_path)
    end
  end
end

require "bundler/setup"

# FIXME: NameError: uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger when activesupport < 7.1
require "logger"

require "syobocalite"
require "webmock/rspec"
require "rspec/its"

Dir["#{__dir__}/support/**/*.rb"].each {|f| require f }

Time.zone = "Tokyo"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FixtureUtil
end

def spec_dir
  Pathname(__dir__)
end
