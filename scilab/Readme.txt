Le repertoire contient 3 fichiers:

- LoisComportement.sce
======================
Definition des dérivées partielles par rapport à I1 (dWdI1) et I2 (dWdI1) pour trois modèles : 
- Néo-Hookeen, 
- Gent,
- Langevin.

Dans ce programme, vous pouvez :
- modifier la valeur des paramères des lois
- rajouter une dépendance en I2 (actuellement dWdI2=0)


- ballon_a_sculpter.sce
=======================
Ce fichier contient l'ensemble des programmes pour la résolution du problème du ballon.


- main.sce
==========
Le programme principale a éxécuter sous Scilab.

Il résout le problème du ballon pour :
- chacun des modèles de comportement et
- différentes valeurs de charge additionnelle (Ta), 

puis trace les deux figures suivantes :


Figure 1: Confrontation des modèles pour une charge additionnelle nulle (Ta=0)
========
- (DP(lambda), lambda)
- (mu(lambda), lambda)
- (DP(lambda), V/Vini)
- (I1(lambda,mu), I2(lambda,mu))

Figure 2: Influence de la charge additionnelle (Ta) pour les chacuns des modeles
========
- (DP(lambda), lambda)
- (mu(lambda), lambda)
