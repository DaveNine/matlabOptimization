function [argmin,min] = secantMethod(f ,y1,y2, epsilon,max_its)
X=sym('x',1);
Y(1) = y1; 
Y(2) = y2;
N(1:2) = 1;
fp = matlabFunction(diff(eval(f)));
k=2;
while(abs(N(k))>epsilon && k < max_its)
    Y(k+1) = Y(k) - ((Y(k) - Y(k-1))./ (fp(Y(k)) - fp(Y(k-1)))).*fp(Y(k));
    N(k+1)=fp(Y(k));
    k = k + 1;
end
argmin = Y(end);
min = generalEval(f,1,Y(end));
end

