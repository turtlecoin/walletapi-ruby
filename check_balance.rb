require_relative 'lib'
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

puts Wallet.new.list_addresses


