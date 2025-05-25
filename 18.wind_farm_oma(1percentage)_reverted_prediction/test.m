x=[1 1 1  2 2 2 3 3 3];
for i = 1:length(x)
    for j = i:length(x)
        d(i,j) = norm(x-y);
    end
end


for i = 1:length(x)
    for j = i:length(x)
        if d(i,j) < 0.01
            
            aa = [aa,j];
    end
end            

        
        
        