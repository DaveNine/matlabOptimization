%This function takes in a funciton, f as a function handle and performs a
%Naive Random Search in order to find the minimum of the function.

function argmin = NRandomSearch(f,varargin)

%Initialization

j = nargin(f);
k = 1;

% Initialize defaults and incorporate given optional arguments
num_opt_args = length(varargin);
optional_args = {[-3,-2],10, 1000,[-5,5],'uniform', 1,.75, 1};
optional_args(1:num_opt_args) = varargin;       %override defaults with givens
[initial, alpha, num_its, sear_area,...
    nbhd_opts, cool, cool_param, plot] = optional_args{:};

X(1,:) = initial;

if(plot == 1)
    hold on
    [T,U] = meshgrid(-5:.5:5,-5:.5:5);
    W = arrayfun(f,T,U);
    surf(T,U,W);
end

%scatter3(T(:),U(:),W(:),'filled','b')
while( k <= num_its)
    
    %neigborhood options
    if(strcmp(nbhd_opts,'uniform')==1)
        i=1;
        
        while (i<=j)
            Z(k,i) = (X(k,i)-alpha)+(2*alpha)*rand(1);
            i = i + 1;
            %search area
            if(isempty(sear_area)==0)
                
                if( (Z(k,i-1) > sear_area(2)) || (Z(k,i-1) < sear_area(1)))
                    i = i-1;
                end
                
            end
            
        end
        
    end
    if(strcmp(nbhd_opts,'normal')==1)
        i=1;
        Z(k,:) = mvnrnd(0,alpha,j);
        
        while( i<=j)
            Z(k,i) = Z(k,i) + X(k,i);
            i = i + 1;
            %search area
            if(isempty(sear_area)==0)
                
                if( (Z(k,i-1) > sear_area(2)) || (Z(k,i-1) < sear_area(1)))
                    i = 1;
                    Z(k,:) = mvnrnd(0,alpha,j);
                end
                
            end
            
        end
    end
    
    %Initiialize new value
    argXk = num2cell(X(k,:));
    argZk = num2cell(Z(k,:));
    if (f(argXk{:}) > f(argZk{:}))
        X(k+1,:) = Z(k,:);
    else
        X(k+1,:) = X(k,:);
    end
    
    %cooling schedule: reduces the search area by a value for each descent
    if(cool == 1)
        argXkp1 = num2cell(X(k+1,:));
        if(f(argXk{:}) > f(argXkp1{:}))
            alpha = alpha*(cool_param); %reduces the search radius
        end
    end
    
    %plot
    if(plot == 1)
        pause(.001);
        scatter3(Z(k,1),Z(k,2),f(argZk{:}),'filled','r') %bad points
        scatter3(X(k,1),X(k,2),f(argXk{:}),'filled','k') %good points
    end
    
    k = k +1;
end
hold off
argmin = X(end,:);
end