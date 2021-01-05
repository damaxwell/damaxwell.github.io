diffqc = @(f,x,h)  (f(x+h) - f(x-h))./(2*h);

F2 = @(h) diffqc(@(x) sin(x), pi/3, h);

F4 = @(h) (F2(h/2) - 1/4*F2(h))/(1-1/4);

F6 = @(h) (F4(h/2) - 1/2^4*F4(h))/(1-1/2^4);

h = 10.^(linspace(-1.3,-1,5))
% h = 10.^(linspace(-3,-1,5))

err2 = abs(F2(h)-cos(pi/3));
err4 = abs(F4(h)-cos(pi/3));
err6 = abs(F6(h)-cos(pi/3));

loglog(h,err2,'*',h,err4,'square',h,err6,'o','linewidth',3);


p2 = polyfit(log(h),log(err2),1);
m2 = p2(1)

p4 = polyfit(log(h),log(err4),1);
m4 = p4(1)

p6 = polyfit(log(h),log(err6),1);
m6 = p6(1)
