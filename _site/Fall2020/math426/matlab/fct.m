function y=fct(k)
% 
%  Computes k! (k factorial)
%
%
%  Example:
%
%  Input: fct(5)
%
%  Output: 120

y = 1;
for j=1:k
    y = y * j;
end

end