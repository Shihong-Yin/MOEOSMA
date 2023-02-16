function [Archive_X,Archive_F,CV]=MOEOSMA(PopSize,MaxIter,lb,ub,dim,obj_no,prob_k)
% MOEOSMA for solving real-world constraint engineering problems
rand('seed',sum(100 * clock)); % Random number seed
GP = 0.5; % EO parameter
z = 0.6;  % SMA parameter
PC = 1e8; % Penalty coefficient
% Initialize the Pareto archive
ArchiveMaxSize = PopSize; % Archive capacity
Archive_X = zeros(ArchiveMaxSize,dim);
Archive_F = ones(ArchiveMaxSize,obj_no)*inf;
% Initialize the location of slime mould
X = initialization(PopSize,dim,ub,lb);
[f,g,h] = cmo_engineer_prob(X,prob_k);
g(g<0) = 0;  h(h<0) = 0;
CV = sum(g,2)+sum(h,2);
Fitness = f + PC.*CV;
fit_old = Fitness;  Xold = X;
weight = ones(PopSize,dim); % Initialize the fitness weight of each slime mould
it = 1; % Number of iterations
% Main loop
while it <= MaxIter
    % Check the boundary and calculate the fitness
    FU = X>ub;  FL = X<lb;  X = (X.*(~(FU+FL)))+(Xold+ub)./2.*FU+(Xold+lb)./2.*FL;
    [f,g,h] = cmo_engineer_prob(X,prob_k);
    g(g<0) = 0;  h(h<0) = 0;
    CV = sum(g,2)+sum(h,2);
    Fitness = f + PC.*CV;
    % Update the Pareto archive
    [Archive_X, Archive_F, ArchiveNum] = UpdateArchive(Archive_X, Archive_F, X, Fitness);
    ArchiveRanks = RankingProcess(Archive_F, ArchiveMaxSize, obj_no);
    if ArchiveNum > ArchiveMaxSize
        [Archive_X, Archive_F] = HandleFullArchive(Archive_X, Archive_F, ArchiveRanks, ArchiveMaxSize);
        ArchiveRanks = RankingProcess(Archive_F, ArchiveMaxSize, obj_no); % Update ranking
    end
    % Update the equilibrium pool with elite individuals
    [value, index] = sort(ArchiveRanks);
    Elite_no = sum(value == value(1)); % All elite individuals
    C_pool = Archive_X(index(1:Elite_no),:);
    % Memory saving
    Inx = zeros(PopSize,1);
    for k = 1:PopSize
        if fit_old(k,:)<Fitness(k,:)
            Inx(k,1) = 1;
        end
    end
    Indx = repmat(Inx,1,dim);
    X = Indx.*Xold+~Indx.*X; % Retain the better location
    Fitness = Inx.*fit_old+~Inx.*Fitness; % Retain the better fitness
    fit_old = Fitness;    Xold = X;
    % Sort the fitness thus update the best fitness and worst fitness
    [SmellOrder,SmellIndex] = sort(Fitness(:,rem(it,obj_no)+1)); % Eq.(14)
    worstFitness = SmellOrder(PopSize);
    bestFitness = SmellOrder(1);
    S = bestFitness-worstFitness+eps; % Plus eps to avoid denominator zero
    % Calculate the fitness weight of each slime mould by Eq.(14)
    for i = 1:PopSize
        if i <= PopSize/2
            weight(SmellIndex(i),:) = 1+rand(1,dim)*log10((bestFitness-SmellOrder(i))/S+1);
        else
            weight(SmellIndex(i),:) = 1-rand(1,dim)*log10((bestFitness-SmellOrder(i))/S+1);
        end
    end
    % Dynamic coefficient
    a1 = (1+(1-it/MaxIter)^(2*it/MaxIter))*rand; % Eq.(12)
    a2 = (2-(1-it/MaxIter)^(2*it/MaxIter))*rand;
    % Update EO parameters
    t1 = (1-it/MaxIter)^(a2*it/MaxIter);
    lambda = rand(PopSize,dim);
    r1 = rand(PopSize,1);
    r2 = rand(PopSize,1);
    rn = randi(size(C_pool,1),PopSize,1);
    % Update SMA parameters
    a = atanh(1-(it/MaxIter));
    vb = unifrnd(-a,a,PopSize,dim);
    r = rand(PopSize,dim);
    R = randi([1,PopSize],PopSize,2); % Two locations randomly selected from the population
    % Update the location of search agents by Eq.(13)
    for i = 1:PopSize
        gBest = C_pool(rn(i,1),:); % Select a solution randomly from the equilibrium pool
        if rand < z
            F = a1*sign(r(i,:)-0.5).*(exp(-lambda(i,:).*t1)-1);
            GCP = 0.5*r1(i,1)*ones(1,dim)*(r2(i,1)>=GP);
            G = (GCP.*(gBest-lambda(i,:).*X(i,:))).*F;
            X(i,:) = gBest+(X(i,:)-gBest).*F+G./lambda(i,:).*(1-F);
        else
            X(i,:) = gBest+ vb(i,:).*(weight(i,:).*X(R(i,1),:)-X(R(i,2),:));
        end
    end
    % Check the boundary and calculate the fitness
    FU = X>ub;  FL = X<lb;  X = (X.*(~(FU+FL)))+(Xold+ub)./2.*FU+(Xold+lb)./2.*FL;
    [f,g,h] = cmo_engineer_prob(X,prob_k);
    g(g<0) = 0;  h(h<0) = 0;
    CV = sum(g,2)+sum(h,2);
    Fitness = f + PC.*CV;
    [Archive_X, Archive_F, ArchiveNum] = UpdateArchive(Archive_X, Archive_F, X, Fitness);
    ArchiveRanks = RankingProcess(Archive_F, ArchiveMaxSize, obj_no);
    if ArchiveNum > ArchiveMaxSize
        [Archive_X, Archive_F] = HandleFullArchive(Archive_X, Archive_F, ArchiveRanks, ArchiveMaxSize);
    end
    % Memory saving
    Inx = zeros(PopSize,1);
    for k = 1:PopSize
        if fit_old(k,:) < Fitness(k,:)
            Inx(k,1) = 1;
        end
    end
    Indx = repmat(Inx,1,dim);
    X = Indx.*Xold+~Indx.*X;
    Fitness = Inx.*fit_old+~Inx.*Fitness;
    fit_old = Fitness;    Xold = X;
    % Mutation operator
    SF = 0.2+rand()*0.8; % Scaling factor
    R = randi([1,PopSize],PopSize,2);
    X = X+SF*(X(R(:,1),:)-X(R(:,2),:)); % Eq.(15)
    it = it+1;
end
end