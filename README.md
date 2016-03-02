# Smsme

Hi,

This is a simple short message assistant. It should help you send short messages to people and also manage your contact.
It is basically a simple gem that mind be handy in any situation.

Enjoy!

## Installation

I did not publish this gem on rubygems because of certain resources that you might need to use it at runtime.
This includes:

* A file that you should create and name "lib/smsme/keys.rb" where you'll have all the constants needed to setup.
  * ACC_SID: Account SID. Something like:'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  * AUTH_TOKEN: Authentication token. Something like: 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
  * SENDER_NUMBER: Senders registered number. Something like: "+1*********3"

All of the above "keys" file can be gotten from [Twillo](https://www.twilio.com/sms)

To use this gem:

Clone this repo using:

`git clone git@github.com:andela-oojewale/smsme.git`

Add the keys file mentioned above.

## Usage

Run:

 `bundle exec smsme`

The gem is quite interactive. Follow the prompts and you will find it easy to use.

## Features

* Contact Management with sqlite3 database.
* Addition of contacts to database with simple commands.
* Ability to search for saved contacts.
* Ability to send sms to saved contacts.
* Ability to send sms to multiple recipients at once.
* Ability to send sms to recipients who are not saved on your contacts list.
* Ability to show all contacts in your address book.




## NOTICE
Not all telephone networks are verified and thus supported. You can check [here](https://www.twilio.com/lookup) for a lookup.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

