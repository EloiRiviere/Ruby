# Classe Gobelin
class Gobelin < Creature
  def encaisser(degats)
    super(degats / 2)
  end
end
