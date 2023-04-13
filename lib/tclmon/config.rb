# frozen_string_literal: true

require 'psych'

module Tclmon
  class Config
    attr_reader :config_path

    def initialize(config_path = '~/.tclmon_conf.yaml')
      @config_path = File.expand_path(config_path)
    end

    def load
      return {} unless File.exist?(config_path)

      Config.default.merge(Psych.safe_load_file(config_path).transform_keys(&:to_sym))
    end

    def self.default
      {
        ip_address: '192.168.1.1',
        port: '80',
        request_verification_key: ''
      }
    end
  end
end
