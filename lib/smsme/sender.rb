module Smsme
  class Sender
    attr_reader :sender_number
    include Utility
    def initialize
      @display = Smsme::Display.new
      @manager = Smsme::ContactManager.new
      @client = Twilio::REST::Client.new ACC_SID, AUTH_TOKEN
    end

    def start
      puts @display.welcome
      get_sender_number
      interact
    end

    def interact
      puts @display.actions
      response = user_input.to_i
      case response
      when 1
        @manager.add_contact
        interact
      when 2
        puts @display.prettify "Enter the name of the contact"
        name = user_input
        send_message(@manager.search_contact(name))
      when 3
        puts @display.prettify "Enter recipients numbers separated by commas"
        send_message(@manager.recipients)
      when 0
        puts @display.prettify "GOODBYE !!!"
        exit
      else
        puts @display.error_message
      end
    end

    def get_sender_number
      puts @display.prettify "What is your number?"
      @sender_number = user_input
      if @sender_number =~ valid_phone_number
        puts @display.prettify "Your phone number is #{@sender_number}"
      else
        puts @display.error_message
        exit
      end
    end

    def send_message(recipients)
      if recipients.is_a? Array
        puts @display.get_message
        message = user_input[0..100] + "SENDER: #{sender_number}"
        multi_recipients(recipients, message)
      elsif recipients =~ valid_phone_number
        single_recipient(recipients)
      else
        interact
      end
    end

    def multi_recipients(recipients, message)
      recipients.each do |number|
        next unless number =~ valid_phone_number
        messenger(number, message)
      end
    end

    def single_recipient(recipients)
      puts @display.get_message
      message = user_input[0..100] + "SENDER: #{sender_number}"
      messenger(recipients, message)
    end

    def messenger(number, message)
      @client.messages.create(
          from: SENDER_NUMBER,
          to: "+#{number}",
          body: message
        )
      puts "Message sent to #{number}"
    rescue Twilio::REST::RequestError
      puts "#{number} is unverified. Message not sent"
    end
  end
end