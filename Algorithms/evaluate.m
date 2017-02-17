%This function evaluates the function at the given point. f must be entered
%as a string.

function C = evaluate(f,x_0)
f=inline(f);
syms x;

C = double(subs(f(x),x_0));

end