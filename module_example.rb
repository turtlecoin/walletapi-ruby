require_relative 'lib/TurtleCoin'
require 'securerandom'
require 'json'
module TurtleCoin
    @w = Wallet.new
    def self.create_addresses(count=1)
        # default count is 1.
        for i in 1..count.to_i
            @w.create_addresses
        end
        nil
    end
    def self.close
        @w.wallet_close
    end
    def self.auto_on
        # If the wallet is off, it will open the wallet using the
        # log_on method
        j = JSON.parse(@w.status)
        if j.to_h.key?("error")
            puts "Starting wallet.."
            log_on
        end
    end
    def self.status
        # get status
        @w.status
    end
    def self.log_on(filename = @w.filename, password = @w.pass)
        # opens the wallet
        # defaults as the wallet suplied in the config
        @w.open_wallet(filename, password)
    end
    def self.get_balances
        # display the balances & addresses
        JSON.parse(@w.balances).each {|key, value| puts "Address: #{key["address"]}\nUnlocked: #{key["unlocked"]}\nLocked: #{key["locked"]}\n\n"}
    end
    def self.get_addresses_array
        addresses = []
        JSON.parse(@w.list_addresses)["addresses"].each {|addr| addresses << addr }
     return addresses
    end
    def self.get_addresses
        # displays the addresses
        JSON.parse(@w.list_addresses)["addresses"].each {|addr| puts "Address: #{addr}"}
    nil
    end
    def self.get_balance
        @w.balance
    end
    def self.address_count
        # get address count
        JSON.parse(@w.list_addresses)["addresses"].count
    end
    def self.all_addresses
        # list all addresses
        JSON.parse(@w.list_addresses)
    end
    def self.incoming_transcations(addr)
        @w.transactions_unconfirmed_addr(addr)
    end
    def self.create_integrated(addr, hex=nil)
        if hex.nil?
            # this will create an random 64 char hex string
            hex = SecureRandom.hex(32)
        end
        puts "HEX: " + hex
        @w.create_integrated_address(addr, hex)
    end
    def self.set_node(node_port = 11898, node = "TRTLnode.ddns.net")
        @w.set_node(node_port, node)
    end
    def self.create_new_wallet(wallet, pass, node_port = 11898, node = "TRTLnode.ddns.net")
        # This will close the current wallet
        @w.wallet_close
        # Create new wallet
        @w.create_wallet(wallet, pass)
        # we have conncet our wallet to a node
        @w.set_node(node_port, node)
    end
    def self.transactions
        @w.transactions
    end
end
TurtleCoin.set_node
TurtleCoin.auto_on

#puts TurtleCoin.get_addresses
#TurtleCoin.create_integrated(addr, hex=nil)

#TurtleCoin.close
#TurtleCoin.get_addresses
#puts TurtleCoin.get_balance
=begin
trans = TurtleCoin.transactions.to_h
trans.each do |keys, value|
    puts keys.to_s + ": " + value.to_s
end
puts "\n\n"
=end

