#!/usr/bin/env ruby

def lire
  fortune = []
  reader = File.open(ARGV[0], 'r')
  while block = reader.gets('%')
    fortune.push(block)
  end
  puts fortune[rand(fortune.length)][0..-2] + "\n"

  # File.open('chucknorris').each do |line|
  #  if(line != "%\n")
  #    fortune.push(line)
  #  end
  # end
  # puts fortune[rand(fortune.length)]
  # puts fortune
end
# Classe Rfortune
class Rfortune
  lire
end
