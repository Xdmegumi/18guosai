function [path_celue,numbers,status]=Find_path(origin,destination,PATH,numbers,allowed,Strategy,steps,duian_allow)
%% Success
    if origin==destination
            path_celue=PATH;
            status=1;
            numbers=numbers+1;
            steps=steps;
            return 
       end
    for dire=1:length(Strategy)
	% Next status
        origin_now=origin+Strategy(dire,:)*(-1)^steps; 
        if (origin_now>=0)==ones(1,6) & (origin_now<=1)==ones(1,6)
            duian=ones(1,6)-origin_now;
            [origin_flag,ia,ib] = 
			intersect(origin_now, allowed, 'rows'); 
            duian_flag = intersect(duian, duian_allow, 'rows'); 
            if origin_flag==origin_now & duian_flag==duian
                temp=allowed(ib,:);
                allowed(ib,:)=[];
                PATH=[PATH;dire];
                steps=steps+1;
                [path_celue,numbers,status]=
				Find_path(origin_now,zeros(1,6),
			    PATH,numbers,allowed,Strategy,steps,duian_allow);
                     if status==1
                        return 
                     else if status==0  
                           allowed=[allowed;temp];
                           steps=steps-1;
                           PATH(length(PATH),:)=[];
                         end
                     end
                 end   
           end
       end
  path_celue=[];
  status=0;
  numbers=0;
  steps=0;
end