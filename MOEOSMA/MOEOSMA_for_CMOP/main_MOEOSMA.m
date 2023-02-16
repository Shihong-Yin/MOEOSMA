clear;clc
format long;
set(0,'defaultfigurecolor','w')
N_prob = 12;   % number of problems
runs = 20;     % number of run times
popsize = 100; % population size
maxit = 500;   % number of iterations
for prob_k = 1:N_prob
    disp(['Prob: ', num2str(prob_k)]);
    par = prob_par(prob_k);
    lb = par.xmin;
    ub = par.xmax;
    dim = par.n;
    obj_n = par.fn;
    ineq_n = par.g;
    eq_n = par.h;
    for run_num = 1:runs
        disp(['Runs: ', num2str(run_num)]);
        tic
        [PS,PF,CV] = MOEOSMA(popsize,maxit,lb,ub,dim,obj_n,prob_k);
        Time = toc;
        run_time(prob_k,run_num) = Time;
        % Calculate the performance indicator HV
        HV_Score(prob_k,run_num) = HV(PF,prob_k);
        % Calculate the performance indicator STE
        STE_Score(prob_k,run_num) = STE(PF);
        all_PS{prob_k,run_num} = PS;
        all_PF{prob_k,run_num} = PF;
        all_CV{prob_k,run_num} = CV;
        disp(min(PF))
    end
end
save CMOEOSMA all_PS all_PF all_CV HV_Score STE_Score run_time