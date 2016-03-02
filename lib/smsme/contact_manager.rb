module Smsme
  class ContactManager
    include Utility
    def initialize
      @display = Smsme::Display.new
    end

    def add_contact
      puts @display.add_to_contact
      contact_info = user_input
      add_single_contact(contact_info) if contact_info =~ single_contact
      add_multi_contact(contact_info) if contact_info =~ many_contact
      unless (contact_info =~ single_contact) || (contact_info =~ many_contact)
        puts @display.error_message
        add_contact
      end
    end

    def search_contact(name)
      contact = Database.search(name)
      if contact.length > 1
        similar_matches(contact, name)
      elsif contact.length == 1
        puts @display.prettify "| Name: #{contact[0]["name"]}  | Phone Number: #{contact[0]["phoneNumber"]}"
        puts @display.prettify "Send this user an sms?"
        if continue?("Y/N")
          return contact[0]["phoneNumber"]
        end
        puts @display.prettify "Perform another action?"
      else
        puts @display.prettify "Contact does not exist"
      end
    end

    def all_contacts
      contacts = Database.all
      contacts.each do |contact|
        puts @display.prettify "| Name: #{contact["name"]}  | Phone Number: #{contact["phoneNumber"]}"
      end unless contacts.empty?
    end

    def similar_matches(contact, keyword)
      names = contact.map{ |record| record["name"].capitalize }
      puts @display.prettify "Which '#{keyword}'? #{names}"
      search_contact(user_input)
    end

    def add_single_contact(contact)
      name, number = contact.split[2], contact.split[4]
      Database.save_contact(name, number)
      puts @display.prettify "Contact added successfully"
    end

    def add_multi_contact(contact)
      names = values_as_array(contact.split[2])
      numbers = values_as_array(contact.split[4])
      names.zip(numbers).each do | pair |
        Database.save_contact(pair[0], pair[1])
      end
      puts @display.prettify "Contacts added successfully"
    end

    def recipients
     user_input.split(",")
    end

    def single_contact
      /\Aadd -n [a-z]{2,30} -p [\d]{8,15}\z/i
    end

    def many_contact
      /\Aadd-many -n \[[a-z,]+\] -p \[[\d,]+\]\z/i
    end

    def values_as_array(value)
      value.gsub(/\[|\]/,"").split(",")
    end
  end
end