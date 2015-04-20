require 'agecheq/response_parser'

module AgeCheq
  class Child
    include HTTParty

    format :json
    parser ResponseParser

    # Shortcut methods for initializing and making an API call in one line.
    class << self
      def check(pin)
        self.new(pin).check
      end

      def associate(pin, data)
        self.new(pin).associate(data)
      end

      def configure!
        raise 'You must set the api_key and application_id using configure' unless AgeCheq.configuration.configured?
        basic_auth AgeCheq.configuration.api_key, ' '
        base_uri 'https://api.agecheq.com/applications/' + AgeCheq.configuration.application_id
      end
    end

    attr_reader :pin

    def initialize(pin)
      @pin = pin
      self.class.configure!
    end

    # Check the status of a child using their pin.
    def check
      response = self.class.get("/acpin/#{@pin}/check")
      response.parsed_response
    end

    # Associate some data with a child's account.
    def associate(data)
      response = self.class.get("/acpin/#{@pin}/associate/#{data}")
      response.parsed_response
    end
  end
end
