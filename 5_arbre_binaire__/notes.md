#Utilisation de module préféfini: un arbre binaire

##À quoi va ressembler un noeud de l’arbre?
	* Un ensemble de noeuds, contenant une clef, une valeur, un 'pointeur' de noeud inférieur et un 'pointeur' de noeud supérieur.

##Comment bénéficier de toutes les méthodes pour les conteneurs?
	

##Quelles méthode doit donc implémenter l’arbre? Comment l’écrire (algo, pas ruby…).
	* Une méthode d'ajout de "noeud" (duo clef/donnée)
	* Une méthode de parcours
	* Une méthode d'affichage
	* Une méthode de recherche (présence de valeur)
	* Une méthode each

##Comment être sûr de gagner du temps sur les recherches dans l’arbre (rappel, il est trié)?
	* Il est trié, donc on recherche dans la branche qui convient à la recherche, et si on dépasse la valeur attendue il ne sert à rien de continuer.

##Testez.
	* Ok bro