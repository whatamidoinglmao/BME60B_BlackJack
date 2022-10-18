%==========================================================================
% 
%  BME 60B, Fangyuan Ding, MWF 4:00 - 4:50pm
%  
%  Problem Set 1 (Blackjack)
%
%  Group 12:
%  Kentstar Samuel Harsono, 
%  Eric Hyun Kim, 
%  Tair Kuzhekov, 
%  Elian Martin Sian Lintag
%  
%  Last Update:
%  10/18/2022
% 
%==========================================================================

% inital clear
clear all
clc

input(newline+ "Welcome to Blackjack! press enter to continue :o")

% initialize new deck using cardDeck class
deck = cardDeck;

% calls shuffle function and shuffles the deck
[deck.d, deck.suits] = deck.shuffle();

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
    fprintf('\nok... You chose: %d real player(s)\n', realPlayer)
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

pause(0.5)
disp(newline + "dealing first hand...")

% hands out all players 2 cards to start game
for i = 1:playerNumber
    eval(['[player' num2str(i) '.playerHand, player' num2str(i) ...
        '.playerCard, deck.d, deck.suits] = player' num2str(i) '.init(deck);']);
end

pause(0.5)

% display starting hands
disp(newline + "Starting Hands:" + newline)
for i = 1:playerNumber
    eval( ['fprintf([''player' num2str(i) ': '' repmat(''%s, '', 1, length(player' num2str(i) '.playerCard)-1) ''%s\n''], player' num2str(i) '.playerCard)'])

    % if am to be 100% honest, the line above is way too complicated but 
    % idk how else to do this? it's evaluating a fprintf statement for each
    % player that creates a matrix matching the amount of card strings in 
    % their hand (elian)

end

input(newline + "Press enter to start game.");

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
            
            % displays score and current hand
            fprintf('\n------------------------------------\nCurrent Player: Player%d - Score: %d\n',i,eval(['player' num2str(i) '.playerValue;']));
            eval( ['fprintf([''Current Hand: '' repmat(''%s, '', 1, length(player' num2str(i) '.playerCard)-1) ''%s\n''], player' num2str(i) '.playerCard)'])
            
            % Determines player process
            if eval(['~player' num2str(i) '.dealer'])

                while true
                    % take a player decision
                    decision = input("Hit or Stand (H/S)? ","s");

                    % decision to hit
                    if lower(decision) == 'h'
                        eval(['[deck.d,deck.suits,name,value] = player' num2str(i) '.Hit(deck);'])
                        fprintf('\nYou hit a %s. You new score is: %d\n', name, eval(['player' num2str(i) '.playerValue;']))
                        break
                    % Decision to stand
                    elseif lower(decision) == 's'
                        eval(['player' num2str(i) '.canPlay = false;'])
                        fprintf('\nYou decided to stand. Your final hand is worth: %d\n', eval(['player' num2str(i) '.playerValue;']))
                        break

                    %error on invalid input
                    else
                        disp(newline + "Invalid input." + newline)
                    end
                end

                % if a player gets a blackjack, their turn is done
                if eval(['player' num2str(i) '.playerValue==21'])
                    eval(['player' num2str(i) '.canPlay = false;'])
                    disp(newline + "nice. its blackjackin' time" + newline)
                end

                % player bust OR ace save
                if eval(['player' num2str(i) '.playerValue>21'])
                    if eval(['player' num2str(i) '.aceSaves > 0'])
                        eval(['player' num2str(i) '.playerHand = player' num2str(i) '.Ace();'])
                        fprintf('\nyour ace turns from an 11 to a 1, saving you. New Score: %d\n', eval(['player' num2str(i) '.playerValue']))
                    else
                        eval(['player' num2str(i) '.canPlay = false;'])
                        disp(newline + "oops lol u went bust" + newline)
                    end
                end
                
            % Determines bot moves
            else
                input("Press enter to make bot move.");
                
                % if the bot has a hand below 17, it will hit
                if eval(['player' num2str(i) '.playerValue<=16'])
                    eval(['[deck.d, deck.suits, name, value] = player' num2str(i) '.Hit(deck);'])
                    fprintf('\nBot had decided to hit and got a %s. New score: %d\n', name, eval(['player' num2str(i) '.playerValue;']))

                    % bot bust OR ace save
                    if eval(['player' num2str(i) '.playerValue>21'])
                        if eval(['player' num2str(i) '.aceSaves > 0'])
                            eval(['player' num2str(i) '.playerHand = player' num2str(i) '.Ace();'])
                            fprintf('\nbot got an ace save. lucky, new score: %d\n', eval(['player' num2str(i) '.playerValue']));
                        else
                            eval(['player' num2str(i) '.canPlay = false;'])
                            disp(newline + "bot went bustie :o" + newline)
                        end
                    end
                        % if a player gets a blackjack, their turn is done
                    if eval(['player' num2str(i) '.playerValue==21'])
                        eval(['player' num2str(i) '.canPlay = false;'])
                        disp(newline + "bot got a blackjack.." + newline)
                    end
                else % if not, they will stand (or they went bust)
                    eval(['player' num2str(i) '.canPlay = false;'])
                    disp(newline + "Bot has decided to stand." + newline)
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

% if there is a winner, then announce them. if everyone bust, say no one.
if winnerValue ~= 0
    winnerText = ['\nGame Complete! Winners:\n' repmat('Player%d ', 1, length(winners)) '\n'];
    fprintf(winnerText, winners);
    fprintf('...with a score of: %d!\n', winnerValue);
else
    disp(newline + "Game Complete! No one won lol...")
end

