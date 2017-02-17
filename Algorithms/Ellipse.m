%This creates the matrix for the Ellipse.
%The second input takes 'North' or 'South' depending on which part of the
%ellipse you want to use.

function [ Y ] = Ellipse( X, NorthSouth )

if(strcmp(NorthSouth,'north'))
    Y = (2/3)*(1-X.^2).^(1/2);
end
if(strcmp(NorthSouth,'south'))
    Y = -(2/3)*(1-X.^2).^(1/2);
end

end

