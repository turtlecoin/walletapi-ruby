require_relative 'module_example'
require 'rufus-scheduler'
require 'set'
SCHEDULER = Rufus::Scheduler.new
=begin
while true
    
    SCHEDULER.every "5s" do
        puts TurtleCoin.transactions
        puts TurtleCoin.incoming_transcations("TRTLuxwSHzLHmBRpupBRmaAQB1u25LyxAHbZAmx1dp5rCF19Msj79L7CaN9UYQDPHTA4hJJfqa7juCF5YpGZpCtpCRA3gRudT9VX4ciECoAgi2eUCoQMyitAUdyPteJrSm16CH6MEPCTrx63s9FqwnUzpbKMjaATQrpvyb1fxcLnGBEfH3DtsyQsCfs")
    end
end
=end
=begin
g = TurtleCoin.transactions["transactions"]
puts g[-1]["paymentID"]
=end



#puts g["transactions"]["transfers"]

=begin
while true
    g = TurtleCoin.transactions["transactions"]
    if g[-1]["hash"] != "9795272cd9628f1bef7f45225d44f42d465e7a445b1f6e06ec084c3194727766"
        puts g[-1]["paymentID"]
        exit
    end
end
=end
class ExtractKey
    def get_key(key)
        key.split(//)[24..63].join
    end
end
class DeletePayment
    def initialize(payment_id)
        @payment_id = payment_id
        read        = File.read("waiting_payment.txt")
        File.open('waiting_payment.txt', 'w') do |out_file|
            File.foreach('waiting_payment.txt').with_index do |line,line_number|
                out_file.puts line if not read.match?(@payment_id)
            end
        end
    end
end
class AddPayment
    def initialize(fingerprint)
        @fingerprint = fingerprint
        File.open(File.join("paid.txt").to_s, 'a') { |file| file.write("\n" + @fingerprint) }
    end
end
# reads the waiting_payment.txt
puts "starting..."
while true
    puts "02f15c85066a012d67fb2acc5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34".upcase
    read = File.read("waiting_payment.txt").split
    p read
    TurtleCoin.transactions["transactions"].each do |l|
        if read.include?(l['paymentID'])
            k       = ExtractKey.new
            finger  = k.get_key(l['paymentID'])
            puts "Deleting payment id from waiting_payment"
            DeletePayment.new(l['paymentID'])
            puts "Payment finished. -- adding to paid.txt"
            AddPayment.new(finger)
        end
    end
    sleep 10
end
