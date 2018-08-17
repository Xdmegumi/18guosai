function [E,v] = km_kpca(X,m,ktype,kpar)

n = size(X,1);

K = km_kernel(X,X,ktype,kpar);
[E,V] = eig(K);
v = diag(V);	% eigenvalues
[v,ind] = sort(v,'descend');
v = v(1:m);
E = E(:,ind(1:m));	% principal components
for i=1:m
	E(:,i) = E(:,i)/sqrt(n*v(i));	% normalization
end