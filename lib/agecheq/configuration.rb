require 'active_support/core_ext/object/blank'

module AgeCheq
  class Configuration
    attr_accessor :api_key
    attr_accessor :application_id

    def initialize
      @api_key = ""
      @application_id = ""
    end

    def configured?
      !api_key.blank? && !application_id.blank?
    end
  end
end
