%Abdulkader Jalal 
% id 240302175
clear all 
clc

data = readtable('personality_dataset.csv'); 
data = rmmissing(data);

data.Stage_fear = strcmpi(data.Stage_fear,'Yes');
data.Drained_after_socializing = strcmpi(data.Drained_after_socializing,'Yes');
data.Personality=categorical(data.Personality);
personalities = categories(data.Personality);
avgdata = [];
%%max min
%max and min time spent alone
[~, max_Time_spent_Alone] = max(data.Time_spent_Alone);
[~, min_Time_spent_Alone] = min(data.Time_spent_Alone);

fprintf('Max time spent alone: Row %d (%.1f)\n', max_Time_spent_Alone, data.Time_spent_Alone(max_Time_spent_Alone));
fprintf('Min time spent alone: Row %d (%.1f)\n', min_Time_spent_Alone, data.Time_spent_Alone(min_Time_spent_Alone));


%correlation matrix
traits = [data.Time_spent_Alone,data.Social_event_attendance, ...
         data.Going_outside, data.Friends_circle_size,data.Post_frequency];

corrMatrix = corr(traits,'Type','Pearson');
disp('Correlation Matrix between social traits:');
disp(array2table(corrMatrix, ...
    'VariableNames', {'Alone','Events','Outside','Friends', 'Posts'}, ...
    'RowNames', {'Alone','Events','Outside','Friends','Posts'}));

%%for loop to see the of average social metrics by personality type
fprintf('\nAverage social metrics by personality type: \n');
for i=1:length(personalities)
    subset = data(data.Personality==personalities{i},:);
    avg = mean([subset.Time_spent_Alone, subset.Social_event_attendance, ...
             subset.Going_outside,subset.Friends_circle_size,subset.Post_frequency]);
    fprintf('%s: Alone=%.2f, Events=%.2f, Outside=%.2f, Friends=%.2f, Posts=%.2f\n\n', ...
            personalities{i},avg(1),avg(2),avg(3),avg(4) ,avg(5));
    avgdata =[avgdata;avg];
end

%custom function
%calculates social activity score

scores = social_activity_score(data.Friends_circle_size, data.Post_frequency, ...
                               data.Social_event_attendance, data.Going_outside);

display('First 5 Social activities Score');
disp(scores(1:5));



%VISUALIZATIONS
figure;
histogram(scores, 10);
title('Distribution of social activity scores');
xlabel('score'); 
ylabel('Frequenccy');

%we didn't take bar3 but i used the matlab documentation.
figure;
bar3(avgdata);
set(gca,'XTickLabel', {'Alone','Events','Outside','Friends','Posts'});
set(gca, 'YTickLabel',personalities);
xlabel('traits');
ylabel('personality type');
zlabel('Average score');
title('Avg traits by personality');

