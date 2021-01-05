gauss = @(x) exp(-x.^2);
x=[-3:0.1:3];
plot(x,gauss(x),'LineWidth',2);
title("Bell Curve");
