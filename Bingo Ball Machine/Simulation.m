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
    
    % Display what we've done.
    %Display = ['SchoolCount=', num2str(SchoolCount), ', BoyCount=', num2str(BoyCount), ', GirlCount=', num2str(GirlCount)];
    %disp(Display)
    
end

%% Update Day Books with Calculated Stats.
%

DaybookStatisticsBoys = UpdateDayBooks(DaybookStatisticsBoys,'DaybookStatisticsBoys',ScorecardBoys);
DaybookStatisticsGirls = UpdateDayBooks(DaybookStatisticsGirl,'DaybookStatisticsGirls',ScorecardGirls);

DaybookScorecardBoys = UpdateDayBooks(DaybookScorecardBoys,'DaybookScorecardBoys',ScorecardBoys);

% Tidy up.
%vars = {'RowCount'};
%clear(vars{:});

%% Generate Bar Charts
% Create the bar charts.
CreateBarChartBoys(ScorecardBoys);
CreateBarChartGirls(ScorecardGirls);

%% Generate Boxplots
% Create the boxplots.
figure3 = figure('Name','Boxplot - Boys');
boxplot(ScorecardBoys);
title('Boxplot of Check Distribution - Boys');
ylabel('Check Form Usage Count');

% Overlay the mean as green diamonds
hold on
plot(mean(ScorecardBoys), 'dg')
hold off

%% Generate Histograms
% Create the histograms.
CreateHistogramBoys(ScorecardBoys);
ylabel({'Check Form Distribution'});
title({'Histogram of Check Distribution - Boys'});