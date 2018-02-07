%% Reset the scorecards
% Pre-allocating array size is less expensive in memory allocation.
ScorecardGirls = zeros(1,NumCheckForms);
ScorecardBoys = zeros(1,NumCheckForms);

%% Initialise Schools loop
% Set the outer loop for the number of schools.

% Count Schools
 NumSchools = size(SchoolsData,1);

%% Loop through Schools

% Loop from start (1) to end (NumSchools) in increment (1).
for SchoolCount = 1:1:NumSchools
    
    NumBoys = SchoolsData.Boys_max(SchoolCount); 
    NumGirls = SchoolsData.Girls_max(SchoolCount);
    
    % Initialise the bingo ball machine, for boys.
    BingoBallMachine = LoadBalls(NumCheckForms);
    
    % Loop through BoyCount
    for BoyCount = 1:1:NumBoys
        
        % Draw a ball - using our bingo ball machine, update the boys scorecard.
        [BingoBallMachine,ScorecardBoys] = DrawBall(BingoBallMachine,ScorecardBoys,NumCheckForms);
        
    end
    
    % Initialise the bingo ball machine, for girls.
    BingoBallMachine = LoadBalls(NumCheckForms);
    
    % Loop through GirlCount
    for GirlCount = 1:1:NumGirls
        
        % Draw a ball - using our bingo ball machine, update the boys scorecard.
        [BingoBallMachine,ScorecardGirls] = DrawBall(BingoBallMachine,ScorecardGirls,NumCheckForms);
        
    end    
    
end

%% Update data statistics
%

DataStatistics(1,1) = min(SchoolsData(:,2));
DataStatistics(1,2) = quantile(ScorecardBoys,.25);
DataStatistics(1,3) = median(ScorecardBoys);
DataStatistics(1,4) = mean(ScorecardBoys);
DataStatistics(1,5) = quantile(ScorecardBoys,.50);
DataStatistics(1,6) = quantile(ScorecardBoys,.75);
DataStatistics(1,7) = max(ScorecardBoys);
DataStatistics(1,8) = std(ScorecardBoys);
DataStatistics(1,9) = var(ScorecardBoys);
%% Update Day Books with Calculated Stats.
%
% Note: Abandoned using tables for the daybooks. Advantage was inbuilt row
% headers, but disadvantages are that they are complex to manipulate, and
% expensive (in memory) to dynamically configure (i.e. grow).
RowCount = size(DaybookStatisticsBoys,1);
if RowCount == 0 
    % Add these values in a new row in the array.;
    DaybookStatisticsBoys(1,1) = min(ScorecardBoys);
    DaybookStatisticsBoys(1,2) = quantile(ScorecardBoys,.25);
    DaybookStatisticsBoys(1,3) = median(ScorecardBoys);
    DaybookStatisticsBoys(1,4) = mean(ScorecardBoys);
    DaybookStatisticsBoys(1,5) = quantile(ScorecardBoys,.50);
    DaybookStatisticsBoys(1,6) = quantile(ScorecardBoys,.75);
    DaybookStatisticsBoys(1,7) = max(ScorecardBoys);
    DaybookStatisticsBoys(1,8) = std(ScorecardBoys);
    DaybookStatisticsBoys(1,9) = var(ScorecardBoys);
else
    % Add these values in a new row in the table.
    DaybookStatisticsBoys(RowCount+1,1) = min(ScorecardBoys);
    DaybookStatisticsBoys(RowCount+1,2) = quantile(ScorecardBoys,.25);
    DaybookStatisticsBoys(RowCount+1,3) = median(ScorecardBoys);
    DaybookStatisticsBoys(RowCount+1,4) = mean(ScorecardBoys);
    DaybookStatisticsBoys(RowCount+1,5) = quantile(ScorecardBoys,.50);
    DaybookStatisticsBoys(RowCount+1,6) = quantile(ScorecardBoys,.75);
    DaybookStatisticsBoys(RowCount+1,7) = max(ScorecardBoys);
    DaybookStatisticsBoys(RowCount+1,8) = std(ScorecardBoys);
    DaybookStatisticsBoys(RowCount+1,9) = var(ScorecardBoys);
end

RowCount = size(DaybookStatisticsGirls,1);
if RowCount == 0 
    % Add these values in a new row in the array.;
    DaybookStatisticsGirls(1,1) = min(ScorecardGirls);
    DaybookStatisticsGirls(1,2) = quantile(ScorecardGirls,.25);
    DaybookStatisticsGirls(1,3) = median(ScorecardGirls);
    DaybookStatisticsGirls(1,4) = mean(ScorecardGirls);
    DaybookStatisticsGirls(1,5) = quantile(ScorecardGirls,.50);
    DaybookStatisticsGirls(1,6) = quantile(ScorecardGirls,.75);
    DaybookStatisticsGirls(1,7) = max(ScorecardGirls);
    DaybookStatisticsGirls(1,8) = std(ScorecardGirls);
    DaybookStatisticsGirls(1,9) = var(ScorecardGirls);
else
    % Add these values in a new row in the table.
    DaybookStatisticsGirls(RowCount+1,1) = min(ScorecardGirls);
    DaybookStatisticsGirls(RowCount+1,2) = quantile(ScorecardGirls,.25);
    DaybookStatisticsGirls(RowCount+1,3) = median(ScorecardGirls);
    DaybookStatisticsGirls(RowCount+1,4) = mean(ScorecardGirls);
    DaybookStatisticsGirls(RowCount+1,5) = quantile(ScorecardGirls,.50);
    DaybookStatisticsGirls(RowCount+1,6) = quantile(ScorecardGirls,.75);
    DaybookStatisticsGirls(RowCount+1,7) = max(ScorecardGirls);
    DaybookStatisticsGirls(RowCount+1,8) = std(ScorecardGirls);
    DaybookStatisticsGirls(RowCount+1,9) = var(ScorecardGirls);
end

% Tidy up.
vars = {'RowCount'};
clear(vars{:});

%% Concatenate the new Scorecard data to the bottom of the Daybooks.
if size(DaybookScorecardBoys,1) == 0
    DaybookScorecardBoys = ScorecardBoys;
else
    DaybookScorecardBoys = [DaybookScorecardBoys; ScorecardBoys];
end

if size(DaybookScorecardGirls,1) == 0
    DaybookScorecardGirls = ScorecardGirls;
else
    DaybookScorecardGirls = [DaybookScorecardGirls; ScorecardGirls];
end

% Tidy up.
vars = {'RowCount'};
clear(vars{:});

%% Generate Bar Charts
% Create the bar charts.
%CreateBarChartBoys(ScorecardBoys);
%CreateBarChartGirls(ScorecardGirls);

%% Generate Boxplots
% Create the boxplots.
%figure3 = figure('Name','Boxplot - Boys');
%boxplot(ScorecardBoys);
%title('Boxplot of Check Distribution - Boys');
%ylabel('Check Form Usage Count');

% Overlay the mean as green diamonds
%hold on
%plot(mean(ScorecardBoys), 'dg')
%hold off

%% Generate Histograms
% Create the histograms.
%CreateHistogramBoys(ScorecardBoys);
%ylabel({'Check Form Distribution'});
%title({'Histogram of Check Distribution - Boys'});