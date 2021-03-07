require 'excon'
require 'json'
class ReadConfig
    def initialize(config = nil)
        if config.nil?
            config = File.join("data", "config.json")
        end
        @config = config
    end
    def config
        read = @config
        JSON.parse(File.read(read))
    end
end
class HTTP < ReadConfig
    def initialize
        @ip    = ReadConfig.new.config["ip"] + ":" + ReadConfig.new.config["daemonPort"]
        @dPort = ReadConfig.new.config["daemonPort"]
        @dHost = ReadConfig.new.config["daemonHost"]
        @fn    = ReadConfig.new.config["filename"]
        @pass  = ReadConfig.new.config["password"]
        @key   = ReadConfig.new.config["X-API-KEY"]
    end
    def ip
        @ip
    end
    def dhost
        @dHost
    end
    def dport
        @dPort
    end
    def filename
        @fn
    end
    def pass
        @pass
    end
    def key
        @key
    end
    def post(meth, j = nil)
        p "#{j.to_json}"
        l = Excon.post(File.join(ip,meth), :headers => { 'accept'       => "application/json", 'X-API-KEY'    => key}, :body => j.to_json).body
    end
    def get(meth)
        l = Excon.get(File.join(ip, meth), :headers => {'accept'       => "application/json",  'X-API-KEY'    => key, 'X=Content-Type' => 'application/json'}).body
    l
    end
    def put(meth, new_port, new_ip)   
        j = {'daemonHost': "#{new_ip}",'daemonPort': new_port.to_i}.to_json
        l = Excon.put(File.join(ip, meth),  :headers => {'accept' => "application/json", 'X=Content-Type' => 'application/json', 'X-API-KEY'    => key}, :body => j ).body
    end
    def delete(meth)
        l = Excon.delete(File.join(ip, meth), :headers => { "accept" => "application/json", 'X-API-KEY' => key}).body
    end
end
class Helper < HTTP
    def json(j)
        out_json = "daemonHost=#{dhost}&daemonPort=#{dport}&filename=#{filename}&password=#{pass}&"
        j.each do |keys, value|
            out_json += "#{keys}=#{value}&"
        end
    out_json
    end
end
class Wallet < HTTP
    H = Helper.new
    def open_wallet(filename, password)
        post('/wallet/open', {"daemonHost": dhost, "daemonPort": dport.to_i, "filename": filename, "password": password})
    end
    def wallet_close
        # closes the wallet
        delete("wallet")
    end
    def create_wallet(filename, password)
        # create new wallet.
        # Needs filename & password for file
        post('/wallet/create', { "daemonHost": dhost, "daemonPort": dport.to_i, "filename": filename, "password": password})
    end
    def create_addresses
        # CREATES A NEW ADDRESS
        post('/addresses/create')
    end
    def list_addresses
        # Gets a list of all the addresses in the wallet container
        get('/addresses')
    end
    def wallet_addresses_import_view(public_spend_key, scan_height = 300000)
        # Imports a view only subwallet with the given publicSpendKey
        post('/addresses/import/view', { "scanHeight": scan_height, "publicSpendKey": public_spend_key })
    end
    def wallet_addresses_import(private_spend_key, scan_height = 300000)
        # Imports a subwallet with the given private spend key
        # scan_height is set as '300000' by default.
        post('addresses/import', { "scanHeight": scan_height, "privateSpendKey": "#{private_spend_key}"}.to_json)
    end
    def node
        # Get the nodes address, port, fee and fee address
        get('/node')
    end
    def save
        # Save the wallet state
        put('/save')
    end
    def balance
        # Get the balance for the entire wallet container
        get('/balance')
    end
    def balance_address(addr)
        # Get the balance for a specific address
        get("/balance/#{addr}")
    end
    def balances
        get('/balances')
    end
    def address_primary
        # gets the primary address
        get('/addresses/primary')
    end
    def set_node(port, ip)
        # Sets the node address & port
        put('/node', port, ip)
    end
    def status
        get('/status')
    end
    def keys_address(addr)
        # Gets the public & private spend key for a given address.
        # Note: it cant be used with a view only wallet
        get("/keys/#{addr}")
    end
    def keys
        # Gets the wallet containers shared private view key
        get('/keys')
    end
    def keys_mnemonic(addr)
        # Gets the mnemonic seed for the given address. 
        # NOTE: can't be used with only a view only wallet.
        get("/keys/mnemonic/#{addr}")
    end

    def wallet_import_view(private_view_key, addr, scan_height = 300000)
        j = H.json({ "scanHeight": scan_height, "privateViewKey": private_view_key, "address": addr})
        # Imports a view only wallet with a private view key and public address. 
        post('/wallet/import/view',  j )
    end
    def export_json(filename)
        j = { "filename" => filename }
        post('/export/json', j.to_json )
    end
    def transactions_unconfirmed_addr(addr)
        # Gets a list of all unconfirmed, outgoing transactions in the wallet container
        # Note that this DOES NOT include incoming transactions in the pool.
        # This only applies to transactions that have been sent by this wallet file, and have not been added to a block yet.
        get("/transactions/unconfirmed/#{addr}")
    end
    def transactions_unconfirmed
        # Gets a list of all unconfirmed, outgoing transactions in the wallet container
        get('/transactions/unconfirmed')
    end
    def transactions
        # Gets a list of all transactions in the wallet container
        get('/transactions')
    end

end


#puts Wallet.new.balance_address("TRTLuxL46JJa4bTYMyQGLi4euHoe3QUNQQ5niiPoYah15pc6ESFdZJ59KmtDUzedHASfDRYPxVbEpYQsXUtBmQRL18pDdK72F5i")
w  = Wallet.new
js = w.list_addresses
JSON.parse(js).each do |key, value|
    puts value
end
#puts Wallet.new.create_wallet("fuckthegovt.wallet", "fuckthegovt")
#puts Wallet.new.create_wallet("fuckthegovt.wallet", "fuckthegovt")

#puts Wallet.new.set_node("11898",  "TRTLnode.ddns.net")
#puts Wallet.new.create_addresses
#puts Wallet.new.status
#Wallet.new.addresses_import("5c703d9bde0b7cd5ff3e19ea826a44066534661a7322c85e854e73f06e49cd06")
#Wallet.new.open_wallet
#ReadConfig.new.get_address
#Wallet.new.keys_mnemonic("TRTLuxL46JJa4bTYMyQGLi4euHoe3QUNQQ5niiPoYah15pc6ESFdZJ59KmtDUzedHASfDRYPxVbEpYQsXUtBmQRL18pDdK72F5i")
#puts Wallet.new.transactions_unconfirmed
#t = Wallet.new
#puts t.create_addresses

#t.wallet_import_view("9b40ced5414a943cb06427c83730d4a3c38d98cceff4dc1a16c631f0697c141a", 300000)

