# Classe cracker
class Cracker
  require_relative 'connection'
  cracked = []
  f = File.open('american-english', 'r')
  connection = Connection.new

  f.each_line do |line|
    line.strip!
    statuscode = connection.connecter(line)
    if statuscode == 200
      cracked.push(line)
      puts 'Mots de passe corrects: ' + cracked.to_s
    end
  end
  f.close
end
