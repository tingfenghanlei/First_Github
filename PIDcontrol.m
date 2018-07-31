% function [out,err_return] = PIDcontrol(X,Y,Z,err_init,n)
%     err = 0;
%     prev_cte = err_init;
%     int_cte = 0;
%     cte_now = err_init;
%     for i=1:2*n    
%         cte = cte_now;
%         diff_cte = cte - prev_cte;
%         int_cte = cte + int_cte;
%         prev_cte = cte;
%         steer = X * cte + Y * int_cte + Z * diff_cte;
%         if(steer>=200)
%             steer = 200;
%         elseif (steer<=-200)
%             steer = -200;
%         end
%         cte_new =RobotMove(steer);
%         cte_now = cte_now - cte_new;
%       
%         if (i >= n)
%            err = err+cte_now*cte_now;
%         end
%   %   fprintf('cte:%2.5f,int_cte:%2.5f,diff_cte:%2.5f,cte_new:%2.5f,steer:%2.5f\r\t',cte,int_cte,diff_cte,cte_new,steer);
%     end
%     out = err/n;
%     err_return = cte_now;
% end
% %sin��=��=d/L= (Vr-Vl)*t/L LΪ�־࣬dΪ10ms���ֱ����ֶ���ߵľ���
%  function err_now=RobotMove(steer)
% %        tmp = 2*steer*0.01/315*180/pi*10;
% %        err_now = err_init - tmp;
%          err_now = 2*steer*0.01/315*180/pi*10*100;
%        %disp(['err_now' num2str(err_now, '%2.5f \t')]);
%  end
function [out,err_return] = PIDcontrol(X,Y,Z,err_init,n)
    err = 0;
    prev_cte = err_init;
    int_cte = 0;
    cte_now = err_init;
    for i=1:2*n    
        cte = cte_now;
        diff_cte = cte - prev_cte;
        int_cte = cte + int_cte;
        prev_cte = cte;
        steer = X * cte + Y * int_cte + Z * diff_cte;
%         if(steer>=30)
%             steer = 30;
%         elseif (steer<=-30)
%             steer = -30;
%         end
        cte_new =RobotMove(steer);
        cte_now = cte_now - cte_new;
      
%         if (i >= n)
        err = err+cte_now*cte_now;
%         end
%         fprintf('cte:%2.5f,int_cte:%2.5f,diff_cte:%2.5f,cte_new:%2.5f,steer:%2.5f\r\t',cte,int_cte,diff_cte,cte_new,steer);
    end
    out = err/2/n;
    err_return = cte_now;
end
%sin��=��=d/L= (Vr-Vl)*t/L LΪ�־࣬dΪ10ms���ֱ����ֶ���ߵľ���
 function err_now=RobotMove(steer)
          err_now = 2*steer*0.01/315*180/pi*10*100;%*10��Ϊ�˰Ѷȱ��0.1��Ϊ��λ��*100��Ϊ�˷���ʵ�������10ms������ת�����ٽǶȣ�1����ܲ�ת2.5�ȡ�
%           if(err_now>=0.25)
%               err_now=0.25;
%           elseif (err_now<=-0.25)
%               err_now=-0.25;
%           end
%           err_now = err - tmp;
%          err_now = 2*steer*0.01/315*180/pi*10*100;
       %disp(['err_now' num2str(err_now, '%2.5f \t')]);
 end     
     
     