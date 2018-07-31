clear all, clc, close all
%% Twiddle Algorithmus nach Sebastian Thrun
tic
 
params = [0 0 0];   %Startparameter X & Y
dparams = [1 1 1];  %Startschrittweite DeltaX & DeltaY
 
it=1;
 
%�ɱ���������
[cfzz(it),err(it)] = PIDcontrol(params(1),params(2),params(3),100,500);%ƫ��Ϊ10��

%  [cfzz(it),err(it)] = PIDcontrol(1,1,1,100,500);
bestcost = cfzz(it);
 
% ��󻯳ɱ�����
while sum(dparams) > 0.01
    for i=1:length(params) % ���в���
        params(i)=params(i)+dparams(i);
 
        %�ɱ���������
        [cfzz(it),err(it)] = PIDcontrol(params(1),params(2),params(3),100,500);
 
        if cfzz(it) < bestcost
            bestcost = cfzz(it);
            dparams(i)= dparams(i)*1.05;
        else
            % �෴��������
            params(i)=params(i)- 2*dparams(i);
            [cfzz(it),err(it)] = PIDcontrol(params(1),params(2),params(3),100,500);
 
            if cfzz(it) < bestcost %���Ŀǰ�ĳɱ��ϸߣ�Ϊ�ã�
                bestcost = cfzz(it);
                dparams(i) = dparams(i)*1.05; %�����һ��
            else
                params(i)=params(i)+dparams(i);
                dparams(i)=dparams(i)*0.95; % ��С��һ��
            end
        end
 
    it = it+1;
    disp(['Twiddle #' num2str(it-1) 'parameter ' num2str(params,'%2.5f \t') ', FunctionCost: ' num2str(cfzz(it-1),'%2.5f \t') ',Err_now: ' num2str(err(it-1),'%2.5f \t')])
    paramsstore(it,:) = params; % Ϊ֧�������ı���
 
    end %parameter end
 
end
disp(['Twiddle-Berechnungsdauer ' num2str(toc) 's'])
disp(['                X           Y          Z'])
disp(['Maximum bei ' num2str(params,'%2.5f \t')])

%{
%Write with Python
# Choose an initialization parameter vector
p = [0, 0, 0]
# Define potential changes
dp = [1, 1, 1]
# Calculate the error
best_err = A(p)

threshold = 0.001

while sum(dp) > threshold:
    for i in range(len(p)):
        p[i] += dp[i]
        err = A(p)

        if err < best_err:  # There was some improvement
            best_err = err
            dp[i] *= 1.1
        else:  # There was no improvement
            p[i] -= 2*dp[i]  # Go into the other direction
            err = A(p)

            if err < best_err:  # There was an improvement
                best_err = err
                dp[i] *= 1.05
            else  # There was no improvement
                p[i] += dp[i]
                # As there was no improvement, the step size in either
                # direction, the step size might simply be too big.
                dp[i] *= 0.95
%}