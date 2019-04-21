# Classe Creature
class Creature
  attr_reader :nom
  attr_reader :tribu
  attr_reader :pdv
  attr_reader :pieces

  def initialize(nom, tribu, pdv, pieces)
    @nom = nom
    @tribu = tribu
    @pdv = pdv
    @pieces = pieces
  end

  def to_s
    @nom + ', de la tribue ' + @tribu + ', ayant ' + @pdv.to_s + ' points de vie et ' + @pieces.to_s + ' pièces d\'or.'
  end
end

# Classe Troll
class Troll < Creature
end

# Classe Humain
class Humain < Creature
end

# Classe Elfe
class Elfe < Creature
end

# Classe Vulcain
class Vulcain < Creature
end

# Classe Wookie
class Wookie < Creature
end

# Classe Gobelin
class Gobelin < Creature
end

# Classe Inconnu
class Inconnu < Creature
end

creatures = []

File.open('pack', 'r') do |fichier|
  fichier.read(127)
  taille_restante = fichier.size - 127

  while taille_restante > 0
    nom_tribu = fichier.read(50).split('/')
    nom = nom_tribu[0]
    tribu = nom_tribu[1]
    classe = fichier.read(1).to_i
    pdv = fichier.read(2).to_i
    pieces = fichier.read(4).to_i

    puts nom
    puts tribu
    puts classe
    puts pdv
    puts pieces

    classe = case classe
             when '0' then Troll
             when '1' then Humain
             when '2' then Elfe
             when '3' then Vulcain
             when '4' then Wookie
             when '5' then Gobelin
             else Inconnu
             end

    creatures.push(classe.new(nom, tribu, pdv, pieces))

    taille_restante -= 57
  end

  creatures.each do |creature|
    puts creature
  end
end
