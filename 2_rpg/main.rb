# Classe main
class Main
  require_relative 'creature'
  require_relative 'troll'
  require_relative 'gobelin'
  require_relative 'compagnie'
  # roger = Creature.new('Roger', 10)
  # profi = Troll.new('Profitroll', 7)

  les_joyeux_de_la_couronne = Compagnie.new

  # gruk = Troll.new('Gruk', 27)
  # grok = Troll.new('Grok', 24)
  # zak = Gobelin.new('Zak', 12)
  # zog = Gobelin.new('Zog', 13)
  #
  # les_joyeux_de_la_couronne.ajouter_crea(gruk)
  # les_joyeux_de_la_couronne.ajouter_crea(grok)
  # les_joyeux_de_la_couronne.ajouter_crea(zak)
  # les_joyeux_de_la_couronne.ajouter_crea(zog)

  les_joyeux_de_la_couronne.charger

  puts les_joyeux_de_la_couronne
  les_joyeux_de_la_couronne.exploration
end
