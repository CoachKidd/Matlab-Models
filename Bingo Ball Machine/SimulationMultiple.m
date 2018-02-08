%% Iitialise Simulation Loop
% ...

disp('Calculating Yr 4 Pupil distributions.')

% Create array to store statistics for base data - distribution of Year 4 boys and girls for the population of schools.
% Row 1 = Boys
% Row 2 = Girls
% Row 3 = Combined
DataStatistics(1,1) = min(SchoolsData{:,3});
DataStatistics(1,2) = quantile(SchoolsData{:,3},.05);
DataStatistics(1,3) = quantile(SchoolsData{:,3},.25);
DataStatistics(1,4) = quantile(SchoolsData{:,3},.5);
DataStatistics(1,5) = quantile(SchoolsData{:,3},.75);
DataStatistics(1,6) = quantile(SchoolsData{:,3},.95);
DataStatistics(1,7) = max(SchoolsData{:,3});

DataStatistics(2,1) = min(SchoolsData{:,2});
DataStatistics(2,2) = quantile(SchoolsData{:,2},.05);
DataStatistics(2,3) = quantile(SchoolsData{:,2},.25);
DataStatistics(2,4) = quantile(SchoolsData{:,2},.5);
DataStatistics(2,5) = quantile(SchoolsData{:,2},.75);
DataStatistics(2,6) = quantile(SchoolsData{:,2},.95);
DataStatistics(2,7) = max(SchoolsData{:,2});

DataStatistics(3,1) = min(SchoolsData{:,4});
DataStatistics(3,2) = quantile(SchoolsData{:,4},.05);
DataStatistics(3,3) = quantile(SchoolsData{:,4},.25);
DataStatistics(3,4) = quantile(SchoolsData{:,4},.5);
DataStatistics(3,5) = quantile(SchoolsData{:,4},.75);
DataStatistics(3,6) = quantile(SchoolsData{:,4},.95);
DataStatistics(3,7) = max(SchoolsData{:,4});

disp('Yr 4 Pupil distribution Calculations complete.')

% Count Simulations to run.
disp(['Running ' num2str(NumSimulations) ' simulations of ' num2str(NumCheckForms) ' Check Form distributions.'])

for SimulationCount = 1:1:NumSimulations
    %% Initialise Schools loop
    % Set the outer loop for the number of schools.

    % Count Schools.
     NumSchools = size(SchoolsData,1);

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
    % Note: Abandoned using tables for the daybooks. Advantage was inbuilt row
    % headers, but disadvantages are that they are complex to manipulate, and
    % expensive (in memory) to dynamically configure (i.e. grow).
    
    % Add the ScoreCard statistics to the statistics DayBook, for the boys.
    DaybookStatisticsBoys(SimulationCount,1) = min(ScorecardBoys);
    DaybookStatisticsBoys(SimulationCount,2) = quantile(ScorecardBoys,.25);
    DaybookStatisticsBoys(SimulationCount,3) = mean(ScorecardBoys);
    DaybookStatisticsBoys(SimulationCount,4) = median(ScorecardBoys);
    DaybookStatisticsBoys(SimulationCount,5) = quantile(ScorecardBoys,.75);
    DaybookStatisticsBoys(SimulationCount,6) = max(ScorecardBoys);
    DaybookStatisticsBoys(SimulationCount,7) = std(ScorecardBoys);
    DaybookStatisticsBoys(SimulationCount,8) = var(ScorecardBoys);

    % Add the ScoreCard statistics to the statistics DayBook, for the girls.
    DaybookStatisticsGirls(SimulationCount,1) = min(ScorecardGirls);
    DaybookStatisticsGirls(SimulationCount,2) = quantile(ScorecardGirls,.25);
    DaybookStatisticsGirls(SimulationCount,3) = mean(ScorecardGirls);
    DaybookStatisticsGirls(SimulationCount,4) = median(ScorecardGirls);
    DaybookStatisticsGirls(SimulationCount,5) = quantile(ScorecardGirls,.75);
    DaybookStatisticsGirls(SimulationCount,6) = max(ScorecardGirls);
    DaybookStatisticsGirls(SimulationCount,7) = std(ScorecardGirls);
    DaybookStatisticsGirls(SimulationCount,8) = var(ScorecardGirls);

    % Now append the ScoreCards to the ScoreCards DayBooks.
    DaybookScorecardBoys(SimulationCount,:) = ScorecardBoys;
    DaybookScorecardGirls(SimulationCount,:) = ScorecardGirls;
    
    % Report the iteration count to the command window.
    disp(['Simulation iteration ' num2str(SimulationCount) ' complete.'])

end

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