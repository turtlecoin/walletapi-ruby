require_relative 'lib/TurtleCoin'
require 'json'
#wallet = JSON.parse(Wallet.new.list_addresses)
#wallet["addresses"].each { |a| puts a }

puts "\n\n\n"

status = JSON.parse(Wallet.new.status)
#status.each { |key, value| puts  "#{key}: #{value}\n"  }

puts "\n\n\n"

w = Wallet.new
JSON.parse(w.keys).each { |key, value| puts "#{key}: #{value}"}


