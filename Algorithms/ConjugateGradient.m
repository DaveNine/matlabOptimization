%This function performs a Conjugate Gradient Algorithm on the specified function.
%f = function written as a string of X
%x = initial point
%n = number of variables of f
%There are 5 total options in place of varargin:
%epsilon: change the tolerance of the accuracy of the solution
%num_its: decide the maximum number of iterations before termination
%beta_opts: decide the different choices for Beta. Can be:
%           1. 'HS' for Hestenes-Stiefel
%           2. 'PR' for Polak–Ribière
%           3. 'FR' for Fletcher–Reeves
%reset: 'reset' to resets the Hessian matrix to H{0} every 6 iterations.
%plot: 'activeplot' to actively plot each iteration. Recccomended to see
%       progress.
function [argmin,min] = ConjugateGradient(f,initial,n,varargin)
tic;
%%%%%%%%%%%%%%options%%%%%%%%%%%%%%%
num_opt_args = length(varargin);
optional_args = {1e-10,50,'HS',[],'activeplot'};
optional_args(1:num_opt_args) = varargin;
[epsilon, num_its, beta_opt, reset, plot] = optional_args{:};

%%%%%%%%%%%%%%initialization%%%%%%%%%%%%%%% surprisingly doesn't speed code
A = zeros(1000,1); B = zeros(1000,1);
X = zeros(1000,n); G = zeros(1000,n);
D = zeros(1000,n); 
X(1,:) = initial;
G(1,:) = diffpoint2(f,X(1,:),n,1);
D(1,:) = -G(1,:);
k=1; j=6;
%%%%%%%%%%%%%%algorithm%%%%%%%%%%%%%%%
while((norm(G(k)) > epsilon) && (k <= num_its-1))
    A(k) = linesearch_secant(f,X(k,:),D(k,:));
    X(k+1,:) = X(k,:) + A(k).*D(k,:);
    G(k+1,:) = diffpoint2(f,X(k+1,:),n,1);
    
    if(strcmp(beta_opt, 'HS') == 1)
        B(k)=(G(k+1,:)*(G(k+1,:)-G(k,:))')/(D(k,:)*(G(k+1,:)-G(k,:))');
    end
    
    if(strcmp(beta_opt, 'PR') == 1)
        B(k) = (G(k+1,:)*(G(k+1,:)-G(k,:))')/(G(k,:)*G(k,:)');
    end
    
    if(strcmp(beta_opt, 'FR') == 1)
        B(k) = (G(k+1,:)*G(k+1,:)')/(G(k,:)*G(k,:)');
    end
    
    D(k+1,:) = -G(k+1,:) + B(k)*D(k,:);
    
    if(strcmp(reset,'reset') == 1)
        if(k == j)
            D(k+1,:) = -G(k,:);
            j = j + 6;
        end
    end
    if(strcmp(plot,'activeplot')==1)
        hold on
        scatter(X(k,1),X(k,2),'fill','k');
        drawnow;
    end
    k = k + 1;
end
hold off

%%%%%%%%%%%%%%post-processing%%%%%%%%%%%%%%%
 X = X(1:k,:);

argmin = X(end,:);
min = generalEval(f,n,X(end,:));
elapsedTime = toc;
if(k==num_its)
    fprintf('Iterations reached maximum allowed, please allow more\n');
    fprintf('iterations or check to see if something broke.');
else
    fprintf('The function was minimized in %d iterations in %f seconds.\n',k,elapsedTime);
end
end