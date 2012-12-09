
TS= [1 0; 1.36 3.16; 1.60 4.27; 1.89 5.45; 2.16 6.13; 2.42 6.99; 3.07 8.97; 3.59 10.64; 4.03 12.31; 4.79 16.27; 5.37 20.05; 5.84 23.39; 6.17 27.36; 6.43 30.77; 6.69 34.42; 6.93 38.08; 7.06 42.04; 7.19 45.56; 7.34 49.23; 7.47 53.02; 7.58 56.73; 7.65 64.30];

TP= [1 0; 1.06 0.80; 1.10 1.55; 1.16 2.17; 1.26 2.79; 1.40 4.03; 1.83 5.88; 2.40 7.55; 3.00 9.53; 3.51 10.95; 4.05 12.68; 4.45 14.66; 5.06 18.00];

TEB= [1 0; 1.04 2.17; 1.17 3.35; 1.29 4.40; 1.34 4.83; 1.43 5.39; 1.66 6.50; 1.90 7.80; 2.49 9.78; 3.01 12.82; 3.39 14.67; 3.73 17.27; 4.08 20.31; 4.24 22.17; 4.47 24.96];

deff('yhat=Homo(p,x)', 'yhat=p(1)./(x-p(2))');

function t1=findt1(Essai, lambda1)
dW=0; I2=0;
dW1=0; I1=0;
C=0.84; TN=76;
A=3.4823868;
B=0.6123068;
select Essai
case 'TS' then
    I1 = lambda1.^2 + 2../ lambda1;
    I2 = 2 * lambda1 + 1../lambda1.^2;
    dW1 = C * (3*TN - I1) ./ (TN - I1);
    dW2 = Homo([A B], I2);
    t1 = 1../lambda1.^2 .* (dW1 + dW2 ./ lambda1) .* (lambda1.^3 - 1);
case 'TP' then
    I1 = lambda1.^2 + 1 + 1../lambda1;
    dW1 = C * (3*TN - I1) ./ (TN - I1);
    I2 = lambda1.^2 + 1../lambda1.^2 + 1;
    dW2 = Homo([A B], I2);
    t1 = 1../lambda1.^3 .* (dW1 + dW2) .* (lambda1.^4 - 1);
case 'TEB' then
    I1 = 2 * lambda1.^2 + 1../lambda1.^2;
    dW1 = C * (3*TN - I1) ./ (TN - I1);
    I2 = lambda1.^4 + 2../lambda1.^2;
    dW2 = Homo([A B], I2);
    t1 = 1../lambda1.^5 .* (dW1 + dW2 .* lambda1.^2) .* (lambda1.^6 - 1);
end
endfunction

xset("window",1);
xtitle("TS", "lambda1", "t1"); xgrid;
plot2d(TS(:,1), TS(:,2), style = -1);
lambdas= 1:0.1:max(TS(:,1))*1.01;
t1=findt1('TS', lambdas);
plot2d(lambdas, t1, rect = [0, 0, max(lambdas), max(t1)*1.1], style = 2);

xset("window",2);
xtitle("TP", "lambda1", "t1"); xgrid;
plot2d(TP(:,1), TP(:,2), style = -2);
lambdas= 1:0.1:max(TP(:,1))*1.01;
t1=findt1('TP', lambdas);
plot2d(lambdas, t1, rect = [0, 0, max(lambdas), max(t1)*1.1], style = 2);

xset("window",3);
xtitle("TEB", "lambda1", "t1"); xgrid;
plot2d(TEB(:,1), TEB(:,2), style = -3);
lambdas= 1:0.1:max(TEB(:,1))*1.01;
t1=findt1('TEB', lambdas);
plot2d(lambdas, t1, rect = [0, 0, max(lambdas), max(t1)*1.1], style = 2);
