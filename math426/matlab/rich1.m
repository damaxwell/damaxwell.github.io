diffq = @(f,x,h)  (f(x+h) - f(x))./h;

F = @(h) diffq(@(x) sin(x), pi/3, h);

F2 = @(h) (F(h/2) - 2^(-1)*F(h))/(1-2^(-1));

h = 10.^(-(1:5));

err1 = abs(F(h)-cos(pi/3));
err2 = abs(F2(h)-cos(pi/3));

loglog(h,err1,'*',h,err2,'square','linewidth',2);


p1 = polyfit(log(h),log(err1),1);
m1 = p1(1)

p2 = polyfit(log(h),log(err2),1);
m2 = p2(1)
