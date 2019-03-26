# Classe Compagnie
class Compagnie
  def initialize
    @compagnie = []
  end

  def charger
    File.open('personnages.don').each do |line|
      elements = line.split(',')
      case elements.first
      when 'Gobelin'
        klass = Gobelin
      when 'Troll'
        klass = Troll
      end
      ajouter_crea(klass.new(elements[1], elements[2].to_i))
    end
  end

  def ajouter_crea(creature)
    @compagnie.each do |compagnon|
      if compagnon.nom == creature.nom
        raise 'Créature déja présente dans la compagnie'
      end
    end
    @compagnie.push creature
    creature.compagnie = self
    puts '*** ' + creature.nom + ' a rejoint la compagnie ! ***'
  end

  def to_s
    compagnie_str = '*** La compagnie est composée de '
    @compagnie.each do |compagnon|
      if compagnon == @compagnie.last
        compagnie_str = compagnie_str[0..-3] + ' et ' + compagnon.nom + ' ! ***'
      else
        compagnie_str += compagnon.nom + ', '
      end
    end
    compagnie_str
  end

  def exploration
    puts '*** ' + @compagnie.first.nom + ' pose le pied sur une dalle de couleur étrange et déclenche un piège ! ***'
    @compagnie.first.encaisser 10
    puts '*** ' + @compagnie[2].nom + ' passe devant ! ***'
    placer_eclaireur(@compagnie[2])
    puts '*** Une trappe s’ouvre sous les pieds de ' + @compagnie[1].nom + ' ! ***'
    @compagnie[1].encaisser 14
    puts '*** La compagnie trouve une potion de soins ! ***'
    soin_au_plus_faible(5)
    puts '*** Au détour d’un couloir mal éclairé, ' + @compagnie.first.nom + ' marche sur une rune étrange sournoisement dissimulée sous un tapis. la compagnie entière s’embrase de façon très esthétique.'
    degats_groupe(10)
    puts to_s
    puts '*** Alerté par le bruit de l’explosion, le grand et vil Zangdar s’approche de la compagnie et lance une malédiction de Kozysar. ***'
    degats_groupe(kozysar)
    puts "*** La compagnie se réagence dans l'ordre décroissant des points de vie. ***"
    reagencement_ordre_decroissant_pvs
    puts '*** La compagnie arrive enfin à portée de massue de Zangdar ! ***'
    (0..4).each do |_i|
      puts '*** Zangdar tire un rayon lunaire ! ***'
      @compagnie.first.encaisser 5
    end
    puts '*** Zangdar fait un échec critique et se bannit tout seul dans les limbes. ***'
    puts decompte_survivants
    0
  end

  def delete(creature)
    @compagnie.delete creature
  end

  def placer_eclaireur(creature)
    delete(creature)
    @compagnie.insert(0, creature)
    puts '[ ' + creature.nom + " ]: D'accord, je passe devant !"
  end

  def soin_au_plus_faible(soin)
    plus_faible = @compagnie.first
    @compagnie.each do |compagnon|
      plus_faible = compagnon if plus_faible.pdv > compagnon.pdv
    end
    puts '[ ' + plus_faible.nom + " ]: D'accord ! Je me soigne ! Merci !"
    plus_faible.soigner soin
  end

  def degats_groupe(degats)
    @compagnie.each do |compagnon|
      compagnon.encaisser degats.to_int
    end
  end

  def kozysar
    points_de_vie_du_groupe = 0
    @compagnie.each do |compagnon|
      points_de_vie_du_groupe += compagnon.pdv
    end
    points_de_vie_du_groupe * 0.15
  end

  def reagencement_ordre_decroissant_pvs
    @compagnie.sort_by! { |compagnon| -compagnon.pdv }
  end

  def decompte_survivants
    compagnie_str = '*** '
    @compagnie.each do |compagnon|
      if compagnon == @compagnie.last
        compagnie_str = compagnie_str[0..-3] + ' et ' + compagnon.nom + ' ont sont survécus avec respectivement '
      else
        compagnie_str += compagnon.nom + ', '
      end
    end
    @compagnie.each do |compagnon|
      if compagnon == @compagnie.last
        compagnie_str = compagnie_str[0..-3] + ' et ' + compagnon.pdv.to_s + ' points de vie !'
      else
        compagnie_str += compagnon.pdv.to_s + ', '
      end
    end
    compagnie_str
  end
end
