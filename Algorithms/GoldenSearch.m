%This script runs a Golden Section Search with the CostFunctionion.m file
%as the CostFunctionion you wish to minimize or maximize. The inputs are:
%CostFunction: the function you wish to minimize/maximize, created in a seperate
% .m file.
%epsilon: threshold for the interval size where the maxima is.
%leftEnd: the left endpoint of the nitial search interval
%rightEnd: the right endpoint of the initial search interval
%searchType: either 'maximum' or 'minimum' to run the desired


function [argext,extrema,Table] = GoldenSearch(f,epsilon,leftEnd,rightEnd,searchType)
format short;

rho=(3-sqrt(5))/2;
%Initialization
A(1)=leftEnd+rho*(rightEnd-leftEnd); %initializes a_0
B(1)=leftEnd+(1-rho)*(rightEnd-leftEnd); %initialized b_0
NewInt(1,:)=[leftEnd,rightEnd]; %Initializes Interval of certainty
Difference(1)=rightEnd-leftEnd; %Initializes first interval measure
Min(1)=evaluate(f,(rightEnd+leftEnd)/2); %approximate minimum arg of interval
i=1;
%Algorithm
if (strcmp(searchType,'maximum') == 1) %maximum version
    while(abs(Difference(i))>=epsilon) %iterates until interval is within epsilon size.
        
        if(evaluate(f,A(i)) > evaluate(f,B(i)))
            rightEnd=B(i);
            NewInt(i+1,:)=[leftEnd,rightEnd];
            B(i+1)=A(i);
            A(i+1)=leftEnd+rho*(B(i)-leftEnd);
            
        end
        
        if(evaluate(f,A(i)) < evaluate(f,B(i)))
            leftEnd=A(i);
            NewInt(i+1,:)=[leftEnd,rightEnd];
            A(i+1)=B(i);
            B(i+1)=leftEnd+(1-rho)*(rightEnd-A(i));
        end
        
        if(evaluate(f,A(i))) == evaluate(f,B(i))
            break; %stops the while loop if for some reason we get lucky
        end
        fA(i)=evaluate(f,A(i));
        fB(i)=evaluate(f,B(i));
        i=i+1;
        Min(i)=evaluate(f,(rightEnd+leftEnd)/2);
        Difference(i)=rightEnd-leftEnd;
        
    end   
end

if(strcmp(searchType,'minimum') == 1) %minimum version
    while(abs(Difference(i))>=epsilon) %iterates until interval is epsilon away
        
        if(evaluate(f,A(i)) < evaluate(f,B(i)))
            rightEnd=B(i);
            NewInt(i+1,:)=[leftEnd,rightEnd];
            B(i+1)=A(i);
            A(i+1)=leftEnd+rho*(B(i)-leftEnd);
            
        end
        
        if(evaluate(f,A(i)) > evaluate(f,B(i)))
            
            leftEnd=A(i);
            NewInt(i+1,:)=[leftEnd,rightEnd];
            A(i+1)=B(i);
            B(i+1)=leftEnd+(1-rho)*(rightEnd-A(i));
        end
        
        if(evaluate(f,A(i)) == evaluate(f,B(i)))
            break; %stops the while loop if for some reason we get lucky
        end
        fA(i)=evaluate(f,A(i));
        fB(i)=evaluate(f,B(i));
        i=i+1;
        Min(i)=evaluate(f,(rightEnd+leftEnd)/2); %approximate minimum
        Difference(i)=rightEnd-leftEnd;
        
        
    end
end

 %Print the table
 k=1:i-1;
 Cell1=[{'Iteration'},{'A'},{'B'},{'f(A)'},{'f(B)'},{'NewIntA'},{'NewIntB'}];
 Table=[Cell1;num2cell(k'),num2cell(A(1:i-1)'),num2cell(B(1:i-1)'),num2cell(fA(1:i-1)')...
     num2cell(fB(1:i-1)'),num2cell(NewInt(2:i,:))];
 
 argMin=(NewInt(:,2)+NewInt(:,1))/2; %approximate minimum

%other outputs
extrema=evaluate(f,argMin(end));
argext=argMin(end);
end
