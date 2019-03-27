# Class Object
class Object
  class << self
    def attr_getter(attribut)
      define_method(attribut.to_s) do
        instance_variable_get("@#{attribut}")
      end
    end

    def attr_setter(attribut)
      define_method("#{attribut}=") do |value|
        instance_variable_set("@#{attribut}", value)
      end
    end
  end
end

# # Classe de test Chenapan
# class Chenapan
#   def initialize(chenille)
#     @chenille = chenille
#   end
#
#   attr_getter(:chenille)
#   attr_setter(:chenille)
# end
#
# chenapan = Chenapan.new 2
#
# puts chenapan.chenille
#
# chenapan.chenille = 4
#
# puts chenapan.chenille

# Classe Creature
class Creature
  def initialize(nom, pdv)
    @nom = nom
    @pdv = pdv
  end

  attr_getter :nom
  attr_getter :pdv
  attr_setter :pdv

  def tanker(degats)
    degats
  end

  def encaisser(degats)
    @pdv -= tanker(degats)
  end

  def force
    1
  end

  def frapper(other_creature)
    other_creature.encaisser(force)
  end

  def mort?
    @pdv <= 0
  end
end

require 'yaml'

creatures = YAML.load_file('creatures.yml')

# p creatures

def add_method(klass, meth)
  # p "j'ajoute une methode a #{klass.class} : #{meth}"
  klass.class_eval(meth)
end

creatures.each do |creature|
  # p creature
  klass = Class.new(Creature)
  add_method(klass, "define_method(:tanker) { |degats| #{creature['tanker']} }")
  add_method(klass, "define_method(:force) { #{creature['force']} }")
  Object.const_set(creature['nom'], klass)
end

# p Gobelin
# g = Gobelin.new 'gobelin', 17
# g.tanker 10
# g.force
#
# p Troll
# t = Troll.new 'troll', 20
# p t.pdv
# p 'Troll tank 10'
# t.tanker 10
# p t.pdv
# g.force
#
# p Arbre
# a = Arbre.new 'arbre', 20
# a.tanker 10
# a.force

# Module Arene
module Arene
  def self.duel_a_mort(nom, premier_dueliste, second_dueliste)
    puts nom
    while !premier_dueliste.mort? && !second_dueliste.mort?
      premier_dueliste.frapper second_dueliste
      second_dueliste.frapper premier_dueliste
    end
    if premier_dueliste.mort?
      puts premier_dueliste.to_s + ' a gagné !'
    else
      puts second_dueliste.to_s + ' a gagné !'
    end
  end
end

g = Gobelin.new 'gobelin', 17
t = Troll.new 'troll', 20

Arene.duel_a_mort('Duel', g, t)
