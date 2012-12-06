// ////////////////
// dW/dI1 et dW/dI2
// ////////////////
function [dWdI1,dWdI2]=dWdI(Loi, AddI2, I1, I2)
dWdI1=0.; dWdI2=0.;
select Loi
  case 'NH' then   // Neo-Hookeen
    C1NH = 1.5;
    dWdI1 = C1NH ; 
    select AddI2   // Ajouter une dépendance en I2
      case 1 then
        dWdI2 = 0.;
      end
  case 'Gent' then  // Gent
    C1G= 1.5; Jm = 60;
    if (I1-3 < 0.999999*Jm)
       dWdI1 = C1G /(1 - ( I1 -3)/Jm) 
    else
       dWdI1 = 1000000*C1G
    end ;
    select AddI2   // Ajouter une dépendance en I2
      case 1 then
        dWdI2 = 0.;
      end
    case 'Langevin' then  // Langevin
    C1L = 0.5; troisNL = 63;
    if (I1< 0.999999*troisNL)
       dWdI1 = C1L *(3-(I1/troisNL))/(1 - (I1/troisNL)) 
    else
       dWdI1 = 1000000*C1L
    end ;
    select AddI2   // Ajouter une dépendance en I2
      case 1 then
        dWdI2 = 0.;
      end
    end
endfunction
