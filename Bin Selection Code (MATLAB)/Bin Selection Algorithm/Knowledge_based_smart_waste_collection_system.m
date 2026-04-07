load predicted_waste_data.mat; %This line opens the file containing the predicted daily waste generation per bin data which consists of 396 rows for 396 bins, the first column contains the bin ID, and the remaining columns contain waste generation for each day.
load original_waste_data.mat; %This line opens the file containing the daily waste generation per bin data which consists of 396 rows for 396 bins, the first column contains the bin ID, and the remaining columns contain waste generation for each day.
m=60; %bin capacity factor in terms of kilogram
f=0.9; %factor to check if the bin reached 90% of its capacity
c=1;
d=0;
predicted_waste=predicted_waste_data; %Assigning the predicted waste to the variable (waste)
actual_waste=original_waste_data; %Assigning the actual waste to the variable (actual_waste)
for a=2:31 %loop for columns 2 to 31 representing days 1 to 30 
    c=1;
    d=d+1;
    if a>=1 && a<31 %condition for the remaining days except the last day and starting day 4
       for b=1:396 %loop for 396 bins
        if predicted_waste(b,a)>=f*m %check if the amount of waste exceeds 90% of bin capacity
            collected_predicted_waste(b,a)=predicted_waste(b,a); %if yes, assign the predicted waste to be collected
            collected_actual_waste(b,a)=actual_waste(b,a); %record the actual amount of waste that has been collected
            selected_bin(c,d)=predicted_waste(b,1); %assign the bin to be collected
            c=c+1;
        else
            predicted_waste(b,a+1)=predicted_waste(b,a)+predicted_waste(b,a+1); %if no, accumulate the predicted waste to the next day
            actual_waste(b,a+1)=actual_waste(b,a)+actual_waste(b,a+1); %record the actual accumulated waste to the next day
            collected_predicted_waste(b,a)=0; %no predicted waste is assigned for collection
            collected_actual_waste(b,a)=0; %no actual waste is recorded for collection
        end
       end
    else if a==31 %condition for the last day
        for b=1:396 %loop for 396 bins
        if predicted_waste(b,a)>=f*m %check if the amount of waste exceeds 90% of bin capacity
        collected_predicted_waste(b,a)=predicted_waste(b,a); %if yes, assign the predicted waste to be collected
        collected_actual_waste(b,a)=actual_waste(b,a); %record the actual waste that has been collected
                    selected_bin(c,d)=predicted_waste(b,1); %assign the bin to be collected
            c=c+1;
        else
        collected_predicted_waste(b,a)=0; %if no, no predicted waste is assigned for collection
        collected_actual_waste(b,a)=0; %no actual waste is recorded for collection
        end 
        end
        end
    end
end