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

% inital clear
clear
clc

% define face cards
ace = 11;
jack = 10;
queen = 10;
king = 10;

% create "deck" as array with 52 elements
deck = [ace,ace,ace,ace,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6 ... 
        7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,jack,jack,jack,jack, ...
        queen,queen,queen,queen,king,king,king,king];

% shuffles the deck
shuffle = randperm(52);

