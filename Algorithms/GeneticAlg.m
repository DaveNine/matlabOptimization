%This function attempts to maximize f via a Genetic Algorithm using a
%roulette scheme. Modifications need to occur to the selection of the
%Mating pool in order to find a minimum.

function [P] = GeneticAlg(f,num_its,sear_area,init_pop,pC,pM)
j = nargin(f);

P{1}(:,1) = sear_area(1) + (sear_area(2)-sear_area(1)).*rand(init_pop,1);
P{1}(:,2) = sear_area(3) + (sear_area(4)-sear_area(3)).*rand(init_pop,1);
k = 1;
while(k <= num_its)
    %create probability weights
    for i=1:init_pop
        argP = num2cell(P{k}(i,:));
        Psel(i) = abs(f(argP{:}));
    end    
    
    %create Mating Population
    Mindex = randsample(1:size(P{k},1),init_pop,true,Psel);
    M{k} = P{k}(Mindex,:);
    
    %Parent Index
    Parindex = randperm(init_pop,floor(normrnd(pC*(init_pop/2),1)));
    if( mod(size(Parindex,2),2)==1)
        Parindex = Parindex(1:size(Parindex,2)-1);
    end
    
    %Parent Selection
    Par{k} = M{k}(Parindex,:);
    
    %Generate Children
    for i = 1:2:size(Par{k},1)
        alpha = rand(1);
        Chil{k}(i,:) = alpha*Par{k}(i,:)+(1-alpha)*Par{k}(i+1,:);
        Chil{k}(i+1,:) = (1-alpha)*Par{k}(i,:)+alpha*Par{k}(i+1,:);
    end
    M{k}(Parindex,:) = Chil{k};
    
    %Mutate Population
    Pmut = rand(size(M{k},1),1);
    Pmut = Pmut < (pM);
    alpha = rand(1);
    W = normrnd(0,1,sum(Pmut),j);
    M{k}(Pmut,:) = alpha*M{k}(Pmut,:)+(1-alpha).*W;
    P{k+1} = M{k};
    k = k + 1;
    pause(.01);
    
    scatter3(P{k}(:,1),P{k}(:,2),f(P{k}(:,1),P{k}(:,2)),'fillied','k')
    axis([0 10 4 6 -10 15]);
end

end