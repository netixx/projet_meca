Le repertoire contient 3 fichiers:

- LoisComportement.sce
======================
Definition des d�riv�es partielles par rapport � I1 (dWdI1) et I2 (dWdI1) pour trois mod�les : 
- N�o-Hookeen, 
- Gent,
- Langevin.

Dans ce programme, vous pouvez :
- modifier la valeur des param�res des lois
- rajouter une d�pendance en I2 (actuellement dWdI2=0)


- ballon_a_sculpter.sce
=======================
Ce fichier contient l'ensemble des programmes pour la r�solution du probl�me du ballon.


- main.sce
==========
Le programme principale a �x�cuter sous Scilab.

Il r�sout le probl�me du ballon pour :
- chacun des mod�les de comportement et
- diff�rentes valeurs de charge additionnelle (Ta), 

puis trace les deux figures suivantes :


Figure 1: Confrontation des mod�les pour une charge additionnelle nulle (Ta=0)
========
- (DP(lambda), lambda)
- (mu(lambda), lambda)
- (DP(lambda), V/Vini)
- (I1(lambda,mu), I2(lambda,mu))

Figure 2: Influence de la charge additionnelle (Ta) pour les chacuns des modeles
========
- (DP(lambda), lambda)
- (mu(lambda), lambda)
