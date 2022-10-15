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

            % Determines dealer process
            if eval(['~player' num2str(i) '.dealer'])
                input("PlayerTurn");
            % Determines player process
            else
                input("DealerTurn");
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
