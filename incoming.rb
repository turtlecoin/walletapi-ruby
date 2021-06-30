require_relative 'lib/TurtleCoin'
require 'whenever'
#w = Wallet.new.transactions_unconfirmed
#puts w
every 1.minute do
    puts "yup"
end