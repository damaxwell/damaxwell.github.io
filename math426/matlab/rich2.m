diffq = @(f,x,h)  (f(x+h) - f(x))./h;

F = @(h) diffq(@(x) sin(x), pi/3, h);

F2 = @(h) 2*F(h/2) - F(h);

F3 = @(h) (F2(h/2) - 1/4*F2(h))/(1-1/4);

h = 10.^(linspace(-3,-1,5))
%h = 10.^(-(1:5))

err1 = abs(F(h)-cos(pi/3));
err2 = abs(F2(h)-cos(pi/3));
err3 = abs(F3(h)-cos(pi/3));

loglog(h,err1,'*',h,err2,'square',h,err3,'o','linewidth',3);


p1 = polyfit(log(h),log(err1),1);
m1 = p1(1)

p2 = polyfit(log(h),log(err2),1);
m2 = p2(1)

p3 = polyfit(log(h),log(err3),1);
m3 = p3(1)
