function [fname,xl,xu,n_obj,n_var,repoint,N_ops] = func_info(Func_num)
% func_info: input the number of CEC2020 function and return the information about the corresponding function
switch Func_num
    case 1
        fname='MMF1';      % function name
        n_obj=2;           % the dimensions of the decision space
        n_var=2;           % the dimensions of the objective space
        xl=[1 -1];         % the low bounds of the decision variables
        xu=[3 1];          % the up bounds of the decision variables
        repoint=[1.1,1.1]; % reference point used to calculate the hypervolume, it is set to 1.1*(max value of f_i)
        N_ops=2;           % the number of global PS and local PS
    case 2
        fname='MMF2';
        n_obj=2;
        n_var=2;
        xl=[0 0];
        xu=[1 2];
        repoint=[1.1,1.1];
        N_ops=2;
    case 3
        fname='MMF4';
        n_obj=2;
        n_var=2;
        xl=[-1 0];
        xu=[1 2];
        repoint=[1.1,1.1];
        N_ops=2;
    case 4
        fname='MMF5';
        n_obj=2;
        n_var=2;
        xl=[1 -1];
        xu=[3 3];
        repoint=[1.1,1.1];
        N_ops=2;
        
    case 5
        fname='MMF7';
        n_obj=2;
        n_var=2;
        xl=[1 -1];
        xu=[3 1];
        repoint=[1.1,1.1];
        N_ops=2;
    case 6
        fname='MMF8';
        n_obj=2;
        n_var=2;
        xl=[-pi 0];
        xu=[pi 9];
        repoint=[1.1,1.1];
        N_ops=2;
    case 7
        fname='MMF10';
        n_obj=2;
        n_var=2;
        xl=[0.1 0.1];
        xu=[1.1 1.1];
        repoint=[1.21,13.2];
        N_ops=1;
    case 8
        fname='MMF11';
        n_obj=2;
        n_var=2;
        xl=[0.1 0.1];     % the low bounds of the decision variables
        xu=[1.1 1.1];      % the up bounds of the decision variables
        repoint=[1.21,15.4];
        N_ops=1;
    case 9
        fname='MMF12';  % function name
        n_obj=2;       % the dimensions of the decision space
        n_var=2;       % the dimensions of the objective space
        xl=[0 0];     % the low bounds of the decision variables
        xu=[1 1];      % the up bounds of the decision variables
        repoint=[1.54,1.1];
        N_ops=1;
    case 10
        %*need to be modified
        fname='MMF13';  % function name
        n_obj=2;       % the dimensions of the decision space
        n_var=3;       % the dimensions of the objective space
        xl=[0.1 0.1 0.1];     % the low bounds of the decision variables
        xu=[1.1 1.1 1.1];      % the up bounds of the decision variables
        repoint=[1.54,15.4];
        N_ops=1;
    case 11
        fname='MMF14';  % function name
        n_obj=3;       % the dimensions of the decision space
        n_var=3;       % the dimensions of the objective space
        xl=[0 0 0];     % the low bounds of the decision variables
        xu=[1 1 1];      % the up bounds of the decision variables
        repoint=[2.2,2.2,2.2];
        N_ops=2;
    case 12
        fname='MMF15';  % function name
        n_obj=3;       % the dimensions of the decision space
        n_var=3;       % the dimensions of the objective space
        xl=[0 0 0];     % the low bounds of the decision variables
        xu=[1 1 1];      % the up bounds of the decision variables
        repoint=[2.5,2.5,2.5];
        N_ops=1;
        
    case 13
        fname='MMF1_e';  % function name
        n_obj=2;       % the dimensions of the decision space
        n_var=2;       % the dimensions of the objective space
        xl=[1 -20];     % the low bounds of the decision variables
        xu=[3 20];      % the up bounds of the decision variables
        repoint=[1.1,1.1];
        N_ops=2;
    case 14
        fname='MMF14_a';  % function name
        n_obj=3;
        n_var=3;
        xl=[0 0 0];
        xu=[1 1 1];
        repoint=[2.2,2.2,2.2];
        N_ops=2;
    case 15
        fname='MMF15_a';  % function name
        n_obj=3;
        n_var=3;
        xl=[0 0 0];
        xu=[1 1 1];
        repoint=[2.5,2.5,2.5];
        N_ops=1;
        
    case 16
        fname='MMF10_l';  % function name
        n_obj=2;       % the dimensions of the decision space
        n_var=2;       % the dimensions of the objective space
        xl=[0.1 0.1];     % the low bounds of the decision variables
        xu=[1.1 1.1];      % the up bounds of the decision variables
        repoint=[1.21,13.2]; % reference point used to calculate the Hypervolume
        N_ops=2;
    case 17
        fname='MMF11_l';  % function name
        n_obj=2;       % the dimensions of the decision space
        n_var=2;       % the dimensions of the objective space
        xl=[0.1 0.1];     % the low bounds of the decision variables
        xu=[1.1 1.1];      % the up bounds of the decision variables
        repoint=[1.21,15.4];
        N_ops=2;
    case 18
        fname='MMF12_l';  % function name
        n_obj=2;       % the dimensions of the decision space
        n_var=2;       % the dimensions of the objective space
        xl=[0 0];     % the low bounds of the decision variables
        xu=[1 1];      % the up bounds of the decision variables
        repoint=[1.54,1.1];
        N_ops=2;
    case 19
        %*need to be modified
        fname='MMF13_l';  % function name
        n_obj=2;       % the dimensions of the decision space
        n_var=3;       % the dimensions of the objective space
        xl=[0.1 0.1 0.1];     % the low bounds of the decision variables
        xu=[1.1 1.1 1.1];      % the up bounds of the decision variables
        repoint=[1.54,15.4];
        N_ops=2;
    case 20
        fname='MMF15_l';  % function name
        n_obj=3;       % the dimensions of the decision space
        n_var=3;       % the dimensions of the objective space
        xl=[0 0 0];     % the low bounds of the decision variables
        xu=[1 1 1];      % the up bounds of the decision variables
        repoint=[2.5,2.5,2.5];
        N_ops=2;
    case 21
        fname='MMF15_a_l';  % function name
        n_obj=3;
        n_var=3;
        xl=[0 0 0];
        xu=[1 1 1];
        repoint=[2.5,2.5,2.5];
        N_ops=2;
    case 22
        fname='MMF16_l1';  % function name
        n_obj=3;
        n_var=3;
        xl=[0 0 0];
        xu=[1 1 1];
        repoint=[2.5,2.5,2.5];
        N_ops=3;
    case 23
        fname='MMF16_l2';  % function name
        n_obj=3;
        n_var=3;
        xl=[0 0 0];
        xu=[1 1 1];
        repoint=[2.5,2.5,2.5];
        N_ops=3;
    case 24
        fname='MMF16_l3';  % function name
        n_obj=3;
        n_var=3;
        xl=[0 0 0];
        xu=[1 1 1];
        repoint=[2.5,2.5,2.5];
        N_ops=4;
end
end

