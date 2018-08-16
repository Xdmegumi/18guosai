M=[-1 0 0;0 -2 0;0 0 -3];
Q=[-2 0 0;0 -5 0;0 0 -1];
H=eye(3);
L=[-2 1 0 0 1;1 -3 1 1 0;0 1 -2 1 0;0 1 1 -3 1;1 0 0 1 -2];
val=eig(L)
setlmis([])
P=lmivar(2,[3,3]);S=lmivar(2,[3,3]);R=lmivar(2,[3,3]);
%lamda=-4.618对应的线性矩阵不等式
lmiterm([1 1 1 P],M',1);lmiterm([1 1 1 P],1,M);lmiterm([1 1 1 R],1,1)
lmiterm([1 1 1 S],1,1);lmiterm([1 2 1 P],Q',1);lmiterm([1 2 2 R],-1,1)
lmiterm([1 3 1 P],val(1)*H',1);lmiterm([1 3 2 0],0);lmiterm([1 3 3 S],-1,1)
lmiterm([-1 0 0 0],0);
%lamda=-3.618对应的线性矩阵不等式
lmiterm([2 1 1 P],M',1);lmiterm([2 1 1 P],1,M);lmiterm([2 1 1 R],1,1)
lmiterm([2 1 1 S],1,1);lmiterm([2 2 1 P],Q',1);lmiterm([2 2 2 R],-1,1)
lmiterm([2 3 1 P],val(2)*H',1);lmiterm([2 3 2 0],0);lmiterm([2 3 3 S],-1,1)
lmiterm([-2 0 0 0],0);
%lamda=-2.382对应的线性矩阵不等式
lmiterm([3 1 1 P],M',1);lmiterm([3 1 1 P],1,M);lmiterm([3 1 1 R],1,1)
lmiterm([3 1 1 S],1,1);lmiterm([3 2 1 P],Q',1);lmiterm([3 2 2 R],-1,1)
lmiterm([3 3 1 P],val(3)*H',1);lmiterm([3 3 2 0],0);lmiterm([3 3 3 S],-1,1)
lmiterm([-3 0 0 0],0);
%lamda=-1.382对应的线性矩阵不等式
lmiterm([4 1 1 P],M',1);lmiterm([4 1 1 P],1,M);lmiterm([4 1 1 R],1,1)
lmiterm([4 1 1 S],1,1);lmiterm([4 2 1 P],Q',1);lmiterm([4 2 2 R],-1,1)
lmiterm([4 3 1 P],val(4)*H',1);lmiterm([4 3 2 0],0);lmiterm([4 3 3 S],-1,1)
lmiterm([-4 0 0 0],0);
lmis=getlmis
[tmin,xfeas]=feasp(lmis);PP=dec2mat(lmis,xfeas,P);
SS=dec2mat(lmis,xfeas,S);RR=dec2mat(lmis,xfeas,R)
