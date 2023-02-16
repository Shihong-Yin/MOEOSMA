% Calculate the reciprocal of hypervolume(rHV) of the obtained Pareto front
% Reference [Zitzler E, Thiele L, Laumanns M, et al. Performance assessment
% of multiobjective optimizers: an analysis and review[J].
% IEEE Transactions on Evolutionary Computation, 2003, 7(2): 117-132.]
function HV_Score = HV(PF,NP)
    repoint = load(['RefPoints\nadir_' num2str(NP) '.txt']);
    repoint = repoint.*1.1;
    PF(any(PF>repoint,2),:) = []; % Remove solutions beyond the reference point
    % Calculation of HV value
    if isempty(PF)
        HV_Score = 0; % If there is no better solution than the reference point, the HV value is defined as 0
    else
        N = size(PF,1); % N is population size
        [~,temp_index] = sort(PF(:,1));
        sortF = PF(temp_index,:);
        pointSet = [repoint;sortF];
        HV = 0;
        for i = 1:N
            cubei = (pointSet(1,1)-pointSet(i+1,1))*(pointSet(i,2)-pointSet(i+1,2));
            HV = HV+cubei;
        end
        HV_Score = HV;
    end
end