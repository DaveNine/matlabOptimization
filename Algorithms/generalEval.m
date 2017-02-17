%takes a function f as a string, in terms of X(1),X(2),..X(n)
%for example f = ('X(1).^2+X(2).^2+X(3).^2' is a function of 3 variables.
%n is the number of variables of f
%x is the desired vector to evaluate at.

function c = generalEval(foo,n,x)
X = sym('x',[1,n]);
h(X(1:n)) = eval(foo);
H = matlabFunction(h);
args=num2cell(x);
c = H(args{:});
end