%This function runs a Newtons Method on one variable.
%INPUTS:
%f: The function, entered as a string.
%initial: the initial point to iterate upon.
%epsilon: the tolerance level of the algoritm.

%OUTPUTS:
%argmin: argument of the minimmmum
%min: the minimum of the function
%Table: gives a detailed table containing information of each iteration.
%Here x_k is the point updated, f(x_k) is the evaluated argument, fp(x_k)
%is the first derivative at the argument, and fdp(x_k) is the second
%derivative at the argument.

function [argmin, min, Table] = NewtonMethod(f,initial,epsilon)
%Initialization
X(1) = initial ;
Difference(1)=abs(epsilon+1);
M(1)=evaluate(f,X(1));
k=1;

%Algorithm
while(Difference(k)>epsilon);
    D1(k)=diffpoint(f,1,X(k)); %first derivative
    D2(k)=diffpoint(f,2,X(k)); %seciond derivative
    X(k+1) = X(k) - D1(k)/D2(k); %Updated point
    Difference(k+1)=abs(X(k+1)-X(k)); %updated threshold
    M(k)=evaluate(f,X(k)); %updated evaluation
    k=k+1;
end
argmin = X(end);
min = M(end);
%Table Creation
Cell1=[{'Iteration'},{'x_k'},{'f(x_k)'},{'fp(x_k)'},{'fdp(x_k)'}];
Table=[Cell1;num2cell([1:k-1]'),num2cell(X(1:k-1)'),...
    num2cell(M(1:k-1)'),num2cell(D1(1:k-1)'),num2cell(D2(1:k-1)')];

end