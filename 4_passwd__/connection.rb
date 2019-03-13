# Classe Connection
require 'net/http'
class Connection
	def initialize
		@pwd
	end
	def connecter(pwd)
		@pwd = pwd
		uri = URI('http://localhost:7654/epreuve')
		req = Net::HTTP::Get.new(uri)
		req.basic_auth 'admin', pwd
		res = Net::HTTP.start(uri.hostname, uri.port) {|http|
		  http.request(req)
		}
		puts "tested password :" + @pwd
		puts res.body
		puts "code de retour :" + res.code
		return res.code.to_i
	end
end

#uri = URI('http://localhost:7654/epreuve')

#req = Net::HTTP::Get.new(uri)
#req.basic_auth 'admin', 'admin'

#res = Net::HTTP.start(uri.hostname, uri.port) {|http|
#  http.request(req)
#}

#puts res.body
#puts "code de retour :" + res.code