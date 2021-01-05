function Q=trap(f,a,b,N)
	h = (b-a)/N;

	% Quadrature points
	pts = [0,h];

	% Quadrature weights

	wts = [1/2;1/2]*h;

	Q = 0;
	for k=1:N
		ipts = a + h*(k-1) + pts;
		Q = Q + arrayfun(f,ipts)*wts;
	end
end
