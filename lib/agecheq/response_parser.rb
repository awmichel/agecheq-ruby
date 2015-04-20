require 'active_support/hash_with_indifferent_access'

module AgeCheq
  InvalidCommand = Class.new(StandardError)
  InvalidAgeCheqPin = Class.new(StandardError)
  UnknownFailure = Class.new(StandardError)

  class ResponseParser < HTTParty::Parser
    def parse
      response = JSON.parse(body)

      # Check for a failure response.
      if response['rtn'] == 'fail'
        if response['rtnmsg'] == 'invalid command'
          raise InvalidCommand, response['rtnmsg']
        elsif response['rtnmsg'] == 'invalid child agecheq pin'
          raise InvalidAgeCheqPin, response['rtnmsg']
        else
          raise UnknownFailure, response['rtnmsg']
        end
      end

      # Return data as a HWIA.
      ActiveSupport::HashWithIndifferentAccess.new(response['data'])
    end
  end
end
