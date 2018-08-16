clc,
%% define
Num_0f_Couple=3;  
Max_Bearer=2;     
load allow.mat
load allow_long.mat
allowed(34,:)=[];
load Strategy.mat
origin=ones(1,6);
PATH=[];
destination=zeros(1,6);
steps=1;
% path_final: Record the final strategy
% numbers:    Record the number of paths
% status:     Record if it's right
[path_final,numbers,status]=Find_path(origin,destination,PATH,0,
                            allowed,Strategy,steps,allow_long);
path_final
length(path_final)




