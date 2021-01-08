function y=my_sinc(x)
  if x==0 
      y=1;
      return
  end
  y = sin(x)/x;
end