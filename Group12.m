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
%           - ERIC
%%

%% long time todo
% 1. differentiate face cards
% 2. differentiate suits
%%


% inital clear
clear
clc

%gameState
Game = true;
turns = 1;
% initialize new deck using cardDeck class
deck = cardDeck;

% calls shuffle function and shuffles the deck
deck.d = deck.shuffle();

% initialize players
%countPlayers();

playerNumber = input("how many players? ");
realPlayer = input("how many real players? ");
winners = [];
winnerValue = 0;

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



input("press enter to start game");

% hands out all players 2 cards to start game
for i = 1:playerNumber
    eval(['[player' num2str(i) '.playerHand, player' num2str(i) ...
        '.playerCard, deck.d] = player' num2str(i) '.init(deck);']);
end

% begin hit/stand phase
while Game
    fprintf('Turn: %d\n',turns);

    % Cycle through each player
    for i=1:playerNumber
        % Determines if the player can play (no Busts or Stands)
        if eval(['player' num2str(i) '.canPlay'])

            fprintf("Score %d\n",eval(['player' num2str(i) '.playerValue;']));
            % Determines player process
            if eval(['~player' num2str(i) '.dealer'])
                decision = input("Player "+num2str(i)+": Hit or Stand?\n","s");
                % Decision to hit
                if decision == "Hit"
                    eval(['[deck.d] = player' num2str(i) '.Hit(deck);'])
                end
                % Decision to stand OR if the playerValue >=21
                if decision == "Stand" || eval(['player' num2str(i) '.playerValue>=21'])
                    eval(['player' num2str(i) '.canPlay = false'])
                end
                
            % Determines Dealer process
            else
                input("DealerTurn");
                if eval(['player' num2str(i) '.playerValue<=16'])
                    eval(['[deck.d] = player' num2str(i) '.Hit(deck);'])
                else
                    eval(['player' num2str(i) '.canPlay = false'])
                end
            end
        end
    end
    % Checking if all players can't play
    for i=1:playerNumber
        if eval(['player' num2str(i) '.canPlay'])
            break;
        end
        Game = false;
    end
    turns = turns + 1;
end

% Checking for Win Condition
for i = 1:playerNumber
    % Clearing hand to set playerHand to 0, if cards > 21
    if eval(['player' num2str(i) '.playerValue>21'])
        eval(['player' num2str(i) '.playerHand=[0,0];'])
    end
    % Updating for new high score
    if eval(['player' num2str(i) '.playerValue>winnerValue'])
        winners = [];
        eval(['winnerValue = player' num2str(i) '.playerValue;'])
        winners(end+1) = i;

    % In case there's a tie
    elseif eval(['player' num2str(i) '.playerValue>=winnerValue'])
        winners(end+1) = i;
    end
end
disp(winners)