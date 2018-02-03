function [BBM,Card] = DrawBall(Balls,Card,Checks)
%% DrawBall.
% This function draws a ball from our bingo ball machine, reads the value
% of it, updates the scorecard with the number on the ball, and then
% deletes it from the collection.

% How many balls have we got?
BallCount = length(Balls); 

    % Reseed the random number generator.
    % See - https://uk.mathworks.com/help/matlab/math/generate-random-numbers-that-are-different.html
    %rng('shuffle');
    %
    %Don't do this, it kills the processor - :-(
    
    % Draw the ball.
    r = randi(BallCount);
    
    % Read the value of the ball.
    v = Balls(1,r);
    
    % Update the scorecard, by incrementing the vector element corresponding the value just drawn.
    Card(1,v) = Card(1,v) + 1;
    
    % How many balls have we got left?
    % Discard the ball if > 1, otherwise we need to reload the bingo ball machine.
    if BallCount == 1
        Balls = LoadBalls(Checks);
    else
        Balls = DeleteBall(r,Balls);
    end
        
    % Pass back the collection.
    BBM = Balls;
    
end

function [BBM] = DeleteBall(ID,Balls)
%% DrawBall.
% This function removes an element ([ID]) from the vector passed ([Balls] -
% our bingo ball machine').

    % Remove the vector element.
    BBM = Balls;
    BBM(ID)=[];
    
end