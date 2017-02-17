%This function takes in a function, f, as a function handle and attempts to
%minimize it via Particle Swarm Optimization.

function argmin = ParticleSO(f,initial_pop,omega,c_1,c_2,num_its, sear_area)

j = nargin(f);
%initial particles
X{1} = sear_area(1)+(sear_area(2)-sear_area(1)).*rand(initial_pop,j);
%initial velocities
V{1} =  sear_area(1)+(sear_area(2)-sear_area(1)).*rand(initial_pop,j);
%personal best
P{1} = X{1};
%global best
G(1,:) = bestKnown(f,X{1});

k = 1;
while( k <= num_its)
    
    R{k} = rand(initial_pop,j);
    S{k} = rand(initial_pop,j);
    V{k+1} = omega*V{k}+(c_1*R{k}).*(P{k}-X{k})+...
        (c_2*S{k}).*(repmat(G(k,:),initial_pop,1)-X{k});
    X{k+1} = X{k} + V{k+1};
    
    
    %new personal best
    for t = 1:initial_pop
        argX = num2cell(X{k+1}(t,:));
        argP = num2cell(P{k}(t,:));
        if(f(argX{:}) < f(argP{:}))
            P{k+1}(t,:) = X{k+1}(t,:);
        else
            P{k+1}(t,:) = P{k}(t,:);
        end
    end
    
    %new global best
    argB = num2cell(bestKnown(f,X{k+1}));
    argG = num2cell(G(k,:));
    if(f(argB{:}) < f(argG{:}))
        G(k+1,:) = bestKnown(f,X{k+1});
    else
        G(k+1,:) = G(k,:);
    end
      pause(.001)
      scatter3(X{k}(:,1),X{k}(:,2),f(X{k}(:,1),X{k}(:,2)),'filled','k');
      axis([-5,5,-5,5,-1,1])
    k = k + 1;
end

argmin = G(end,:);

end