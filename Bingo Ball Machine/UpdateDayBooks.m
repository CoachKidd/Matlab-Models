function [BookUpdated] = UpdateDayBooks(BookPassed,BookName,DataPassed)
%% UpdateDayBooks
%   This function updates the day book that's passed in.

if BookName == 'DaybookStatisticsBoys'
    
    
elseif BookName == 'DaybookStatisticsGirl'
    RowCount = size(BookPassed,1);
    

elseif BookName == 'DaybookScorecardBoys'
    % Add these values in a new row in the table.
    BookPassed = [BookPassed,DataPassed];
end

BookUpdated = BookPassed;
end

