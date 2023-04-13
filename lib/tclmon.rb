# frozen_string_literal: true

require_relative 'tclmon/config'

module Tclmon

  def self.run
    config = Config.new.load
  end
end
