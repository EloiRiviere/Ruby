#!/usr/bin/env ruby

# Classe Pinger
class Pinger
  TAILLE_MAX_TABLEAU = 20

  def initialize
    @lignes = []
    @host = ARGV[0]
  end

  def ping
    # solution shell possible: [cut -d ' ' -f 8]
    IO.popen('ping ' + @host) do |tube|
      tube.each_line.with_index do |line, index|
        nettoyer_terminal
        next if index.zero?

        moyenne = push(line)
        affichage_terminal(moyenne)
        fichier_sauvegarde(moyenne)
      end
    end
  end

  private

  def push(line)
    @lignes.shift if @lignes.length > TAILLE_MAX_TABLEAU - 1
    @lignes.push(line.split(' ')[7].split('=')[1]).first.to_f
    calcul_moyenne.to_s[0..5]
  end

  def affichage_terminal(moyenne)
    puts 'Ping moyen sur le serveur ' + @host + ': ' + moyenne + ' ms'
    puts 'Ctrl + C pour arrêter'
  end

  def calcul_moyenne
    somme = 0.0
    @lignes.each do |valeur|
      somme = (somme + valeur.to_f)
    end
    somme / @lignes.length
  end

  def fichier_sauvegarde(moy)
    File.open('moyenne_ping.txt', 'a') do |fichier|
      temps = date_precise
      fichier.puts('Le ' + temps + ': serveur: ' + @host + ': ' + moy + ' ms')
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

  def convertisseur_s_f
    @lignes.map(&:to_f)
  end

  def graphe(serveur)
    require 'gruff'
    g = Gruff::Line.new
    date = date_normale
    g.title = 'Ping sur ' + serveur + ' le ' + date
    g.labels = @lignes.each_with_index.to_h
    g.marker_font_size = 12
    g.data('Vitesse de ping en ms', convertisseur_s_f)
    g.write './o.png'
  end
end

Pinger.new.ping
