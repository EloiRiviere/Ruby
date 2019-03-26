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
		res = Net::HTTP.start(uri.hostname, uri.port) { |http|
		  http.request(req)
		}

		# puts "Mot de passe testé: " + @pwd
		# puts "Code de retour: " + res.code

		if res.code.to_i == 200
			puts res.body
		end

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
