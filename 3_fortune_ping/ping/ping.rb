#!/usr/bin/env ruby
# Classe Pinger
class Pinger
  def ping
    lignes = []
    taille_tableau = 20
    # solution shell possible: [cut -d ' ' -f 8]
    IO.popen('ping ' + ARGV[0]) do |tube|
      index = 0
      tube.each_line do |line|
        nettoyer_terminal
        unless index.zero?
          lignes.shift if lignes.length > taille_tableau - 1
          lignes.push(line.split(' ')[7].split('=')[1]).first.to_f
          # puts 'lignes[]: ' + lignes.to_s
          moyenne = calcul_moyenne(lignes).to_s[0..5]
          affichage_terminal(ARGV[0], moyenne)
          fichier_sauvegarde(ARGV[0], moyenne)
          # graphe(ARGV[0], lignes)
        end
        index += 1
      end
    end
  end

  def affichage_terminal(serveur, moyenne)
    puts 'Ping moyen sur le serveur ' + serveur + ': ' + moyenne + ' ms'
    puts 'Ctrl + C pour arrêter'
  end

  def calcul_moyenne(lignes)
    somme = 0.0
    lignes.each do |valeur|
      somme = (somme + valeur.to_f)
    end
    somme / lignes.length
  end

  def fichier_sauvegarde(serv, moy)
    File.open('moyenne_ping.txt', 'a') do |fichier|
      temps = date_precise
      fichier.puts('Le ' + temps + ': serveur: ' + serv + ': ' + moy + ' ms')
    end
  end

  def date_precise
    Time.now.strftime('%d/%m/%Y %H:%M:%S').to_s
  end

  def date_normale
    Time.now.strftime('%d/%m/%Y').to_s
  end

  def nettoyer_terminal
    system('clear')
  end

  def convertisseur_s_f(lignes)
    tableau_floats = []
    lignes.each do |valeur|
      tableau_floats.push valeur.to_f
    end
    tableau_floats
  end

  def graphe(serveur, lignes)
    require 'gruff'
    g = Gruff::Line.new
    date = date_normale
    g.title = 'Ping sur ' + serveur + ' le ' + date
    g.labels = lignes.each_with_index.to_h
    g.marker_font_size = 12
    g.data('Vitesse de ping en ms', convertisseur_s_f(lignes))
    g.write './o.png'
  end
end

Pinger.new.ping
