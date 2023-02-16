function [Archive_X_Chopped, Archive_F_Chopped] = HandleFullArchive(Archive_X, Archive_F, ArchiveRanks, ArchiveMaxSize)
Num = size(Archive_F,1)-ArchiveMaxSize;
for i = 1:Num
    index = RouletteWheelSelection(ArchiveRanks);
    Archive_X(index,:) = [];
    Archive_F(index,:) = [];
    ArchiveRanks(:,index) = [];
end
Archive_X_Chopped = Archive_X;
Archive_F_Chopped = Archive_F;
end