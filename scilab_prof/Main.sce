//*****************************************************************************
// Figure 1: Confrontation des modèles (Ta=Charge additionnelle=0)
// ========
//  - (DP(lambda), lambda)
//  - (mu(lambda), lambda)
//  - (DP(lambda), V/Vini)
//  - (I1(lambda,mu), I2(lambda,mu))
//
// Figure 2: Influence de la charge additionnelle pour les 3 modeles
// ========
//  - (DP(lambda), lambda)
//  - (mu(lambda), lambda)
//
// Modeles de comportement: 
// ************************
// + Neo-Hookeen='NH', Gent='Gent', Langevin='Langevin'  (indépendant de I2)
// + AddI2 = 1 
//   La dependance en I2 est à définir dans LoisComportement.sce
// + AddI2 = 0 == > dW/dI2 = 0
//*****************************************************************************
clear all;
exec('LoisComportement.sce');  
exec ballon_a_sculpter.sce;
NomLoi = ['NH', 'Gent', 'Langevin']; NbLoi = size(NomLoi,"c");

// Parametres
AddI2 = 0;           // Dependance en I2 (0 pour avoir dW/dI2=0)
Epais = 1/30; A=1.;  // Geometrie (rapport E/A) et A
Ta    = [0:3:15];    // Charge axiale additionnelle 

// Domaine d'evolution de Lambda
lambda = [0.4:0.1:6.5];

// Resolution
[DP,Mu,Vol,I1,I2]=SolveBallon(lambda, Ta, Epais, A, AddI2);
 
// Tracer des courbes
// //////////////////
DpMax=0.15; 
LambdaMax=max(lambda);
// Figure 1: Comparaison modele pour Ta=0
// ////////
xset("window",1);
for kk=1:NbLoi,
  loi =NomLoi(kk);
  Nbplot=220;
  subplot(Nbplot+1);   // Tracer de DeltaP(Lambda)
  xtitle("DeltaP = DeltaP(lambda) (Ta=0) - ", "lambda", "DeltaP (bars)"); xgrid;
  plot2d(lambda, [DP(:,1,kk)], style =kk, rect = [0,0,LambdaMax,DpMax]);
  legends([NomLoi(1:NbLoi)],[1:NbLoi],[2,0.9*DpMax]);
  subplot(Nbplot+3);  // Tracer de DeltaP(V/V_ini);
  xtitle(" DeltaP = DeltaP(V/V_ini) (Ta=0) ", "V/V_ini", "DeltaP (bars)"); xgrid;
  plot2d(Vol(:,1), DP(:,1,kk), style =kk, rect = [0,0,250,DpMax]);
  legends([NomLoi(1:NbLoi)],[1:NbLoi],[50,0.9*DpMax]);
  subplot(Nbplot+2);  // Tracer de Mu(Lambda);
  xtitle(" Mu = Mu(Lambda) (Ta=0) - ", "lambda", "mu"); xgrid;
  plot2d(lambda, [Mu(:,1,1)], style =kk, rect = [1,1,,LambdaMax,LambdaMax]);  
  subplot(Nbplot+4);   // Tracer chargement dans le plan (I_1, I_2)
  xtitle("Evolution dans le plan (I1, I2) (Ta=0)", "I1", "I2"); xgrid;
  plot2d(I1(:,1,kk), [I2(:,1,kk)], style = kk, rect = [0,0,60,400]);
end;
// 
// Figure 2: Influence de la charge additionnelle (Ta)
// ////////
xset("window",2);
for kk=1:NbLoi,
  loi =NomLoi(kk);
  subplot(200+NbLoi*10+kk);   //Tracer de DeltaP(Lambda);
  xtitle("Modele="+NomLoi(kk), "lambda", "DeltaP (bars)");  xgrid;
  xstring(0.1,0.9*DpMax , "Influence Ta/(pi.A.E) = [0, 3, 6, 9, 12, 15] bar");
  plot2d(lambda, DP(:,:,kk), rect = [0,0,LambdaMax,DpMax]);
  subplot(200+NbLoi*10+kk+NbLoi); //Tracer de Mu(Lambda);
  xtitle("Modele="+NomLoi(kk), "lambda", "Mu"); xgrid;
  plot2d(lambda, Mu(:,:,kk), rect = [0,1,LambdaMax,LambdaMax]);
  xstring(0.1,0.9*LambdaMax, "Influence Ta/(pi.A.E) = [0, 3, 6, 9, 12, 15] bar");
end;
