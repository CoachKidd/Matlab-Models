%% Add Year-Week Start labels.
% Creates the Year-Week labels that will be used for filtering later (delta for Responsiveness chart).
% e.g. 2017-45, is week 45 in 2017.
YearWeekStart = num2str(year(InDevelopment)) + "-" + num2str(week(InDevelopment));

% Strip out unwanted leading spaces (comes from conversion of the weeks)
% being a 3 char string to accomodate the "NaN" values.
% View the variable to see this in action.
YearWeekStart = replace(YearWeekStart," ","");

% Add this column to the table.
WorkItemsTable.YearWeekStart = YearWeekStart;

%% Add Year-Week Complete labels.
% Creates the Year-Week labels that will be used for filtering later (delta for Responsiveness chart).
% e.g. 2017-45, is week 45 in 2017.
YearWeekComplete = num2str(year(SignedOff)) + "-" + num2str(week(SignedOff));

% Strip out unwanted leading spaces (comes from conversion of the weeks)
% being a 3 char string to accomodate the "NaN" values.
% View the variable to see this in action.
YearWeekComplete = replace(YearWeekComplete," ","");

% Add this column to the table.
WorkItemsTable.YearWeekComplete = YearWeekComplete;

%% Throughput - Calculate Total.
% For each week group in this table {ThroughputTable} count the.
% completed dates.
% Tabulate creates a frequency table, based on a vector passed.
TmpTbl = tabulate(YearWeekComplete);

% Sort on first column - Year-Week. 
TmpTbl = sortrows(TmpTbl,1);

% Create (preallocate) the throughput vectors.
RowCount = size(TmpTbl,1);
ThroughputBins = strings(RowCount,1);
ThroughputTotals = zeros(RowCount,1);

for i = 1:RowCount
    ThroughputBins(i,1) = TmpTbl(i,1);
    % Note the {} braces here, as conversion to double from cell is not possible.
    ThroughputTotals(i,1) = TmpTbl{i,2};
end

% Tidy up.
vars = {'TmpTbl','RowCount'};
clear(vars{:});

%% Throughput - Calculate Defects.
%
% Create (preallocate) the throughput vectors.
RowCount = size(ThroughputBins,1);
ThroughputBugs = zeros(RowCount,1);

% Build vector.
for i = 1:RowCount
    % Prepare index.
    idx = WorkItemsTable.YearWeekComplete == ThroughputBins(i,1) & WorkItemsTable.Type == "Bug";
    
    % Count the true values returned in the index,
    % and add this count to the vector
    ThroughputBugs(i,1) = sum(idx(:) == 1);
end

% Tidy up.
vars = {'idx','RowCount'};
clear(vars{:});
%% Throughput - Calculate Stories.
%

% Create (preallocate) the throughput vectors.
RowCount = size(ThroughputBins,1);
ThroughputStories = zeros(RowCount,1);

% Build vector.
for i = 1:RowCount
    % Prepare index.
    idx = WorkItemsTable.YearWeekComplete == ThroughputBins(i,1) & WorkItemsTable.Type == "Product Backlog Item";
    
    % Count the true values returned in the index,
    % and add this count to the vector
    ThroughputStories(i,1) = sum(idx(:) == 1);
end

% Tidy up.
vars = {'idx','RowCount'};
clear(vars{:});

%% Quality - Calculate Defects as Average of Throughput.
%

% Note the use of the Right array division (or rdivide) notation.
% x = A./B divides each element of A by the corresponding element of B.
QualityAverageBugs = ThroughputBugs ./ (ThroughputBugs + ThroughputStories);

%% Quality - Calculate overall weighted average defect rate.
%

QualityWeightedAverage = mean(QualityAverageBugs);

%% Responsiveness - Add Work Items Cycle Time.
% Calculate the cycle time each item has taken to complete, format into days.
% Creates a |CycleTimeDays] array, based on the difference between start
% and end dates.
CycleTimeDays = SignedOff - InDevelopment;
CycleTimeDays.Format = 'd';

% Update any 0 days ('done' same day) to 0.5 days.
CycleTimeDays(CycleTimeDays == 0) = 0.5;

% Add this column to the table.
WorkItemsTable.CycleTime = CycleTimeDays;

% Populate the variable units and variable descriptions properties for |CycleTime|.
% You can add metadata to any table variable to describe further the data
% contained in the variable.
WorkItemsTable.Properties.VariableUnits{'CycleTime'} = 'Days';
WorkItemsTable.Properties.VariableDescriptions{'CycleTime'} = 'Cycle Time';

%% Responsiveness - Calculate Totals.
% For each week group in the {YearWeekStart} vector, count the
% start dates.
% Tabulate creates a frequency table for us, based on a vector passed.
TmpTbl = tabulate(YearWeekStart);

% Sort on first column - Year-Week. 
TmpTbl = sortrows(TmpTbl,1);

% Create (preallocate) the throughput vectors.
RowCount = size(TmpTbl,1);
ResponsivenessBins = strings(RowCount,1);
ResponsivenessStarted = zeros(RowCount,1);

for i = 1:RowCount
    ResponsivenessBins(i,1) = TmpTbl(i,1);
    % Note the {} braces here, as conversion to double from cell is not possible.
    ResponsivenessStarted(i,1) = TmpTbl{i,2};
end

% Tidy up.
vars = {'TmpTbl','RowCount'};
clear(vars{:});

%% Alternative - Responsiveness table.
% Consider creating a sub-table, with unique Year-Week values, and totals.
U = unique(YearWeekStart);

% Solution needs to be more elegant. i.e. Current crunching doesn't allow
% for weeks which may occur where work is neither start nor finished.  In
% this case, the Year-Week wouldn't be calculated.
% 
% Therefore, a better solution would be to take the first and last dates,
% and create a master Year-Week array from this information.  Then, using
% this array, iterate through to create the child arrays.
%
% The table would hold [Started this Week][Completed this Week][Delta]
% field values. 


%% Boxplots - the results.
% https://uk.mathworks.com/help/stats/boxplot.html
%
% boxplot(x) creates a box plot of the data in x. 
% If x is a vector, boxplot plots one box. If x is a matrix, boxplot plots one box for each column of x.
% On each box, the central mark indicates the median, and the bottom and top edges of the box indicate 
% the 25th and 75th percentiles, respectively. The whiskers extend to the most extreme data points not considered outliers, 
% and the outliers are plotted individually using the '+' symbol.