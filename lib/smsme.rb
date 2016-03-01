require "resources"

module Smsme
  class Entry
    def initialize
      Smsme::Database.db_conn
      Smsme::Database.create_contact_list
      sender = Smsme::Sender.new
      sender.start
    end
  end
end
