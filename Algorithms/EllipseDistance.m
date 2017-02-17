%This file takes in the function you wish to minimize or maximize.
%This file is then used in GoldenSearch or NewtonSearch
%Can change to the upper half of the Ellipse by using
%Y=Y=(5-(2/3)*(1-X.^2).^(1/2)).^2 +(1-X).^2;

function [Y]=EllipseDistance(X)
Y=(5+(2/3)*(1-X.^2).^(1/2)).^2 +(1-X).^2;
end
