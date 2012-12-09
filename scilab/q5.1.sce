clf();
clear I1
clear I2
//print(%io(2), "coucou")
lambdamax = 5;
lambda = 1.1:0.01:lambdamax;
//print(%io(2), lambda);

lalpha = [-0.5, 0, 1];
colors = [4, 2 ,5];

for i = 1:3
    alpha = lalpha(i);
    //    print(%io(2), alpha);
    I1(:,i) = (lambda.^2 + lambda.^(2 * alpha) + lambda.^-2*(alpha +1))';

    I2(:,i) = (lambda.^(-2) + lambda.^(2* (alpha +1)) + lambda.^(-2 * alpha))';
end

plot2d(I1, I2, style=colors, leg="alpha=-0.5@alpha=1@alpha=0");
xtitle("(I1, I2) pour lambda entre 0 et "+string(lambdamax));
