require 'httparty'

require 'agecheq/configuration'
require 'agecheq/version'
require 'agecheq/child'

module AgeCheq
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset!
    @configuration = Configuration.new
  end
end
