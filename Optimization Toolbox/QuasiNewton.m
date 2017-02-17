%This function performs a Quasi-Newton Algorithm on the specified function.
%f = function written as a string of X
%x = initial point
%n = number of variables of f
%There are 4 total options in place of varargin:
%epsilon: change the tolerance of the accuracy of the solution
%num_its: decide the maximum number of iterations before termination
%hess_opts: decide the different approximation to the Hessian. Can be:
%           1. rank, for Rank 1 Correction
%           2. DFP for Davidon–Fletcher–Powell Correction
%           3. BFGS forBroyden–Fletcher–Goldfarb–Shanno Correction
%reset: 'reset' to resets the Hessian matrix to H{0} every 6 iterations.
%plot: 'activeplot' to actively plot each iteration. Recccomended to see
%       progress.
function [argmin,min] = QuasiNewton(f,initial,n,varargin)
tic
%%%%%%%%%%%%%%options%%%%%%%%%%%%%%%
num_opt_args = length(varargin);
optional_args = {1e-6,100,'rank',[],'activeplot'};
optional_args(1:num_opt_args) = varargin;
[epsilon, num_its, hess_opt,reset,plot] = optional_args{:};

%%%%%%%%%%%%%%initialization%%%%%%%%%%%%%%%
A = zeros(1000,1); G = zeros(n,1000);
X = zeros(n,1000); D = zeros(n,1000);
H = cell(100); DX = zeros(n,1000);
DG = zeros(n,1000);
X(:,1) = initial';
G(:,1) = diffpoint2(f,X(:,1)',n,1)';
H{1} = eye(n);
D(:,1) = -H{1}*G(:,1);
k=1; j=6;
%%%%%%%%%%%%%%algorithm%%%%%%%%%%%%%%%
while((norm(G(:,k))>epsilon) && (k<= num_its-1))
      D(:,k) = -H{k}*G(:,k);
    if(strcmp(reset,'reset')==1)
        if(k==j)
            D(:,k) =-H{1}*G(:,k);
            j=j+6;
        end
    end
    A(k)=linesearch_secant(f,X(:,k)',D(:,k)');
    X(:,k+1)=X(:,k)+A(k).*D(:,k);
    G(:,k+1)=diffpoint2(f,X(:,k+1)',n,1)';
    DX(:,k) = X(:,k+1)-X(:,k);
    DG(:,k) = G(:,k+1) - G(:,k);
    
    switch hess_opt
        case 'rank'
            H{k+1} = H{k} + (DX(:,k)-H{k}*DG(:,k))*(DX(:,k)-H{k}*DG(:,k))'...
                /(DG(:,k)'*(DX(:,k)-H{k}*DG(:,k)));
        case 'DFP'
            H{k+1} = H{k} + (DX(:,k)*DX(:,k)')/(DX(:,k)'*DG(:,k)) -...
                (H{k}*DG(:,k))*(H{k}*DG(:,k))'/(DG(:,k)'*H{k}*DG(:,k));
        case 'BFGS'
            H{k+1} = H{k} + (1 +(DG(:,k)'*H{k}*DG(:,k))/(DG(:,k)'*DX(:,k)))*...
                ((DX(:,k)*DX(:,k)')/(DX(:,k)'*DG(:,k))) - ...
                (H{k}*DG(:,k)*DX(:,k)'+(H{k}*DG(:,k)*DX(:,k)')')/(DG(:,k)'*DX(:,k));
    end
    if(strcmp(plot,'activeplot')==1)
        hold on
        scatter(X(1,k)',X(2,k)','fill','k');
        drawnow;
    end
    k = k + 1;
end
hold off
%%%%%%%%%%%%%%post-processing%%%%%%%%%%%%%%%
X = X(:,1:k);
argmin = X(:,end)';
min = generalEval(f,n,X(:,end)');
elapsedTime = toc;
if(k==num_its)
    fprintf('Iterations reached maximum allowed, please allow more\n');
    fprintf('iterations or check to see if something broke.');
else
    fprintf('The function was minimized in %d iterations in %f seconds.\n',k,elapsedTime);
end

end