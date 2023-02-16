function par = prob_par(prob_k)
% prob_k -> Index of problem
% par.n  -> Dimension of problem
% par.fn -> Number of objective
% par.g  -> Number of inequility constraints
% par.h  -> Number of equality constraints
% par.xmin -> lower bound of decision variables
% par.xmax -> upper bound of decision variables
D      = [7,3,4,5,7,3,6,10,25,16,29,59];
par.n  = D(prob_k); 
O      = [2,2,2,2,3,5,3,3,2,2,2,2];
par.fn = O(prob_k);
gn     = [11,8,7,5,10,7,9,10,60,72,200,942];
hn     = [0,0,0,0,0,0,0,0,0,0,0,0];
par.gn = gn;
par.hn = hn;
par.g  = gn(prob_k);
par.h  = hn(prob_k);
%% range
% bound constraint definitions
xmin1  = [2.6,0.7,16.51,7.3,7.3,2.9,5];
xmax1  = [3.6,0.8,28.49,8.3,8.3,3.9,5.5];
xmin2  = [0.51,1,0.51];
xmax2  = [32.49,30,42.49];
xmin3  = [1, 1, 1e-6,1];
xmax3  = [16, 16, 16*1e-6,16];
xmin4  = [0.05,0.2,0.2,0.35,3];
xmax4  = [0.5,0.5,0.6,0.5,6];
xmin5  = [0.5,0.45,0.5,0.5,0.875,0.4,0.4];
xmax5  = [1.5,1.35,1.5,1.5,2.625,1.2,1.2];
xmin6  = [0.01 0.01 0.01];
xmax6  = [0.45 0.1 0.1];
xmin7  = [150.0 20.0 13.0 10.0 14.0 0.63];
xmax7  = [274.32 32.31 25.0 11.71 18.0 0.75];
xmin8  = [0.51,0.51,0.51,250,250,250,6,4,40,10];
xmax8  = [3.49,3.49,3.49,2500,2500,2500,20,16,700,450];
xmin9 = 0.51*ones(1,25);
xmax9 = 41.49*ones(1,25);
xmin10 = 0.51*ones(1,16);
xmax10 = 41.49*ones(1,16);
xmin11 = 0.51*ones(1,29);
xmax11 = 41.49*ones(1,29);
xmin12 = 0.51*ones(1,59);
xmax12 = 41.49*ones(1,59);
eval(['par.xmin=xmin' int2str(prob_k) ';']);
eval(['par.xmax=xmax' int2str(prob_k) ';' ]);
end