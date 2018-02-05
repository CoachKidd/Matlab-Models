%% Reset the scorecards
% ...
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

%% Update Day Books with Calculated Stats.
%

if exist('DaybookStatisticsBoys','var') == 0 
    % Add these values in a new row in the table.;
    DaybookStatisticsBoys = table();
    DaybookStatisticsBoys.Properties.VariableNames = {'BoysMin','Boys25Quantile','BoysMedian','BoysMean','Boys50Quantile','Boys75Quantile','BoysMax','BoysSD','BoysVar'};
    DaybookStatisticsBoys{1,1} = min(ScorecardBoys);
    DaybookStatisticsBoys{1,2} = quantile(ScorecardBoys,.25);
    DaybookStatisticsBoys{1,3} = median(ScorecardBoys);
    DaybookStatisticsBoys{1,4} = mean(ScorecardBoys);
    DaybookStatisticsBoys{1,5} = quantile(ScorecardBoys,.50);
    DaybookStatisticsBoys{1,6} = quantile(ScorecardBoys,.75);
    DaybookStatisticsBoys{1,7} = max(ScorecardBoys);
    DaybookStatisticsBoys{1,8} = std(ScorecardBoys);
    DaybookStatisticsBoys{1,9} = var(ScorecardBoys);
else
    % Check the day book for the current number of rows.
    RowCount = size(DaybookStatisticsBoys,1);
    % Add these values in a new row in the table.
    DaybookStatisticsBoys{RowCount+1,1} = min(ScorecardBoys);
    DaybookStatisticsBoys{RowCount+1,2} = quantile(ScorecardBoys,.25);
    DaybookStatisticsBoys{RowCount+1,3} = median(ScorecardBoys);
    DaybookStatisticsBoys{RowCount+1,4} = mean(ScorecardBoys);
    DaybookStatisticsBoys{RowCount+1,5} = quantile(ScorecardBoys,.50);
    DaybookStatisticsBoys{RowCount+1,6} = quantile(ScorecardBoys,.75);
    DaybookStatisticsBoys{RowCount+1,7} = max(ScorecardBoys);
    DaybookStatisticsBoys{RowCount+1,8} = std(ScorecardBoys);
    DaybookStatisticsBoys{RowCount+1,9} = var(ScorecardBoys);
end



% Assuming that table 'volTbl' exists in the workspace with a column 'Variance'
%>> volTbl.Variance = [];
% In case 'v' is a scalar value, use the syntax 'table.ColumnName{rowNumber, colNumber} = value' to assign the value of 'v' into a cell in the 'Variance' column of the table.
%>> volTbl.Variance{1,1} = v;
% In case 'v' is a matrix, use the syntax 'table.ColumnName = v' where v is a cell matrix whose number of rows is equal to the number of rows in the table.
%volTbl.Variance = v;


%% The day book for the Check Form distributuion statistics for the girls.
RowCount = size(DaybookStatisticsGirls,1);
% Add these values in a new row in the table.
DaybookStatisticsGirls.GirlsMin(RowCount+1) = min(ScorecardGirls);
DaybookStatisticsGirls.Girls25Quantile(RowCount+1) = quantile(ScorecardGirls,.25);
DaybookStatisticsGirls.GirlsMedian(RowCount+1) = median(ScorecardGirls);
DaybookStatisticsGirls.GirlsMean(RowCount+1) = mean(ScorecardGirls);
DaybookStatisticsGirls.Girls50Quantile(RowCount+1) = quantile(ScorecardGirls,.50);
DaybookStatisticsGirls.Girls75Quantile(RowCount+1) = quantile(ScorecardGirls,.75);
DaybookStatisticsGirls.GirlsMax(RowCount+1) = max(ScorecardGirls);
DaybookStatisticsGirls.GirlsSD(RowCount+1) = std(ScorecardGirls);
DaybookStatisticsGirls.GirlsVar(RowCount+1) = var(ScorecardGirls);

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