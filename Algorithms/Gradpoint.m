%This function evaluates the gradient of the function 'f', at a point,
%given as a 1x2 row vector.
function GradVal = Gradpoint(f,initial)

f = inline(f);

syms x y

g = gradient(f(x,y),[x,y]);

GradVal = subs(g,[x,y],initial)';


end