%=========================================================================
% 
%  BME 60B, Fangyuan Ding, MWF 4:00 - 4:50pm
%  
%  Group 12:
%  [NAMES GO HERE]
%  
%  Last Update:
%  [DATE]
% 
%=========================================================================

%% todo
% 1. function to initalize all player hands
% 2. 
% 3. differentiate ace (logic for +11 >21)
% 4. create function to deal inital cards
%%

%% long time todo
% 1. differentiate face cards
% 2. differentiate suits
%%

% inital clear
clear all
clc

% define face cards
ace = 11;
jack = 10;
queen = 10;
king = 10;

% create "deck" as array with 52 elements
deck = [ace,ace,ace,ace,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6  ... 
        7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,jack,jack,jack,jack, ...
        queen,queen,queen,queen,king,king,king,king];

% shuffles the deck
deck = shuffle(deck);

player1 = [];

% % find player count and init player hands
% function playerHands = initGame(playerCount)
%     for i = 1:playerCount
%         player(:,:,i) = [];
%     end
%     playerHands = player();
% end



