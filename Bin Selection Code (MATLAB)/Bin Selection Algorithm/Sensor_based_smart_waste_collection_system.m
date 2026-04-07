load original_waste_data.mat; %This line opens the file containing the daily waste generation per bin data which consists of 396 rows for 396 bins, the first column contains the bin ID, and the remaining columns contain waste generation for each day.
m=60; %bin capacity factor in terms of kilogram
f=0.9; %factor to check if the bin reached 90% of its capacity
c=1; 
d=0;
waste=original_waste_data; %Assigning the loaded data to variable (waste)
for a=2:31 %loop for columns 2 to 31 representing days 1 to 30 
    c=1; 
    d=d+1;
    if a>=1 && a<31 %condition for the remaining days except the last day and starting day 4
       for b=1:396 %loop for 396 bins
        if waste(b,a)>=f*m %check if the amount of waste exceeds 90% of bin capacity
            collected_waste(b,a)=waste(b,a); %if yes, assign the waste to be collected
            selected_bin(c,d)=waste(b,1); %assign the bin to be collected
            c=c+1;
        else
            waste(b,a+1)=waste(b,a)+waste(b,a+1); %if no, accumulate the waste to the next day
            collected_waste(b,a)=0; %no waste is assigned for collection
        end
       end
    else if a==31 %condition for the last day
        for b=1:396 %loop for 396 bins
        if waste(b,a)>=f*m %check if the amount of waste exceeds 90% of bin capacity
        collected_waste(b,a)=waste(b,a); %if yes, assign the waste to be collected
                    selected_bin(c,d)=waste(b,1); %assign the bin to be collected
            c=c+1;
        else
        collected_waste(b,a)=0; %if no, no waste is assigned for collection
        end 
        end
        end
    end
end