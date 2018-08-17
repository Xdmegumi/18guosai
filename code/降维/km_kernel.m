function K = km_kernel(X1,X2,ktype,kpar)
switch ktype
	case 'gauss'	% Gaussian kernel
		sgm = kpar;	% kernel width
		
		dim1 = size(X1,1);
		dim2 = size(X2,1);
		
		norms1 = sum(X1.^2,2);
		norms2 = sum(X2.^2,2);
		
		mat1 = repmat(norms1,1,dim2);
		mat2 = repmat(norms2',dim1,1);
		
		distmat = mat1 + mat2 - 2*X1*X2';	% full distance matrix
		K = exp(-distmat/(2*sgm^2));
		
	case 'gauss-diag'	% only diagonal of Gaussian kernel
		sgm = kpar;	% kernel width
		K = exp(-sum((X1-X2).^2,2)/(2*sgm^2));
		
	case 'poly'	% polynomial kernel
		p = kpar(1);	% polynome order
		c = kpar(2);	% additive constant
		
		K = (X1*X2' + c).^p;
		
	case 'linear' % linear kernel
		K = X1*X2';
		
	otherwise	% default case
		error ('unknown kernel type')
end