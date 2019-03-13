#Classe cracker
class Cracker
	require_relative 'connection'
	cracked = []
	f = File.open("american-english", "r")
	connec = Connection.new

	f.each_line do |line|
		line.strip!
		puts line
		statuscode = connec.connecter(line)
		if (statuscode == 200)
			cracked.push(line)
			p cracked
		end
	end
	f.close
end