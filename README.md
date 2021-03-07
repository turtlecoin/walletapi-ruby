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

