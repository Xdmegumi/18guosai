%% initialization
A=235;B=333;C=432;
status=[A,B,C];
xi_wei=10;
xiwei_fenpei=[1,1,1];
all_result=[];
all_Q=[];
% Emulated 100 new seats
new_postion=100;
length=4:(new_postion+3);
%% Simulation
while(new_postion>0)
    Q=status.^2./(xiwei_fenpei.*(xiwei_fenpei+1));
    [value,position]=max(Q);
    xiwei_fenpei(position)=xiwei_fenpei(position)+1;
    all_result=[all_result;xiwei_fenpei];
    all_Q=[all_Q;value];
    new_postion=new_postion-1;
end
%% Plot
all_result(xi_wei-3,:) % the result when xiwei=10
figure
plot(length,all_result)
figure 
plot(length,all_Q)





