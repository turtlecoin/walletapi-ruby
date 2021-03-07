# TurtleWalletRPC


### Creating new wallet
```ruby
puts Wallet.new.create_wallet("new_wallet.wallet", "dogs_cant_look_up")
```

This will create a new wallet. Make sure that any opened wallets are closed.

### Closing wallet
```ruby
puts Wallet.new.wallet_close
```
This will close the wallet so a new one could be opened.

### Setting node
```ruby
puts Wallet.new.set_node("11898",  "TRTLnode.ddns.net")
```
The code above could be used to set a node for the wallet.

### Listing wallet addresses
```ruby
w  = Wallet.new
js = w.list_addresses
JSON.parse(js).each do |key, value|
    puts value
end
```