module Smsme
  module Utility

    @display = Smsme::Display.new
    def continue?(info = "Continue? (Y/N)")
      puts @display.prettify info
      user_input =~ /y|yes/
    end

    def user_input
      gets.chomp.downcase
    end

    def valid_phone_number
      /[\d]{8,15}/
    end

  end
end