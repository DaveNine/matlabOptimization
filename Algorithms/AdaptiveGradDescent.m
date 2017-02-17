%This function runs a Adaptive alpha Gradient Descent algorithm.
%INPUTS:
%f: The function, entered as a string.
%initial: the initial point to iterate upon, given as a 1x2 row vector.
%epsolon: the tolerance level of the algoritm.

%OUTPUTS:
%argmin: argument of the minimmmum
%min: the minimum of the function
%Table: gives a detailed table containing information of each iteration.
%Here x_0 and x_1 are the updated points, f(x) is the evaluated point, and
%Norm is the distance from the previous iterated point to the current one.

function [argmin, min,Table] = AdaptiveGradDescent(f,initial, epsilon, max_its)

syms x;
%Initialization
X(1,:)=initial;
N(1)=1; %initizes threshold test
M(1) = evaluate3(f,X(1,:));
f1=f;
f1=inline(f1);
k=1;

%Algorithm
hold on
while(N(k) > epsilon && k<=max_its)
    g=Gradpoint(f,X(k,:));
    if (g == 0)
        break;
    end
    h=char(f1(X(k,1)-x*g(1),X(k,2)-x*g(2))); %turns f into a string to use in NewtonMethod
    A(k) = NewtonMethod(h,0,.003);  % Chooses the new alpha.
    X(k+1,:) = X(k,:) - A(k)*Gradpoint(f,X(k,:)); %updates the new point
    N(k+1) = norm(X(k+1,:) - X(k,:)); %updates threshold value
    M(k+1) = evaluate3(f,X(k+1,:)); %evaluates f at the new point
    scatter3(X(k,1),X(k,2),M(k),'fillied','k');
    drawnow;
    k = k + 1;
end
hold off
min = M(end);
argmin = X(end,:);

%Table Creation
j=0:k-1;
Cell1=[{'Iteration'},{'x_0'},{'x_1'},{'f(x_i)'},{'Norm'}];
Table=[Cell1; num2cell(j'),num2cell(X(:,1)),num2cell(X(:,2)),...
    num2cell(M'),num2cell(N')];

end