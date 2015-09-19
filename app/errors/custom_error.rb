module CustomError
  class AccessDenied < StandardError
    def initialize(message = nil, action = nil, subject = nil)
        @message = message
        @action = action
        @subject = subject
        @default_message = I18n.t(:"unauthorized.default", :default => "You are not authorized to access this page.")
    end
  end
end