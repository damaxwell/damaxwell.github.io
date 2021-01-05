

Q2 = @(n) trap(@(x) sin(x),0,pi,n);

Q4 = @(n) (Q2(2*n) - 1/4*Q2(n))/(1-1/4);

Q6 = @(n) (Q4(2*n) - 1/2^4*Q4(n))/(1-1/2^4);

Q8 = @(n) (Q6(2*n) - 1/2^6*Q6(n))/(1-1/2^6);

N=2.^[0:5]; 

err2 = abs(arrayfun(Q2,N)-2);
err4 = abs(arrayfun(Q4,N)-2);
err6 = abs(arrayfun(Q6,N)-2);
err8 = abs(arrayfun(Q8,N)-2);

loglog(N,err2,'*',N,err4,'square',N,err6,'o',N,err8,'-','linewidth',3)

xlabel('n')
ylabel('error')

p2 = polyfit(log(N),log(err2),1);
m2 = p2(1)

p4 = polyfit(log(N),log(err4),1);
m4 = p4(1)

p6 = polyfit(log(N),log(err6),1);
m6 = p6(1)

p8 = polyfit(log(N),log(err8),1);
m8 = p8(1)

