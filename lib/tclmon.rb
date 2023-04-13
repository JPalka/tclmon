# frozen_string_literal: true

require_relative 'tclmon/config'
require_relative 'tclmon/client'

require 'net/http'
require 'json'

module Tclmon
  def self.run
    @config = Config.new.load
    Client.new(@config).get_system_status
  end
end
