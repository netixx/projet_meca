clear all;

TS= [1.36 3.16; 1.60 4.27; 1.89 5.45; 2.16 6.13; 2.42 6.99; 3.07 8.97; 3.59 10.64; 4.03 12.31; 4.79 16.27; 5.37 20.05; 5.84 23.39; 6.17 27.36; 6.43 30.77; 6.69 34.42; 6.93 38.08; 7.06 42.04; 7.19 45.56; 7.34 49.23; 7.47 53.02; 7.58 56.73; 7.65 64.30];

TP= [1.06 0.80; 1.10 1.55; 1.16 2.17; 1.26 2.79; 1.40 4.03; 1.83 5.88; 2.40 7.55; 3.00 9.53; 3.51 10.95; 4.05 12.68; 4.45 14.66; 5.06 18.00];

TEB= [1.04 2.17; 1.17 3.35; 1.29 4.40; 1.34 4.83; 1.43 5.39; 1.66 6.50; 1.90 7.80; 2.49 9.78; 3.01 12.82; 3.39 14.67; 3.73 17.27; 4.08 20.31; 4.24 22.17; 4.47 24.96];

function [I1,dW]=dWdI1(Essai, lambda1, t1)
dW=0; I1=0;
select Essai
case 'TS' then
    dW = t1 .* lambda1.^2 ./ (lambda1.^3 - 1);
    I1 = lambda1.^2 + 2 ./ lambda1;
case 'TP' then
    dW = t1 .* lambda1.^3 ./ (lambda1.^4 - 1);
    I1 = lambda1.^2 + 1 + 1 ./ lambda1;
case 'TEB' then
    dW = t1 .* lambda1.^5 ./ (lambda1.^6 - 1);
    I1 = 2 * lambda1.^2 + 1 ./ lambda1^2;
end
endfunction

xset("window",1);
xtitle("", "I", "dWdI"); xgrid;
[I1 dW] = dWdI1('TS', TS(:,1), TS(:,2));
plot2d(I1, dW, rect = [0, 0, max(I1)*1.1, max(dW)*1.1], style = -1);
[I1 dW] = dWdI1('TP', TP(:,1), TP(:,2));
plot2d(I1, dW, rect = [0, 0, max(I1)*1.1, max(dW)*1.1], style = -2);
[I1 dW] = dWdI1('TEB', TEB(:,1), TEB(:,2));
plot2d(I1, dW, rect = [0, 0, max(I1)*1.1, max(dW)*1.1], style = -5);

C = 0.84; N = 76.0/3;
I1 = 1:0.1:60;
dW = C .* (9*N - I1) ./ (3*N - I1)
plot2d(I1, dW, style = 2);
