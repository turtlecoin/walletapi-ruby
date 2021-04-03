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