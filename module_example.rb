require_relative 'lib'
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
end

puts TurtleCoin.create_addresses
#puts TurtleCoin.get_balance
#puts TurtleCoin.all_addresses
puts TurtleCoin.address_count