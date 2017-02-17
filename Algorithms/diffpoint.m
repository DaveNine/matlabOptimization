%This function returns the nth derivative at a point of the given function.

%INPUTS:
% f: the function you wish to differentiate. Input as a STRING, i.e. 'x^2'
% n: nth derivative, n>=1.
% x_0: the point at which you want to differentiate.


function [C]=diffpoint(f,n,x_0)

f=inline(f);

syms x;

C = double(subs(diff(f(x),n),x_0));

end