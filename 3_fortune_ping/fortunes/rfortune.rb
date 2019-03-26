#!/usr/bin/env ruby

def check_args
  return true if ARGV.size == 1

  STDERR.puts 'usage: rfortune.rb <fortune_file>'
  false
end

def load
  reader = File.open(ARGV[0], 'r')
  parser reader
end

def parser(reader)
  fortune = []
  while (block = reader.gets('%'))
    fortune.push(block)
  end
  fortune
end

def get_random(fortune_array)
  fortune_array[rand(fortune_array.length)][0..-2] + "\n"
end

exit unless check_args

fortune_array = load

puts get_random fortune_array
