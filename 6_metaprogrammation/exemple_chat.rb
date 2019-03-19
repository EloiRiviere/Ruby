class Chat
  def initialize(couleur='calico')
    # le chat a une couleur mais pas d'attr_reader pour y accéder
    @couleur = couleur
  end

  # -- Méthode d'instance --
  def miauler
    puts 'Maouu'
  end

  # -- Méthode de classe --
  # on ajoute la méthode #tout_le_monde sur la classe Chat,
  # qui est ici l'objet représentant la classe Chat
  # Cette façon d'ajouter des méthodes de classe n'est pas préférable du tout
  def Chat.tout_le_monde
    puts 'Tout le monde veut devenir un cat...'
  end

  # on ajoute la méthode #parce_que sur la classe Chat encore une fois,
  # qui est représenté par self ici, vu qu'on est dans la classe Chat
  # Cette façon d'ajouter des méthodes de classe est un peu mieux
  def self.parce_que
    puts "Parce qu'un chat quand il est cat"
  end

  # on ouvre non pas la classe mais la métaclasse,
  # l'objet qui représente la classe Chat
  class << self
    # on ajoute la méthode #retombe
    # Cette façon d'ajouter des méthode de classe est la plus préférable (convention)
    def retombe
      puts 'Retombe sur ses pattes'
    end
  end

  protected
  def ronronner
    puts '*ronron*'
  end
end

# Ruby interprête le code partout sauf lorsqu'on est dans un bloc qui n'est pas explicitement
# appelé, par exemple dans une méthode ou un bloc.
# Donc, par exemple.

puts 'Yay, on a lu la classe Chat' # => affichera bien la string ici

class Chat
  blah = "Thomas"
  puts "#{blah} a dit que:" # affichera bien, on interprête le code au fur et à mesure
                            # que le code est lu
  # on peut appeler les méthodes de classe de la classe Chat ici
  # car self est ici l'objet de la classe Chat
  self.tout_le_monde
  # comme d'habitude, le self est facultatif
  parce_que
  retombe
end

# -- Contextes d'évaluation --
c = Chat.new
# on peut forcer le chat à miauler (en lui tirant la queue par exemple)
c.miauler
# parce contre on ne peut pas le forcer à ronronner
# c.ronronner => méthode privée !

# avec eval, on évalue du code arbitrairement, rappelez vous, eval c'est le mal
eval('c.miauler')

c.instance_eval do
  # ici dans ce bout de code, je suis comme si j'étais
  # dans une des méthodes d'une instance de chat
  # on peut appeler les méthodes publiques sur le chat
  self.miauler
  # le self est facultatif, comme si on était dans une classe

  # mais aussi les méthodes privées vu qu'on est "comme si" on était dans une des méthodes du chat
  ronronner

  # j'ai aussi accès en toute logique aux attributs du chat
  puts "Couleur: " + @couleur
end

Chat.class_eval do
  # ici dans ce bout de code, je suis comme si j'étais
  # dans l'objet classe Chat, on peut donc appeler les méthodes de classe
  tout_le_monde
  attr_reader :couleur # j'ajoute un attr_reader sur la couleur par exemple

  def hisser
    puts 'HhhHHhiiiisss'
  end
end

# du coup, on peut appeler couleur sur le chat
puts c.couleur

# et on a une méthode hisser sur le chat
# (toujours en lui tirant la queue mais cette fois un peu plus fort)
c.hisser
# Si je veux ajouter une méthode de classe à la classe Chat dynamiquement
# je vais contextualiser mon évaluation à l'instance de l'objet représentant la classe Chat
Chat.instance_eval do
  def les_plus_beaux_chats
    puts 'Calicos !'
  end
end

Chat.les_plus_beaux_chats

# -- définition de méthodes dynamiques --
# Ajoutons une méthode de classe afficheur, qui génére une méthode qui permet d'afficher un attribut
class Object
  class << self
    def afficheur(attribut)
      # #define_method est une méthode présente sur les objets de type Class, donc présente ici
      define_method("afficher_#{attribut}") do # si la méthode prend des paramètres,
                                               # le bloc aussi en prend
        # je vous laisse comprendre ce bout de code avec la documentation
        puts instance_variable_get("@#{attribut}".to_sym)
      end
    end
  end
end

class Chat
  afficheur :couleur
end

# la couleur du chat
c.afficher_couleur # affiche la couleur du chat