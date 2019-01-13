function x = dct(d)
  N = length(d);

  % Account for row or column vectors
  mn=size(d);
  if mn(1)<mn(2)
    dd = d';
  else
    dd = d;
  end
  x=zeros(N,1);
  t0=1/(2*N);
  dt = 1/N;
  s0=sqrt(N/2);
  t = t0+[0:N-1]/N;
  
  for j=1:N
    if j==1
      s = sqrt(N);
    else
      s = s0;
    end
    
    x(j) = (cos((j-1)*pi*t)*dd)/s;

  end

  % Account for row or column vectors
  if mn(1)<mn(2)
    x = x';
  end

end
