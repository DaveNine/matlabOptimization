%This function finds the best known minimum of f, a function handle,
%amongst data, X.

function best = bestKnown(f,X)

best = X(1,:);

for i = 1:size(X,1)
    argB = num2cell(best);
    argX = num2cell(X(i,:));
    if(f(argB{:}) > f(argX{:})) 
        best = X(i,:);
    end
end
end