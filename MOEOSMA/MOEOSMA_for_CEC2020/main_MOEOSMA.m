clear;clc
% Add path
addpath(genpath('MM_testfunctions/'));
addpath(genpath('Indicator_calculation/'));
N_function = 24; % number of test function
runtimes = 21;   % number of run times
rPSP = zeros(N_function,runtimes);
rHV = zeros(N_function,runtimes);
IGDX = zeros(N_function,runtimes);
IGDF = zeros(N_function,runtimes);
for i_func = 1:N_function
    disp(['Func:',num2str(i_func)])
    % Initialize the parameters in CEC2020 test functions
    [fname,xl,xu,n_obj,n_var,repoint,N_ops] = func_info(i_func);
    % Load reference PS and PF data
    load(strcat([fname,'_Reference_PSPF_data']));
    % Initialize the population size and the maximum evaluations
    popsize = 200*N_ops;
    Max_fevs = 10000*N_ops;
    Max_Gen = fix(Max_fevs/popsize);
    for j = 1:runtimes
        disp(['run:',num2str(j)])
        tic
        [ps,pf] = MOEOSMA(fname,xl,xu,n_obj,n_var,popsize,Max_Gen);
        Time(i_func,j) = toc;
        % Save the ps and pf
        allPs{i_func,j} = ps;
        allPf{i_func,j} = pf;
        % Indicators
        HV = Hypervolume_calculation(pf,repoint);
        IGDx = IGD_calculation(ps,PS);
        IGDf = IGD_calculation(pf,PF);
        CR = CR_calculation(ps,PS);
        PSP = CR/IGDx;
        rPSP(i_func,j) = 1./PSP;
        rHV(i_func,j) = 1./HV;
        IGDX(i_func,j) = IGDx;
        IGDF(i_func,j) = IGDf;
    end
end
rPSP_Metric = zeros(2*N_function,1);
rHV_Metric = zeros(2*N_function,1);
IGDX_Metric = zeros(2*N_function,1);
IGDF_Metric = zeros(2*N_function,1);
for i = 1:N_function
    rPSP_Metric(2*i-1,1) = mean(rPSP(i,:),2);
    rPSP_Metric(2*i,1) = std(rPSP(i,:),0,2);
    rHV_Metric(2*i-1,1) = mean(rHV(i,:),2);
    rHV_Metric(2*i,1) = std(rHV(i,:),0,2);
    IGDX_Metric(2*i-1,1) = mean(IGDX(i,:),2);
    IGDX_Metric(2*i,1) = std(IGDX(i,:),0,2);
    IGDF_Metric(2*i-1,1) = mean(IGDF(i,:),2);
    IGDF_Metric(2*i,1) = std(IGDF(i,:),0,2);
end
save MOEOSMA allPs allPf rPSP rHV IGDX IGDF Time
% % Plot PS figure
% figure
% if size(PS,2)==2
%     plot(PS(:,1),PS(:,2),'.','MarkerSize',10,'Color',[255, 140, 0]./255);
%     hold on
%     plot(ps(:,1),ps(:,2),'o','MarkerSize',10,'Color',[170, 71, 188]./255);
%     legend('True PS','Obtained PS')
% elseif size(PS,2)==3
%     plot3(PS(:,1),PS(:,2),PS(:,3),'.','MarkerSize',10,'Color',[255, 140, 0]./255);
%     hold on
%     plot3(ps(:,1),ps(:,2),ps(:,3),'o','MarkerSize',10,'Color',[170, 71, 188]./255);
%     legend('True PS','Obtained PS')
% end
% % Plot PF figure
% figure
% if size(PF,2)==2
%     plot(PF(:,1),PF(:,2),'.','MarkerSize',10,'Color',[255, 140, 0]./255);
%     hold on
%     plot(pf(:,1),pf(:,2),'o','MarkerSize',10,'Color',[170, 71, 188]./255);
%     legend('True PF','Obtained PF')
% elseif size(PF,2)==3
%     plot3(PF(:,1),PF(:,2),PF(:,3),'.','MarkerSize',10,'Color',[255, 140, 0]./255);
%     hold on
%     plot3(pf(:,1),pf(:,2),pf(:,3),'o','MarkerSize',10,'Color',[170, 71, 188]./255);
%     legend('True PF','Obtained PF')
% end