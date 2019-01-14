#####################################
#
# heatbasic(u0,T,K)
#
# Solves u_t = u_{xx} for x in [0,1] and t in [0,T]
# subject to boundary conditions u(0)=0, u(1)=0 and
# initial condition u=u0 at t=0.
# 
# Uses N+1 spatial grid points and K time steps,
# where N+1 is the length of the vector u0.
#
# Returns a matrix U where U(:,k) is the approximation
# at time step k.
function U = heatbasic(u0,T,K)

	[a,b] = size(u0);
	if a == 1
		u0 = transpose(u0);
	end

	N = length(u0)-1;

	dx = 1.0/N;
	dt = 0.1/K;
	x = linspace(0,1,N+1);

	u = u0;

	U = u;

	A = zeros( N+1,N+1 );
	for i = [2:N]
		A(i,i-1) = 1;
		A(i,i) =  -2;
		A(i,i+1) =  1;
	end
	A = A * dt/(dx*dx);
	A = A + eye(N+1);
	A(1,1) = 0.0;
	A(N+1,N+1) = 0.0;

	for k = [1:K]
		u = A*u;
		U = [U,u];
	end
end

