%%=========================================================================
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

% initialize new deck using cardDeck class
deck = cardDeck;

% calls shuffle function and shuffles the deck
deck.d = shuffle(deck);


% rough idea for giving inital cards
% for i = 1:playercount
%     player"i" = givePlayerCards(player"i", deck);
% end


% test players
player1 = [];
player2 = [];
player3 = [];


% % find player count and init player hands
% function playerHands = initGame(playerCount)
%     for i = 1:playerCount
%         player(:,:,i) = [];
%     end
%     playerHands = player();
% end



