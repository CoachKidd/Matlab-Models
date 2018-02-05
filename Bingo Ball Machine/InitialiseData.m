%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/andrewkidd/Documents/GitHub/Resources/Bingo Ball Machine/Data.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2018/02/02 17:07:36

%% Initialize variables.
filename = '/Users/andrewkidd/Documents/GitHub/Resources/Bingo Ball Machine/Data.csv';
delimiter = ',';
startRow = 2;

%% Read columns of data as text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r','n','UTF-8');
% Skip the BOM (Byte Order Mark).
fseek(fileID, 3, 'bof');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[2,3,4]
    % Converts text in the input cell array to numbers. Replaced non-numeric
    % text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% Split data into numeric and string columns.
rawNumericColumns = raw(:, [2,3,4]);
rawStringColumns = string(raw(:, 1));


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
SchoolsData = table;
SchoolsData.ID = rawStringColumns(:, 1);
SchoolsData.Girls_max = cell2mat(rawNumericColumns(:, 1));
SchoolsData.Boys_max = cell2mat(rawNumericColumns(:, 2));
SchoolsData.Total = cell2mat(rawNumericColumns(:, 3));

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp rawNumericColumns rawStringColumns R;

%% Create CheckForms Variable.
% Create and populate a vector with a variable that contains the number of Check Forms. 
%
% Create a double array |NumCheckForms|.
NumCheckForms = 20;

%% Create ScorecardBoys Vector.
% Create and initilise a vector for storing the Check Form allocation to boys. 
%
% Create a double array |ScorecardBoys|.
ScorecardBoys = zeros(1,NumCheckForms);

%% Create ScorecardGirls Vector.
% Create and initilise a vector for storing the Check Form allocation to girls. 
%
% Create a double array |ScorecardGirls|.
ScorecardGirls = zeros(1,NumCheckForms);

%% Create BingoBallMachine Vector.
% Create and initilise a vector which will store the virtual 'bingo balls'.
% The value of each 'ball' (vector position) corresponds to a Check Form.
% As a 'ball' is drawn from the 'machine', that vector position is then
% deleted from the array, to simulate the ball no longer being available
% for being drawn again.
%
% Create a double array |BingoBallMachine|.
%BingoBallMachine = 1:NumCheckForms;
BingoBallMachine = LoadBalls(NumCheckForms);

%% Create NumBalls Variable.
% Create and populate a vector with a variable that will contain the number of 'balls'
% in the 'bingo ball machine'. 
%
% Create a double array |NumBalls|.
NumBalls = NumCheckForms;

%% Create Day Books.
% Create arrays to store simulation statistics. 

DaybookStatisticsBoys = table();
DaybookStatisticsGirls = table();

DaybookScorecardBoys = zeros(0,20);
DaybookScorecardGirls = zeros(0,20);