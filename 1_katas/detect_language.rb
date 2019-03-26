require 'json'

def check_args
  return true if ARGV.size == 1

  STDERR.puts 'usage: detect_language.rb <text_file>'
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

def charger_mots_vides(fichier)
  File.read fichier do |f|
    JSON.parse(f)
  end
end

def json_string_to_hash(json_string)
  JSON.parse(json_string)
end

def charger_fichier_texte(fichier)
  mots = []
  File.open(fichier).each do |ligne|
    normalize(ligne).split(' ').each do |mot|
      next unless mot.size > 1

      mots.push mot unless mots.include? mot
    end
  end
  mots
end

def calcul_intersections(hash_reference, tableau_mots)
  hash_intersections = {}
  hash_reference.keys.each do |key|
    hash_intersections[key] = (hash_reference[key] & tableau_mots).size
  end
  hash_intersections
end

def detect_language(hash_intersections)
  hash_intersections.sort_by { |_clef, valeur| valeur }.reverse.first
end

def affichage(langue)
  puts 'Detected language: ' + langue[0].to_s
end

exit unless check_args

fichier_mots_vides = 'stop_words.json'

fichier = ARGV[0]

hash_reference = json_string_to_hash(charger_mots_vides(fichier_mots_vides))

tableau_mots = charger_fichier_texte fichier

hash_intersections = calcul_intersections hash_reference, tableau_mots

langue = detect_language hash_intersections

affichage langue
