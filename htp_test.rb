require 'json'
require "fileutils"
require 'securerandom'
require_relative 'lib/TurtleCoin'
class Json_temp
    def initialize(user = nil)
        if not user.nil?
            @user = User
        end
    end
    def json
        json = {
            "payment_id": SecureRandom.hex(32),
            "credits": "6"
        }.to_json
    end
end
class Users
    J    = Json_temp.new
    def initialize(user)
        @user = user
        FileUtils.mkdir_p(File.join("users", @user))
        if !(File.exist?(File.join("users", @user, "info.json")))
            File.open(File.join("users", @user, "info.json"), 'w') { |file| file.write(J.json) }
        end
    end
    def payment_id
        r = File.join("users", @user, "info.json")
        j = JSON.parse(File.read(r))["payment_id"]
    end
    def get_integrated
        w     = Wallet.new
        addr  = w.create_integrated_address("TRTLuxL46JJa4bTYMyQGLi4euHoe3QUNQQ5niiPoYah15pc6ESFdZJ59KmtDUzedHASfDRYPxVbEpYQsXUtBmQRL18pDdK72F5i", payment_id)
        j     = JSON.parse(addr)["integratedAddress"]
    end
    def add_credits
        r = File.join("users", @user, "info.json")
        j = JSON.parse(File.read(r))
        c = j["credits"].to_i
        c += 6
        j["credits"] = c
    File.open(File.join("users", @user, "info.json"), 'w') { |file| file.write(j.to_json) }
    end
    def remove_credit
        r = File.join("users", @user, "info.json")
        j = JSON.parse(File.read(r))
        c = j["credits"].to_i
        c -= 1
        j["credits"] = c
    File.open(File.join("users", @user, "info.json"), 'w') { |file| file.write(j.to_json) }
    end
end

k = Users.new("Mc")
puts k.remove_credit