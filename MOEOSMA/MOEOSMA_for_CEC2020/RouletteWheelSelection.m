function choice = RouletteWheelSelection(weights)
accumulation = cumsum(weights);
p = rand*accumulation(end);
choice = 1;
for index = 1:length(accumulation)
    if accumulation(index) > p
        choice = index;
        break;
    end
end
end