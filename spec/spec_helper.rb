require 'rspec'
require 'faker'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    require 'agecheq'
  end

  config.before(:each) do
    AgeCheq.reset!
  end
end
