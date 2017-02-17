%This function is the 3 dimensional analog of evaluate. It will take a
%function 'f' as a string, along with xbar, entered as a 1x2 row vector.
%Future support will include application to a function of n variables.

function [C] = evaluate3(f,xbar)

f = inline(f);

syms x y

C = subs(f(x,y),[x,y],xbar);

end