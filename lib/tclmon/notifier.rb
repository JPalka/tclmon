module Tclmon
  class Notifier
    def notify(msg, severity)
      success = system("notify-send -u #{severity} '#{msg}'")
      raise 'error while sending notification' unless success
    end
  end
end
