%This function runs a Fixed alpha Gradient Descent algorithm.
%INPUTS:
%f: The function, entered as a string.
%initial: the initial point to iterate upon, entered as a 1x2 row vector.
%alpha: the specified step size of the algorithm
%epsolon: the tolerance level of the algoritm.

%OUTPUTS:
%argmin: argument of the minimmmum
%min: the minimum of the function
%Table: gives a detailed table containing information of each iteration.
%Here x_0 and x_1 are the updated points, f(x) is the evaluated point, and
%Norm is the distance from the previous iterated point to the current one.
function [argmin,min,Table] = FixedGradDescent(f,initial,alpha,epsilon,num_its)

%initialization
X(1,:)=initial;
N(1)=1;
M(1) = evaluate3(f,X(1,:));
k=1;
%algorithm
hold on
while(N(k) > epsilon && k<=num_its-1)
    X(k+1,:) = X(k,:) - alpha*Gradpoint(f,X(k,:)); %updates the argument
    N(k+1) = norm(X(k+1,:) - X(k,:)); %updates threshold
    M(k+1) = evaluate3(f,X(k+1,:)); %updates evaluated point
    scatter(X(k,1),X(k,2),'fillied','k');
    drawnow;
    k = k + 1;
   
end
hold off
min = double(M(end));
argmin = X(end,:);
%Table Creation
j=0:k-1;
Cell1=[{'Iteration'},{'x_0'},{'x_1'},{'f(x)'},{'Norm'}];
Table=[Cell1; num2cell(j'),num2cell(X(:,1)),num2cell(X(:,2)),...
    num2cell(M'),num2cell(N')];

end