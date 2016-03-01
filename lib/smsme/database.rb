module Smsme
  class Database
    APP_PATH = __dir__
    class << self
      def db_conn
        db = SQLite3::Database.new "#{APP_PATH}/contact.sqlite3"
        db.results_as_hash = true
        db
      end

      def create_contact_list
        db_conn.execute "CREATE TABLE IF NOT EXISTS contacts (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                          name VARCHAR NOT NULL, phoneNumber VARCHAR NOT NULL);"
      end

      def save_contact(name, number)
        db_conn.execute "INSERT INTO contacts (name, phoneNumber) VALUES ('#{name}', '#{number}');"
      end

      def search(name)
        rows = db_conn.execute "SELECT name, phoneNumber FROM contacts WHERE name = '#{name}';"
        rows = db_conn.execute "SELECT name, phoneNumber FROM contacts WHERE name LIKE '%#{name}%';" if rows.empty?
        contacts = []
        rows.each{|row| contacts << row.reject!{ |k| !k.is_a? String } }
        contacts
      end
    end
  end
end