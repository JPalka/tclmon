# frozen_string_literal: true

require_relative 'notifier'

module Tclmon
  class Client
    SIGNAL_STRENGTH = {
      0 => '󰤯',
      1 => '󰤟',
      2 => '󰤢',
      3 => '󰤥',
      4 => '󰤨',
      5 => '󰤨'
    }.freeze

    BATTERY_LEVEL = {
      0 => '',
      1 => '',
      2 => '',
      3 => '',
      4 => ''
    }.freeze

    BATTERY_CHARGE = {
      0 => '',
      1 => '', # FULL
      2 => ''
    }.freeze

    NETWORK_TYPE = {
      0 => '',
      8 => '󰜔'
    }.freeze

    def initialize(config)
      @config = config
    end

    def get_system_status
      api_name = 'GetSystemStatus'
      client = Net::HTTP.new(@config[:ip_address], @config[:port])
      client.start
      system_status_response = client.post(
        "/jrd/webapi?api=#{api_name}",
        '{"jsonrpc":"2.0","method":"GetSystemStatus","params":null,"id":"13.4"}',
        {
          '_TclRequestVerificationKey' => @config[:request_verification_key],
          'Referer' => "http://#{@config[:ip_address]}/index.html"
        }
      )
      system_status = JSON.parse(system_status_response.body)['result']
      check_battery_level(system_status['bat_cap'])
      print_status(system_status)
    end

    private

    def print_status(system_status)
      print("#{SIGNAL_STRENGTH[system_status['SignalStrength']]}(#{system_status['curr_num']}) #{system_status['NetworkName']} | ")
      print("#{NETWORK_TYPE[system_status['NetworkType']]} | ")
      print("#{BATTERY_LEVEL[system_status['bat_level']]} #{system_status['bat_cap']}% #{BATTERY_CHARGE[system_status['chg_state']]}")
      puts ''
    end

    def check_battery_level(current_charge)
      return if current_charge.to_i > @config[:critical_battery_level]

      Notifier.new.notify(
        "battery level low: #{current_charge}%",
        'critical'
      )
    end
  end
end
