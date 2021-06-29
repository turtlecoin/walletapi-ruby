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
        l = Excon.post(File.join(ip,meth), :headers => { 'accept'  => "application/json", 'X-API-KEY'    => key, "Content-Type" => "application/json"}, :body => j.to_json).body
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
        l = Excon.delete(File.join(ip, meth), :headers => { "accept" => "application/json", 'X-API-KEY'    => key}).body
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
        delete("/wallet")
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
    def create_integrated_address(address, payment_id)
        get('/addresses/' + address + "/" + payment_id)
    end
    def import_seed(mnemonic_seed, scan_height = 3472695)
        j = H.json({"daemonHost": dhost, "daemonPort": dport.to_i, "filename": filename, "password": pass, "scanHeight": scan_height, "mnemonicSeed": mnemonic_seed})
        post('/wallet/import/seed')
    end
    def wallet_import_view(private_view_key, addr, scan_height = 3472695)
        # Imports a view only wallet with a private view key and public address. 
        j = H.json({"daemonHost": dhost, "daemonPort": dport.to_i, "filename": filename, "password": pass, "scanHeight": scan_height, "privateViewKey": private_view_key, "address": addr})
        post('/wallet/import/view',  j )
    end
    def wallet_addresses_import_view(public_spend_key, scan_height = 3472695)
        # Imports a view only subwallet with the given publicSpendKey
        post('/addresses/import/view', { "scanHeight": scan_height, "publicSpendKey": public_spend_key })
    end
    def wallet_addresses_import(private_spend_key, scan_height = 3472695)
        # Imports a subwallet with the given private spend key
        # scan_height is set as '3472695' by default.
        post('addresses/import', { "scanHeight": scan_height, "privateSpendKey": private_spend_key})
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
        JSON.parse(get('/addresses/primary'))
    end
    def set_node(port, ip)
        # Sets the node address & port
        # public nodes list can be found @ https://explorer.turtlecoin.lol/nodes.html
        put('/node', port, ip)
    end
    def status
        get('/status')
    end
    def keys_address(addr)
        # Gets the public & private spend key for a given address.
        # Note: it cant be used with a view only wallet
        JSON.parse(get("/keys/#{addr}"))
    end
    def keys
        # Gets the wallet containers shared private view key
        get('/keys')
    end
    def keys_mnemonic(addr)
        # Gets the mnemonic seed for the given address. 
        # NOTE: can't be used with only a view only wallet.
        JSON.parse(get("/keys/mnemonic/#{addr}"))
    end


    def export_json(filename)
        post('/export/json', { 'filename': filename } )
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
        JSON.parse(get('/transactions'))
    end
    def transcation_send_basic(addr, amount)
        j = { "destination" => addr, "amount" => amount }
        post('/transaction/send/basic', j.to_json)
    end
end



