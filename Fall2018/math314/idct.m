function d = idct(x)
  N = length(x);

  # Account for row or column vectors
  mn=size(x);
  if mn(1)<mn(2)
    xx = x';
  else
    xx = x;
  end


  d=zeros(N,1);
  t0=1/(2*N);
  dt = 1/N;
  s0=sqrt(N/2);
  t = t0+[0:N-1]'/N;
  
  for j=1:N
    if j==1
      s = sqrt(N);
    else
      s = s0;
    end
    
    d = d + x(j)*cos((j-1)*pi*t)/s;

  end

  # Account for row or column vectors
  if mn(1)<mn(2)
    d = d';
  end

end
