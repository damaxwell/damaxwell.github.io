% // # Lower-triangular matrix solve
% // # 
% // # Returns the solution x of Lx=b where L is square and lower-triangular.
% // #
% // # E.g.
% // # 
% // # L = [1 0 0; -2 1 0; 1 2 1];
% // # b = [1 ; -1; 2 ];
% // #
% // # x = lsolve(L,b)  -> x = [1; 1; -1 ]

function x=lsolve(L,b)
	n=size(L,1);
	m=size(L,2);
	if n~=m
		error("matrix is not square")
	end

	x = zeros(n,1);
	for k=1:n
		rhs = b(k);
		for j=1:k-1
			rhs = rhs - L(k,j)*x(j);
		end
		x(k) = rhs/L(k,k);
	end

end
