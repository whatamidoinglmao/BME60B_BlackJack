% 
%  BME 60B, Fangyuan Ding, MWF 4:00 - 4:50pm
%  
%  Group 12:
%  [NAMES GO HERE]
%  
%  Last Update:
%  [DATE]
% 
%%=========================================================================

%% todo
% 1. create function, takes player count as input and outputs x players
%       with empty hands - TAIR
%
% 2. create class that handles gamestate (has methods that updates player
%       hands and scores, can find winner in the end) - ELIAN
%
% 3. create a class that handles player hands (has methods like hitting,
%       standing, etc.) - KENT
%     
% 4. create function that takes each player as input and outputs the player's
%       hand with 2 cards for initializing game (test with player1&2&3 for now) 
%           
%%

%% long time todo
% 1. differentiate face cards
% 2. differentiate suits
%%


% inital clear
clear
clc

% initialize new deck using cardDeck class
deck = cardDeck;

% calls shuffle function and shuffles the deck
deck.d = deck.shuffle();

while true
    playerNumber = input(newline + "How many players? (MIN 2, MAX 10): ");
    playerNumber = round(playerNumber);

    if playerNumber > 1 & playerNumber < 11 %#ok<*AND2> idk this just suppresses some matlab error
        fprintf('\nPerfect! You chose: %d players\n', playerNumber)
        break
    
    else
        fprintf('\nNot a valid number of players.\n')
    end
end

while true
    realPlayer = input(newline + "How many real players? Input: ");
    realPlayer = round(realPlayer);

    if realPlayer > 0 & realPlayer <= playerNumber
    fprintf('\nPerfect! You chose: %d real player(s)\n', realPlayer)
    break

    else
        fprintf('\nNot a valid number of real players.\n')
    end
end

% initiate all players (bots) based on the input
for i = 1:playerNumber
    eval(['player' num2str(i) '= player(true);']);
end

% Reiterates realPlayers into the first players
if realPlayer<=playerNumber
    for i = 1:realPlayer
        eval(['player' num2str(i) '= player(false);']);
    end
end
clear i;



input(newline + "Press enter to start game.");

% hands out all players 2 cards to start game
for i = 1:playerNumber
    eval(['[player' num2str(i) '.playerHand, player' num2str(i) ...
        '.playerCard, deck.d] = player' num2str(i) '.init(deck);']);
end

% game is finished being setup, begin hit/stand phase

%gameState
Game = true;
round = 1;
validPlayers = true(1, playerNumber); % create a logical array for valid players

while Game
    fprintf(['\n====================================\n' ...
        'Round: %d\n'],round);

    % Cycle through each player
    for i=1:playerNumber
        % Checking if deck length >0 and ending game if no cards left
        if isempty(deck.d)
            Game = false;
            disp(newline + "Error: Ending game - Ran out of cards somehow..." + newline)
        end
        % Determines if the player can play (no Busts or Stands)
        if eval(['player' num2str(i) '.canPlay'])
            if eval(['player' num2str(i) '.playerValue>21']) &&...
                    ismember([double(11)],eval(['player' num2str(i) '.playerHand']))
                eval(['player' num2str(i) '.Ace();'])
            end
            fprintf('\n------------------------------------\nCurrent Player: Player%d - Score: %d\n',i,eval(['player' num2str(i) '.playerValue;']));
            % Determines player process
            if eval(['~player' num2str(i) '.dealer'])

                while true
                    % Decision to hit
                    decision = input("Hit or Stand (H/S)? ","s");

                    if lower(decision) == 'h'
                        eval(['[deck.d,name,value] = player' num2str(i) '.Hit(deck);'])
                        fprintf('You hit a %s. You new score is: %d\n', name, eval(['player' num2str(i) '.playerValue;']))
                        break
                    % Decision to stand
                    elseif lower(decision) == 's'
                        eval(['player' num2str(i) '.canPlay = false;'])
                        fprintf('You decided to stand. Your final hand is worth: %d\n', eval(['player' num2str(i) '.playerValue;']))
                        break

                    %error on invalid input
                    else
                        disp(newline + "Invalid input." + newline)
                    end
                end

                % if a player gets a blackjack
                if eval(['player' num2str(i) '.playerValue==21'])
                    eval(['player' num2str(i) '.canPlay = false;'])
                    disp(newline + "nice. its blackjackin' time" + newline)
                end

                if eval(['player' num2str(i) '.playerValue>21'])
                    eval(['player' num2str(i) '.canPlay = false;'])
                    disp(newline + "oops lol u went bust" + newline)
                end
                % Determines if player has Ace in hand
                if eval(['player' num2str(i) '.playerValue>21']) &&...
                        ismember([double(11)],eval(['player' num2str(i) '.playerHand']))
                    eval(['player' num2str(i) '.Ace();'])
                end
                
            % Determines Dealer process
            else
                input("Press enter to make bot move.");
                
                if eval(['player' num2str(i) '.playerValue<=16'])
                    eval(['[deck.d, name, value] = player' num2str(i) '.Hit(deck);'])
                    fprintf('Bot had decided to hit and got a %s. New score: %d\n', name, eval(['player' num2str(i) '.playerValue;']))

                    % Determines if bot has Ace in hand
                    if eval(['player' num2str(i) '.playerValue>21']) &&...
                    ismember([double(11)],eval(['player' num2str(i) '.playerHand']))
                        eval(['player' num2str(i) '.Ace();'])
                    end
                else
                    eval(['player' num2str(i) '.canPlay = false;'])
                    disp("Bot has decided to stand/gone bust.")
                end
            end
        end
    end
    % Checking if all players can't play
    for i=1:playerNumber

        % sets the logical to false if a player can't play
        if eval(['~player' num2str(i) '.canPlay'])
            validPlayers(i) = false;
        end
        
        % if no valid players, the game ends
        if ~any(validPlayers)
            Game = false;
        end
        
    end

    round = round + 1;
end

% Checking for Win Condition (the highest score >= 21)
winnerValue = 0;

for i = 1:playerNumber
    % Clearing hand to set playerHand to 0, if cards > 21
    if eval(['player' num2str(i) '.playerValue>21'])
        eval(['player' num2str(i) '.playerHand=[0,0];'])
    end
    % Updating for new high score
    if eval(['player' num2str(i) '.playerValue>winnerValue'])
        eval(['winnerValue = player' num2str(i) '.playerValue;'])
    end
end

% crowning and announcing winners
winnerIndex = false(1,playerNumber);

for i = 1:playerNumber

    % sets spot in winner index to true if the player has winning value
    if eval(['player' num2str(i) '.playerValue == winnerValue'])
        winnerIndex(i) = true;
    end

end

winners = find(winnerIndex);
winnerText = ['\nGame Complete! Winners:\n' repmat('Player%d ', 1, length(winners)) '\n'];
fprintf(winnerText, winners);
fprintf('...with a score of: %d!\n', winnerValue);

