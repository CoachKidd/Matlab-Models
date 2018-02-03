function [BBM] = LoadBalls(NumChecks)
%% LoadBalls.
% This function populates a vector (our 'bingo ball machine'), with integers
% (our balls) from 1 to the count of Check forms we want to simulate using. 

    % Create a vector |BingoBallMachine|, of size [NumChecks]
    % and populate it with integer increments starting at 1.
    BBM = 1:NumChecks;
    
end
