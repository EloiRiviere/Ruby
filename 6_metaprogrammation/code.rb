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
    @pv <= 0
  end
end
