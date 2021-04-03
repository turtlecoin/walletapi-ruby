# TurtleCoin

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/TurtleCoin`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'TurtleCoin'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install TurtleCoin

## Examples

## module_example.rb
An example on how it could be used to create other tools.

## check_balance.rb
Checks the balance of the wallet
```ruby
require_relative 'lib/TurtleCoin'
require 'json'
w = Wallet.new.balance
j = JSON.parse(w)
if j["unlocked"].to_i > 0
    puts "Total TRTL Unlocked: #{j["unlocked"]}\r\r"
    puts "\n\n"
end



JSON.parse(Wallet.new.balances).each do |l|
    if l["unlocked"].to_i > 0
        puts "\r\r\r#{l["address"]} has #{l["unlocked"]} TRTL\n\r\r"
    end
end
```

## create_new_wallet.rb
Create a new wallet
```ruby
require_relative 'lib/TurtleCoin'
require 'json'


# we create a instance variable of the class so we can access the class later. 
w = Wallet.new

# we first have to close the wallet. so we can create a new one. 
w.wallet_close

# create a new wallet named new_wallet.wallet

w.create_wallet("new_wallet.wallet", "password")


# print out the primary address
puts "New address: " + w.address_primary["address"]
print("\n")

# prints out the keys of the files.
keys = w.keys_address(w.address_primary["address"])
keys.each do |key, value|
    puts key + ": " + value.to_s
end
print("\n\n")

puts "Mnemonic Seed: " + w.keys_mnemonic(w.address_primary["address"])["mnemonicSeed"]

# set the node up to use a public node.
# it is safer and better for the network if you set up your own node.
puts w.set_node(11898, "TRTLnode.ddns.net")
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/TurtleCoin.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
