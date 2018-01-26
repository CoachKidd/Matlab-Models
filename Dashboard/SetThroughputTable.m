%% Create Throughput Array.
% Populate a table with column-oriented variables that contain throughput data. 
% You can access and assign table variables by name. When you assign a table 
% variable from a workspace variable, you can assign the table variable a different 
% name.
%
% Create a table and populate it with the |Gender|, |Smoker|, |Height|, and
% |Weight| workspace variables. Display the first five rows.

MinWeekStarting = min(PriorSundaysStart);
MaxWeekStarting = max(PriorSundaysStart);

CountofWeeks = datenum(MaxWeekStarting) - datenum(MinWeekStarting);
CountofWeeks = (CountofWeeks / 7) + 1;

% Create a datetime array |ThroughPut|.
WeekStarting = datetime(MinWeekStarting);

% Loop from start (2) to end (x) in increment (1),
% and load the week start dates into it.
for i = 2:1:CountofWeeks
    WeekStarting(i,1) = WeekStarting(i-1,1) + 7; 
end

% Tidy up.
vars = {'MinWeekStarting','MaxWeekStarting','CountofWeeks'};
clear(vars{:});

%% Create and View Throughput Table.
% Populate a table with column-oriented variables that contain project data. 
% You can access and assign table variables by name. When you assign a table 
% variable from a workspace variable, you can assign the table variable a different 
% name.
%
% Create a table and populate it with the |WeekStarting| workspace variable. 
ThroughputTable = table(WeekStarting);

%Display the first five rows.
ThroughputTable(1:5,:)

%% Add Year-Week Complete labels.
% Creates the Year-Week labels that will be used for filtering later.
% e.g. 2017-45, is week 45 in 2017.
YearWeekGroups = cell(size(WeekStarting));

formatSpec = '%d-%d';
MyYearGroup = year(ThroughputTable.WeekStarting);
MyWeekGroup = week(ThroughputTable.WeekStarting);
CountYearWeeks = size(WeekStarting);

% Loop from start (2) to end (x) in increment (1),
% and load the week start dates into it.
% Note the use of braces {} as we iterate through the cell array.
% See - http://matlab.wikia.com/wiki/FAQ#What_is_a_cell_array.3F
for i = 1:1:CountYearWeeks(1,1)
    YearWeekGroups{i,1} = sprintf(formatSpec,MyYearGroup(i,1),MyWeekGroup(i,1)); 
end

% Add this column to the table.
ThroughputTable.WeekGroups = YearWeekGroups;

% Display the first five rows.
ThroughputTable(1:5,:)

% Tidy up.
vars = {'formatSpec','MyYearGroup','MyWeekGroup','CountYearWeeks','i'};
clear(vars{:});

%% Calculate Throughput base on week groups.
% For each week group in this table {ThroughputTable} count the.
% completed dates.
TmpTbl = tabulate(YearWeekComplete);


%rows = {WorkItemsTable.YearWeekComplete=='2017-45'};
%vars = {'YearWeekComplete','SignedOff'};
%T3 = WorkItemsTable(rows,vars);

%for i = 1:1:CountYearWeeks(1,1)
%    CountofThroughput = WorkItemsTable({:,YearWeekComplete} == ThroughputTable.WeekGroups(i,2),:);   
%end