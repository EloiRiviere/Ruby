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
 
  def to_s()
    print "Clef = ", @clef, " Donnée = ", @donnee
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
 
  def visiter()
    visiter_profondeur(0)
  end
 

  def visiter_profondeur(profondeur)
    if not @gauche.nil?
      @gauche.visiter_profondeur(profondeur+1)
    end     
 
 	afficher_noeud(@clef,@donnee,profondeur)
 
    if not @droit.nil?
      @droit.visiter_profondeur(profondeur+1)
    end
  end

  def afficher_noeud(clef,donnee, profondeur)
    profondeur.times { print "  " }
    puts "-> #{@clef} = #{@donnee}"
  end

  def is_clef? clef
  	if(@clef == clef)
  		return true
  	elsif(@clef < clef)
  		if(@gauche.nil?)
  			return false
  		end
  		return @gauche.is_clef?(clef)
  	else
  		if(@droit.nil?)
  			return false
  		end
  		return @droit.is_clef?(clef)
  	end
  end

  def is_value? value
	p any? { |valueur, clef| valueur == value }
  end

  def each (&block)
  	if(!@gauche.nil?)
  	  @gauche.each(&block)
  	end

  	block.yield(@donnee,@clef)

  	if(!@droit.nil?)
  	  @droit.each(&block)
  	end
  end

  def taille
  	p 'Taille arbre: ' + count.to_s
  end
 
end
 

arbre = Arbre.new(1, "un")
arbre.add(2, "deux")
arbre.add(3, "trois")
arbre.add(-1, "moins un")
arbre.add(1.5, "un virgule cinq")
 
arbre.visiter()

puts arbre.is_clef?(1)
puts arbre.is_clef?(0)

arbre.each do |value, cle|
	puts ({ value: value, cle: cle })
end

arbre.taille

arbre.is_value? "un"