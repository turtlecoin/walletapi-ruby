require_relative 'lib/TurtleCoin'
task :income do
    w = Wallet.new
    
    #w.open_wallet("wallet.wallet", "derby3333")
    #w.set_node(11898, "TRTLnode.ddns.net")
    puts w.list_addresses
    puts w.transactions_unconfirmed
end