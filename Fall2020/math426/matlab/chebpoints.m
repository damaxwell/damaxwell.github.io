function x=chebpoints(a,b,N)
	j=linspace(-1,1,N+1);
	x_ref=sin(j*pi/2);
	x = a + (x_ref+1)*(b-a)/2;
end
