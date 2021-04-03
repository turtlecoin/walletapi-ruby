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
    def self.create_integrated(addr, hex=nil)
        if hex.nil?
            # this will create an random 64 char hex string
            hex = SecureRandom.hex(32)
        end
        puts "HEX: " + hex
        @w.create_integrated_address(addr, hex)
    end
    def self.transactions
        @w.transactions
    end
end

trans = TurtleCoin.transactions.to_h
trans.each do |keys, value|
    puts keys.to_s + ": " + value.to_s
end
puts "\n\n"

