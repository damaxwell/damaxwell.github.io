function n = countzeros(v)

n = 0;
for j=1:length(v)
  if v(j) == 0 
      n = n + 1;
  end
end

end
