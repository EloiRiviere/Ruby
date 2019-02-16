# Classe Creature
class Creature
  attr_reader :nom
  attr_accessor :pdv
  attr_writer :compagnie

  def initialize(nom, pdv)
    @nom = nom
    @pdv = pdv
  end

  def encaisser(degats)
    @pdv -= degats.to_int
    puts '[ ' + @nom + ' ]: Aie ! Je suis touché !'

    return if @pdv > 0

    puts '[ ' + @nom + ' ]: Arh ! Je meurs !'
    @compagnie.delete(self)
  end

  def to_s
    @nom.to_s + ' ' + @pdv.to_s
  end

  def soigner(soin)
    @pdv += soin
  end
end
