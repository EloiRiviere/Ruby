def check_args
  if !ARGV.empty? && ARGV.size <= 2
    if ARGV.size == 2
      return '-l' if ARGV[0] == '-l'

      STDERR.puts 'option invalide: ' + ARGV[0].to_s
      return false
    end
    return true
  end
  STDERR.puts 'usage: frequency.rb [-option] <text_file>'
  false
end

def normalize(ligne)
  ligne = ligne.tr("'", ' ').delete(',').delete('.').downcase
  ligne = ligne.gsub(/[àáâãäåāăą]/, 'a')
  ligne = ligne.gsub(/[çćĉċč]/, 'c')
  ligne = ligne.gsub(/[éèëêēĕėęě]/, 'e')
  ligne = ligne.gsub(/[ìíîï]/, 'i')
  ligne = ligne.gsub(/[ñ]/, 'n')
  ligne = ligne.gsub(/[òóöôõ]/, 'o')
  ligne = ligne.gsub(/[ùúûü]/, 'u')
  ligne.gsub(/[ýÿ]/, 'y')
end

def nettoyage_tableau(tableau)
  tableau.delete ' '
  tableau.delete "\n"
  tableau
end

def insertion(dictionnaire, mot)
  if dictionnaire.key?(mot)
    dictionnaire[mot] + 1
  else
    1
  end
end

def occurences_mots(dictionnaire, ligne)
  mots = ligne.split(' ')
  mots.each do |mot|
    next unless mot.size >= 3

    dictionnaire[mot] = insertion dictionnaire, mot
  end
end

def occurences_lettres(dictionnaire, ligne)
  lettres = nettoyage_tableau ligne.chars
  lettres.each do |lettre|
    dictionnaire[lettre] = insertion dictionnaire, lettre
  end
end

def charger(methode, fichier)
  Hash dictionnaire = {}
  File.open(fichier).each do |ligne|
    case methode
    when 'mots'
      occurences_mots dictionnaire, (normalize ligne)
    when 'lettres'
      occurences_lettres dictionnaire, (normalize ligne)
    end
  end
  dictionnaire
end

def tri(dictionnaire)
  dictionnaire.sort_by { |_mot, occurences| occurences }.reverse
end

def affichage(tableau, nombre)
  nombre.times do |index|
    puts tableau[index][0].to_s + ': ' + tableau[index][1].to_s
  end
end

check_args_value = check_args
exit unless check_args_value

case check_args_value
when true
  fichier = ARGV[0]
  dictionnaire = charger 'mots', fichier
when '-l'
  fichier = ARGV[1]
  dictionnaire = charger 'lettres', fichier
end

tableau = tri dictionnaire

affichage tableau, 20
