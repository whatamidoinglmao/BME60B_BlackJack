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

playerNumber = input("how many players? ");

% initialize empty player array
playerList = player.empty();
for i = 1:playerNumber
    playerList(end+1) = player([]);
end

% initialize new deck using cardDeck class
deck = cardDeck;

% calls shuffle function and shuffles the deck
deck.d = shuffle(deck);

% initialize players hands
[playerList, deck.d] = initPlayersHands(playerList, deck);


% rough idea for giving inital cards
% for i = 1:playercount
%     player"i" = givePlayerCards(player"i", deck);
% end


% test players
% player1 = [];
% player2 = [];
% player3 = [];


% % find player count and init player hands
% function playerHands = initGame(playerCount)
%     for i = 1:playerCount
%         player(:,:,i) = [];
%     end
%     playerHands = player();
% end
% [player1, deck.d] = initHands(player1, deck);
% [player2, deck.d] = initHands(player2, deck);
% [player3, deck.d] = initHands(player3, deck);

function [newPlayerList, newDeck] = initPlayersHands(playerList, deck)
    for i = 1:length(playerList)
        [playerList(i).playerHand, deck.d] = initHands(playerList(i).playerHand, deck);
    end

    newPlayerList = playerList;
    newDeck = deck;
end

function [startingHand, newDeck] = initHands(emptyHand, deck)
    % adds one card from the deck to the emptyhand
    [pickedCard, deck.d] = deck.pickCard();
    emptyHand(end+1) = pickedCard; 

    % adds the second card from the deck to the emptyhand
    [pickedCard, deck.d] = deck.pickCard();
    emptyHand(end+1) = pickedCard;
    
    startingHand = emptyHand;
    newDeck = deck.d;
end