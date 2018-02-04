function [BookUpdated] = UpdateDayBooks(BookPassed,BookName,DataPassed)
%% UpdateDayBooks
%   This function updates the day book that's passed in.

if BookName == 'DaybookStatisticsBoys'
    RowCount = size(BookPassed,1);
    % Add these values in a new row in the table.
    BookPassed.BoysMin(RowCount+1) = min(DataPassed);
    BookPassed.Boys25Quantile(RowCount+1) = quantile(DataPassed,.25);
    BookPassed.BoysMedian(RowCount+1) = median(DataPassed);
    BookPassed.BoysMean(RowCount+1) = mean(DataPassed);
    BookPassed.Boys50Quantile(RowCount+1) = quantile(DataPassed,.50);
    BookPassed.Boys75Quantile(RowCount+1) = quantile(DataPassed,.75);
    BookPassed.BoysMax(RowCount+1) = max(DataPassed);
    BookPassed.BoysSD(RowCount+1) = std(DataPassed);
    BookPassed.BoysVar(RowCount+1) = var(DataPassed);
    
elseif BookName == 'DaybookStatisticsGirl'
    RowCount = size(BookPassed,1);
    % Add these values in a new row in the table.
    BookPassed.GirlsMin(RowCount+1) = min(DataPassed);
    BookPassed.Girls25Quantile(RowCount+1) = quantile(DataPassed,.25);
    BookPassed.GirlsMedian(RowCount+1) = median(DataPassed);
    BookPassed.GirlsMean(RowCount+1) = mean(DataPassed);
    BookPassed.Girls50Quantile(RowCount+1) = quantile(DataPassed,.50);
    BookPassed.Girls75Quantile(RowCount+1) = quantile(DataPassed,.75);
    BookPassed.GirlsMax(RowCount+1) = max(DataPassed);
    BookPassed.GirlsSD(RowCount+1) = std(DataPassed);
    BookPassed.GirlsVar(RowCount+1) = var(DataPassed);

elseif BookName == 'DaybookScorecardBoys'
    % Add these values in a new row in the table.
    BookPassed = [BookPassed,DataPassed];
end

BookUpdated = BookPassed;
end

