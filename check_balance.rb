require_relative 'lib'
require 'json'
w = Wallet.new.balance
j = JSON.parse(w)
j["unlocked"] = 100
if j["unlocked"].to_i > 0
    puts "TRTL: #{j["unlocked"]}"
end



JSON.parse(Wallet.new.balances).each do |l|
    if l["unlocked"].to_i > 0
        puts "#{l["address"]} has #{l["unlocked"]} TRTL"
    end
end