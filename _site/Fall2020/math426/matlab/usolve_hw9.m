function x=usolve_hw9(U,b)
	[n,m] = size(U);
	if n~=m
		error("matrix is not square")
	end

	x = zeros(n,1);
	for i=n:-1:1
		x(i) = 0;
		for j=n:-1:i+1
			x(i) = x(i) - U(i,j)*x(j);
		end
		x(i) = x(i) + b(i);
		x(i) = x(i) / U(i,i);
	end

end
