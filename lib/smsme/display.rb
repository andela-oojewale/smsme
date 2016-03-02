module Smsme
  class Display
    def welcome
      <<-EOS
                *************************************************
                *                                               *
                *                     SMSME                     *
                *     Your quick short messaging assistant.     *
                *                                               *
                *************************************************
      EOS
    end

    def actions
      <<-EOS
                *************************************************
                *         Press 1 to add contacts               *
                *         Add country code in phone numbers     *
                *       Press 2 to search for a contact         *
                *    Press 3 to send sms to a number that is    *
                *       not on your contact list                *
                *          Press 4 to see all contacts          *
                *               Press 0 to quit                 *
                *************************************************
      EOS
    end

    def recipient_number
      <<-EOS
                *************************************************
                *          Enter the recipient number(s).       *
                *      Numbers can be separated by commas       *
                *************************************************
      EOS
    end

    def get_message
      <<-EOS
                *************************************************
                *      Enter the message you want to send.      *
                *         Not more than 100 characters          *
                *************************************************
      EOS
    end

    def error_message
      <<-EOS
                *************************************************
                *                 Invalid entry.                *
                *************************************************
      EOS
    end

    def prettify(message)
      <<-EOS
                *************************************************
                  #{message}
                *************************************************
      EOS
    end

    def add_to_contact
      <<-EOS
                *********************************************************************************************
                            Use the following command to add a contact:
                            add -n contact-name -p phone-number
                            E.g add -n Olaide -p 23480*******7
                            To add multiple contacts at a time, use:
                            add-many -n contact-names -p phone-numbers
                            E.g add-many -n [Olaide,Ayo,Paul] -p [23480*******7,23480*******8,23480*******9]
                            NB: Add the country code to the number(s) you want to save.
                *********************************************************************************************
      EOS
    end
  end
end