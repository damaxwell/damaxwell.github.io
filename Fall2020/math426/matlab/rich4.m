
N=2.^[0:5]; 

err = abs(arrayfun( @(n) trap(@(x) sin(x),0,pi,n),N) - 2)

loglog(N,err,'*','linewidth',3)

xlabel('n')
ylabel('error')

p0 = polyfit(log(N),log(err),1);
m0 = p0(1)

