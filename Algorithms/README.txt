Names: David Sacco

Below, just copy the command straight into MATLAB while being in the correct directory.

7.
argmin = NRandomSearch(f) %with the plot
argmin = NRandomSearch(f,[-3,2],10,1000,[-5,5],'uniform',1,.75,0) %without plot

%using a normal distribution
argmin = NRandomSearch(f,[-3,2],10,1000,[-5,5],'normal',1,.75,1)

%We see that varying alpha, as expected, changes the search area for which we may
%possibly initialize a new point.

8.
%These parameters give pretty entertaining plots.
argmin = ParticleSO(f,200,.1,.1,.1,1000,[-5,5])

9.%Note because I am using a roulette scheme, we're maximizing the function instead
%of minimizing it, so we'd need to change to the tournement scheme if we wanted to
%minimize.
g = @(x,y)(x.*sin(x)+y.*sin(5.*y))
[P] = GeneticAlg(g,1000,[0,10,4,6],2000,.10,.0075);
