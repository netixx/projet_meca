// /////////////////////
// Enveloppe cylindrique
// /////////////////////
// //////////
// Invariants // Question 5
// //////////
function [I1,I2]=Invariants(lambda, mu)
 I1 = lambda^2 + mu^2 + 1/(lambda*mu)^2;
 I2 = 1/lambda^2 + 1/mu^2 + (lambda*mu)^2;
endfunction
// ///////////
// Contraintes // Question 6
// ///////////
function y = sigtt(Loi, AddI2,lambda, mu)
  [I1,I2] = Invariants(lambda, mu);
  [dWdI1,dWdI2]=dWdI(Loi, AddI2, I1, I2);
  y = (dWdI1 + dWdI2* mu^2)*(lambda^2 - 1./(lambda*mu)^2);
endfunction
function y = sigzz(Loi, AddI2, lambda, mu)
  [I1,I2] = Invariants(lambda, mu);
  [dWdI1,dWdI2]=dWdI(Loi, AddI2, I1, I2);
  y = (dWdI1 + dWdI2* lambda^2)*(mu^2 - 1./(lambda * mu)^2);
endfunction
// //////////////
// Delta pression // Question 7
// //////////////
function y = DeltaPression(Loi, AddI2, Epais, A, lambda, mu)
y = Epais / (mu * lambda^2 ) * sigtt (Loi, AddI2, lambda, mu);
endfunction
// ///////////////////////////
// charge axiale additionnelle // Question 7
// ///////////////////////////
function y = AxialAdd(Loi, AddI2, Epais, A, lambda, mu)
y = pi * A^2 * (2. * Epais / mu * sigzz (Loi, AddI2, lambda, mu) - lambda^2 * DeltaPression(Loi, AddI2, Epais, A, lambda, mu) );
endfunction
// ///////////////////////////////////
// pression normalisee par E/A = Epais
// ///////////////////////////////////
function y = DeltaPressionNorm(Loi, AddI2, Epais, A, lambda, mu)
y = 1. / (mu * lambda^2 ) * sigtt (Loi, AddI2, lambda, mu);
endfunction
// ////////////////////////////////////////////////////////////////
// charge axiale additionnelle normalisee par pi E A = Pi Epais A^2
// ////////////////////////////////////////////////////////////////
function y = AxialAddNorm(Loi, AddI2, Epais, A, lambda, mu)
y = 2. * sigzz (Loi, AddI2, lambda, mu) / mu - lambda^2 * DeltaPressionNorm(Loi, AddI2, Epais, A, lambda, mu) ;
endfunction
//
// //////////////////////////////////////////////////////////////////
// Solve Ballon : Calcul de DP, MU, I1, I2 et Vol=V/V_ini=mu*lambda^2
// //////////////////////////////////////////////////////////////////
function [DP, Mu, Vol, I1, I2]=SolveBallon(lambda, Ta, Epais, A, AddI2)
NomLoi = ['NH', 'Gent', 'Langevin']; NbLoi = size(NomLoi,"c");
DP = zeros(size(lambda,"c"), size(Ta,"c"), NbLoi);
Mu = zeros(size(lambda,"c"), size(Ta,"c"), NbLoi);
Vol = zeros(size(lambda,"c"), size(Ta,"c"), NbLoi);
I1 = zeros(size(lambda,"c"), size(Ta,"c"), NbLoi);
I2 = zeros(size(lambda,"c"), size(Ta,"c"), NbLoi);
for kk=1:NbLoi,
  loi =NomLoi(kk);
  j = 0;
  for Tai=Ta,
    j = j+1;
    i = 0;
    for lambdai=lambda, 
      i = i+1;
      deff('y=fsol(x)','y=AxialAddNorm(loi, AddI2, Epais, A, lambdai, x)-Tai');
      mui = fsolve (1,fsol);
      DP(i,j,kk) = DeltaPression(loi, AddI2, Epais, A, lambdai, mui);
      Mu(i,j,kk) = mui;
      Vol(i,j,kk) = mui*lambdai^2;
      [I1(i,j,kk),I2(i,j,kk)]=Invariants(lambdai,mui);
    end;
  end;  
end;
endfunction;

