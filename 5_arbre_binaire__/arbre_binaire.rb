#!/usr/bin/ruby

class Arbre
  include Enumerable

  attr_accessor :donnee

  def initialize(clef, donnee)
    @gauche = nil
    @droit = nil
    @clef = clef
    @donnee = donnee
  end

  def to_s
    print 'Clef = ', @clef, ' Donnée = ', @donnee
  end

  def add(clef, donnee)
    if clef < @clef
      if @gauche.nil?
        @gauche = Arbre.new(clef, donnee)
      else
        @gauche.add(clef, donnee)
      end
    elsif clef > @clef
      if @droit.nil?
        @droit = Arbre.new(clef, donnee)
      else
        @droit.add(clef, donnee)
      end
    else
      @donnee = donnee
    end
  end

  def visiter
    visiter_profondeur(0)
  end

  def visiter_profondeur(profondeur)
    @gauche.visiter_profondeur(profondeur + 1) unless @gauche.nil?

    afficher_noeud(@clef, @donnee, profondeur)

    @droit.visiter_profondeur(profondeur + 1) unless @droit.nil?
  end

  def afficher_noeud(_clef, _donnee, profondeur)
    profondeur.times { print '  ' }
    puts "-> #{@clef} = #{@donnee}"
  end

  def is_clef?(clef)
    if @clef == clef
      true
    elsif @clef < clef
      return false if @gauche.nil?

      @gauche.is_clef?(clef)
    else
      return false if @droit.nil?

      @droit.is_clef?(clef)
    end
  end

  def is_value?(value)
    p any? { |valueur, _clef| valueur == value }
  end

  def each(&block)
    @gauche.each(&block) unless @gauche.nil?

    block.yield(@donnee, @clef)

    @droit.each(&block) unless @droit.nil?
  end

  def taille
    p 'Taille arbre: ' + count.to_s
  end
end

arbre = Arbre.new(1, 'un')
arbre.add(2, 'deux')
arbre.add(3, 'trois')
arbre.add(-1, 'moins un')
arbre.add(1.5, 'un virgule cinq')

arbre.visiter

puts arbre.is_clef?(1)
puts arbre.is_clef?(0)

arbre.each do |value, cle|
  puts ({ value: value, cle: cle })
end

arbre.taille

arbre.is_value? 'un'
