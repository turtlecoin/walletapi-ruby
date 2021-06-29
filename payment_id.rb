require 'securerandom'

=begin

def generate_pay_id
    c = "5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34"
    c = "C0A8A21FA10681B1D9D61819FC628EA55993925E"
    h = SecureRandom.hex(32)
    t = h.split(//)[0..63 - c.length.to_i  ].join
    f =  t + c
    return f
end


def get_user_id(f)
    puts f
    return f.split(//)[24..63].join
end
f = generate_pay_id
f = "69db58946ab0d31ef4a00fb1c0a8a21fa10681b1d9d61819fc628ea55993925e"
k = get_user_id(f)
puts k.upcase
=end
require 'json'
require 'TurtleCoin'

class GenPayId
    def initialize(fingerprints)
        @fingerprints = fingerprints
    end
    def fingerprints
        @fingerprints
    end
    def hex
        SecureRandom.hex(32)
    end
    def generate_payid
        payid = hex.split(//)[0..63 - fingerprints.length.to_i ].join
    return payid + fingerprints
    end
end




class SavePayment
    def initialize(payment_id)
        @payment_id = payment_id.downcase
        puts "PPPP> #{@payment_id}"
        File.open(File.join("waiting_payment.txt").to_s, 'a') { |file| file.write("\n" + @payment_id) }
    end

end
w       = Wallet.new
payid   = GenPayId.new("5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34").generate_payid
addr    = w.address_primary.to_h["address"]
address = JSON.parse(w.create_integrated_address(addr, payid))["integratedAddress"]
puts "#{payid}"
puts "New address: #{address}\n"
SavePayment.new(payid)

#payid   = GenPayId.new("5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34").generate_payid
#DeletePayment.new("0741d73f3fa7c0634e2a98285AC5C5D28F1DE43CA2AB60733478C7E0057ADA34")


# puts payid
# puts "GPG fingerprint: #{pay}"
