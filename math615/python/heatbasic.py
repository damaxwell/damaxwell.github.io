def heatbasic(u0,T,K):
    """
    heatbasic(u0,N,K)

    Solves u_t = u_{xx} for x in [0,1] and t in [0,T]
    subject to boundary conditions u(0)=0, u(1)=0 and
    initial condition u=u0 at t=0.

    Uses N+1 spatial grid points and K time steps.

    Returns a list containing the approximations of u at each time step.
    """
    import numpy as np
    N = len(u0)-1

    dx = 1.0/N;
    dt = T/K;
    x = np.linspace(0,1,N+1)

    u = np.copy(u0)

    u_history = [u]

    A = np.zeros( (N+1,N+1) )
    for i in range(1,N):
        A[i,i-1] = 1;
        A[i,i]   =  -2;
        A[i,i+1] =  1
    A = A * dt/(dx*dx)
    A = A + np.eye(N+1)
    A[0,0] = 0.0;
    A[N,N] = 0.0;

    for k in range(K):
        u = np.dot(A,u)
        u_history.append(u)

    return u_history

def validate(k,N,K):
    import matplotlib.pyplot as pp
    import numpy as np

    x = np.linspace(0,1,N+1)
    u0 = np.sin(k*x*np.pi)
    T = 0.1

    u_hist = heatbasic(u0,T,K)

    pp.plot(x,u_hist[K],x,np.sin(k*x*np.pi)*np.exp(-k*k*np.pi*np.pi*0.1))
    pp.show()

def plot_run(N,K):
    import matplotlib.pyplot as pp
    import numpy as np

    x = np.linspace(0,1,N+1)
    u0 = x*(1.0-x)
    T=0.1
    
    u_hist = heatbasic(u0,T,K)

    dt = 0.1/K
    dx = 1.0/N
    mu = dt/(dx*dx) 
    print("mu=%f\n" % mu)

    x = np.linspace(0,1,N+1)
    pp.plot(x,u_hist[0],x,u_hist[K])
    pp.show()
