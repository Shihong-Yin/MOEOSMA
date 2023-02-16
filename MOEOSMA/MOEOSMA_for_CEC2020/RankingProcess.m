function ranks = RankingProcess(Archive_F, ArchiveMaxSize, obj_no)
if size(Archive_F,1) == 1
    Min = Archive_F;
    Max = Archive_F;
else
    Min = min(Archive_F,[],1);
    Max = max(Archive_F,[],1);
end
unitDis = (Max-Min)/(ArchiveMaxSize);
ranks = zeros(1,size(Archive_F,1));
rows = size(Archive_F,1);
for i = 1:rows
    for j = 1:rows
        flag = 0;
        for k = 1:obj_no
            if abs(Archive_F(j,k)-Archive_F(i,k)) < unitDis(k)
                flag = flag+1;
            end
        end
        if flag == obj_no
            ranks(i) = ranks(i)+1;
        end
    end
end
end