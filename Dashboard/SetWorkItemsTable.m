%% Load workspace.
% Create a table from workspace variables and view it. When you import data from a
% file using these functions, each column becomes a table variable.
%
% Load project data from the |dashboard| MAT-file to workspace variables.

%load dashboard
%whos

%% Create and View Work Items Table.
% Populate a table with column-oriented variables that contain project data. 
% You can access and assign table variables by name. When you assign a table 
% variable from a workspace variable, you can assign the table variable a different 
% name.
%
% Create a table and populate it with the |ID|, |Name|, and |Typeoptional|, as
% well as these date variables |InBacklog|, |InDevelopment|,
% |DevDoneReview|, |InTest|, |TestDone|, |DeployedDev| and
% |SignedOff| workspace variables. 
WorkItemsTable = table(ID,Name,Typeoptional,InBacklog,InDevelopment,DevDoneReview,InTest,TestDone,DeployedDev,SignedOff);

%Display the first five rows.
WorkItemsTable(1:5,:)

%% Add Date Calculations.
% For each start date, and each end date, create a prior Sunday, in a matrix.
% This will give us the weeks we're going to use for our observations.
% Takes in the 'InDevelopment' and 'SignedOff' date arrays.
%
% Function 'weekday' returns: 
%   Sun = 1
%   Mon = 2
%   Tue = 3
%   Wed = 4
%   Thu = 5
%   Fri = 6
%   Sat = 7
%
PriorSundaysStart = InDevelopment-weekday(InDevelopment)+1;
PriorSundaysDone = SignedOff-weekday(SignedOff)+1;

% Add these columns to the table.
WorkItemsTable.PriorSundaysStart = PriorSundaysStart;
WorkItemsTable.PriorSundaysDone = PriorSundaysDone;

%% Add Work Items Cycle Time.
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

% Display the first five rows.
WorkItemsTable(1:5,:)

%% Add Year-Week Complete labels.
% Creates the Year-Week labels that will be used for filtering later.
% e.g. 2017-45, is week 45 in 2017.
YearWeekComplete = cell(size(SignedOff));

formatSpec = '%d-%d';
MyYear = year(SignedOff);
MyWeek = week(SignedOff);
CountYearWeeks = size(SignedOff);

% Loop from start (2) to end (x) in increment (1),
% and load the week start dates into it.
% Note the use of braces {} as we iterate through the cell array.
% See - http://matlab.wikia.com/wiki/FAQ#What_is_a_cell_array.3F
for i = 1:1:CountYearWeeks(1,1)
    YearWeekComplete{i,1} = sprintf(formatSpec,MyYear(i,1),MyWeek(i,1)); 
end

% Add this column to the table.
WorkItemsTable.YearWeekComplete = YearWeekComplete;

% Display the first five rows.
WorkItemsTable(1:5,:)

% Tidy up.
vars = {'formatSpec','MyYear','MyWeek','CountYearWeeks','i'};
clear(vars{:});