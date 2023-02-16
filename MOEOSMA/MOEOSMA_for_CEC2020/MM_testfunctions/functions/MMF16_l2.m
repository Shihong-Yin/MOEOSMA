
function y=MMF16_l2(x,M)
% 0<=xi<=1
% Input
%        x               popsize*(M-1+k)
%        M               number of objectives;they are the same


% Output 
%        y   popsize*M
% The number of variables and objectives are scalable.
% num_of_peak/2 global PS/PF, num_of_peak/2  local PS/PF
% PS:xM=1/(2*np)+(i-1)/(np),i=2,3,...np
% PF: (f_1)^2+(f_2)^2+...+(f_M)^2=(1+g_i^*)^2

if nargin<2
    M=3;
end

    num_of_g_peak=1;%   number of global PSs
    num_of_l_peak=2;%   number of local PSs


% if size(x,1)~=1
%     x=reshape(x,1,length(x));
% end
%  
for i=1:size(x,1)
   
    if x(i,end)>=0&&x(i,end)<0.5
        g(i,:)=2-(sin(2*num_of_g_peak*pi.*x(i,end))).^2;%
    elseif x(i,end)>=0.5&&x(i,end)<=1
        g(i,:)=2-exp(-2*log10(2).*((x(i,end)-0.1)/0.8).^2).*(sin(2*num_of_l_peak*pi.*x(i,end))).^2;
    end
end
 y = repmat(1+g,1,M).*fliplr(cumprod([ones(size(g,1),1),cos(x(:,1:M-1)*pi/2)],2)).*[ones(size(g,1),1),sin(x(:,M-1:-1:1)*pi/2)];


%Reference Niching Without Niching Parameters: Particle Swarm Optimization Using a Ring Topology
%       Scalable Test Problems for Evolutionary Multiobjective Optimization
%       Change from DTLZ2





