function alpha = linesearch_secant(f,x,d)
X = sym('x',[1,1]);
[m,n] = size(x);

g=generalEval(f,n,x+X(1)*d);
g=char(g);
g=strrep(g,'x1','X(1)');
alpha = secantMethod(g,0,.02,1e-6,20);

end