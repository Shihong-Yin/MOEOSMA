function [Archive_X_updated, Archive_F_updated, ArchiveNum] = UpdateArchive(Archive_X, Archive_F, Particles_X, Particles_F)
Archive_X_temp = [Archive_X; Particles_X];
Archive_F_temp = [Archive_F; Particles_F];
Arch_index = 1:size(Archive_F_temp,1);
% Check if i is dominated by other solutions, and if not, archiving
for i = 1:size(Archive_F_temp,1)
    for j = 1:size(Archive_F_temp,1)
        if sum(Archive_F_temp(j,:)<Archive_F_temp(i,:))==size(Archive_F_temp,2) % i is dominated by j
            Arch_index(i) = 0; % i will not be archived
            break;
        end
    end
end
Arch_index(Arch_index==0) = [];
len = length(Arch_index);
Archive_X_updated = Archive_X_temp(Arch_index,:);
Archive_F_updated = Archive_F_temp(Arch_index,:);
% Remove the same solution from the Pareto archive
n = 1;
for i = 1:len
    for j = len:-1:i+1
        if Archive_F_updated(i,:) == Archive_F_updated(j,:)
            remove(n) = j;
            n = n+1;
        end
    end
end
if n > 1
    Archive_X_updated(remove,:) = [];
    Archive_F_updated(remove,:) = [];
end
ArchiveNum = size(Archive_F_updated,1);
end