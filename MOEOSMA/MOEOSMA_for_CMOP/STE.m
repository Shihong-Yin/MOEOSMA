function STE_Score = STE(pf)
% <metric> <min>
% Spacing-to-Extent (STE)
% Remove the same solution in pf
len = size(pf,1);
n = 1;
for i = 1:len
    for j = len:-1:i+1
        if pf(i,:) == pf(j,:)
            remove(n) = j;
            n = n+1;
        end
    end
end
if n > 1
    pf(remove,:) = [];
end
% Spacing
N = size(pf,1);
if N > 2
    Distance = pdist2(pf,pf,'cityblock');
    Distance(logical(eye(size(Distance,1)))) = inf;
    Spacing = std(min(Distance,[],2));
else
    Spacing = 1e10; % If only one or two points in pf
end
% Extent
fmax = max(pf,[],1);
fmin = min(pf,[],1);
Extent = max(sum(fmax-fmin),1e-10); % Avoid a denominator of 0
% STE_Score
STE_Score = Spacing/Extent;
end