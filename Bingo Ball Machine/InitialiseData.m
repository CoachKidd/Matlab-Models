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
BingoBallMachine = 1:NumCheckForms;

%% Create NumBalls Variable.
% Create and populate a vector with a variable that contains the number of 'balls'
% in the 'bingo ball machine'. 
%
% Create a double array |NumBalls|.
NumBalls = NumCheckForms;

