%This program takes in a function, f, as a function handle and attempts to
%minimize it via Simulated Annealing.

function argmin = SimAnnealing(f,varargin)
j = nargin(f);
k=1;
n=1;
% Initialize defaults and incorporate given optional arguments
num_opt_args = length(varargin);
optional_args = {[-3,-2],1,1,1000,[-5,5], 1};
optional_args(1:num_opt_args) = varargin;       %override defaults with givens
[initial,alpha,gamma,num_its,sear_area,plot] = optional_args{:};

X(1,:) = initial;
G(1,:) = X(1,:); %best point so far
if(plot == 1)
    [T,U] = meshgrid(-5:.5:5,-5:.5:5);
    W = arrayfun(f,T,U);
    hold on
    surf(T,U,W);
end
while(k <=num_its)
    
    i=1;
    while (i<=j)
        %generates new point from nbhd
        Z(k,i) = (X(k,i)-alpha)+(2*alpha)*rand(1);
        
        %keeps search within search area
        i = i + 1;
        if( (Z(k,i-1) > sear_area(2)) || (Z(k,i-1) < sear_area(1)))
            i = i-1;
        end
    end
    
    argXk = num2cell(X(k,:));
    argZk = num2cell(Z(k,:));
    
    if (f(argXk{:}) > f(argZk{:}))
        X(k+1,:) = Z(k,:);
        
        argGn = num2cell(G(n,:));
        if (f(argZk{:}) < f(argGn{:}))
            G(n+1,:) = X(k+1,:);
            
            if(plot ==1)
                scatter3(G(n,1),G(n,2),f(argGn{:}),'filled','r') %descent points
            end
            
            n = n + 1;
        end
    end
    if (f(argXk{:}) < f(argZk{:}))
        
        T=gamma/log(k+2);
        P = exp(-(f(argZk{:})-f(argXk{:}))/T);
        roll = rand(1);
        
        if(roll < P)
            X(k+1,:)=Z(k,:);
        end
        if(roll > P)
            X(k+1,:) = X(k,:);
        end
        
    end
    if(plot == 1)
        pause(.001);
        scatter3(X(k,1),X(k,2),f(argXk{:}),'filled','k') %good points
    end
    k = k+1;
    
end
hold off
argmin = G(end,:);
end