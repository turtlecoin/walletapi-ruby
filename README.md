# TurtleCoin

### what is needed to get started?
Download and install <a href="https://github.com/turtlecoin/turtlecoin">https://github.com/turtlecoin/turtlecoin</a>

More info: <a href="https://turtlecoin.github.io/wallet-api-docs/">https://turtlecoin.github.io/wallet-api-docs/</a>

### Config
The config file is located in the `data` directory. 
```
{
    "ip": "http://",
    "daemonHost": "127.0.0.1",
    "daemonPort": "8070",
    "filename": "wallet.wallet",
    "password": "",
    "X-API-KEY": ""
}


```
### Install the needed Gems
```gem install excon```


## Examples

## module_example.rb
An example on how it could be used to create other tools.

## check_balance.rb
Checks the balance of the wallet


## create_new_wallet.rb
Create a new wallet

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
require 'json'
w  = Wallet.new
js = w.list_addresses
JSON.parse(js).each do |key, value|
    puts value
end
```

### Get balance of certain addresses
```ruby
puts Wallet.new.balance_address("TRTLuxL46JJaJbTYMyQGLi4euHoe3QUNQQ5niiPoYah15pc6ESFdZJ59KmtzUzedHASfDRYPxVbEiYQsXUtBmQRL18pDdK72F5i")
```

### Create new address
```ruby
puts Wallet.new.create_addresses
```

### Get status
```ruby
puts Wallet.new.status
```
Get the wallet sync status, peer count, and hashrate


### transactions unconfirmed
```ruby
puts Wallet.new.transactions_unconfirmed
```


### Transactions
```ruby
puts Wallet.new.transactions
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
