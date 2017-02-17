%computes the derivative, gradient, or hessian of a given general function
%f = function, written as elements of X in a string.
%x = point to be evaluated.
%m = # variables of f
%n = nth derivative
function  [C] = diffpoint2(f,x,m,n)

X = sym('x',[1,m]);

if (m == 1)
    fp = matlabFunction(diff(eval(f),n));
    C = fp(x);
end
if (m > 1 && n == 1)
    fp = matlabFunction(gradient(eval(f),X));
    args = num2cell(x);
    C = fp(args{:});  
end

if (m > 1 && n == 2)
    fpp = hessian(eval(f),X);
    C = subs(fpp,X,x);
end