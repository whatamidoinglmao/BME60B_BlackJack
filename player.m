classdef player < handle
    properties % Assigns respective player elements
        playerHand
        playerCard
        dealer
        canPlay
    end

    properties (Dependent)
        playerValue
    end

    methods
        function obj = player(dealerStat) %Initializes player

                obj.playerHand = [0,0];
                obj.playerCard = strings([1,2]);
                obj.canPlay = true;
                obj.dealer = dealerStat;

        end

        % sums the player hand to get their score
        function value = get.playerValue(obj)
            value = sum(obj.playerHand);
        end

        % initialize player hands
        function [startHand, startHandNames, newDeck] = init(obj, Deck)
            for i = 1:2
                [pick, value, Deck.d] = Deck.pickCard();
                obj.playerHand(i) = value;
                obj.playerCard(i) = pick;
            end
            startHand = obj.playerHand;
            startHandNames = obj.playerCard;
            newDeck = Deck.d;
        end

        function newDeck = Hit(obj,Deck) % Adds card to hand
            [pick, value, Deck.d] = Deck.pickCard();
            obj.playerHand(end+1) = value;
            obj.playerCard(end+1) = pick;
            newDeck = Deck.d;
        end

        function aceTrue = Ace(obj) %Boolean for Ace
            for i = obj.playerHand % Uses a loop to check for 11
                if obj.playerHand(i) == 11
                    aceTrue = true;
                    obj.playerHand(i) = 1;
                    break
                else % If no 11 found in loop, no ace
                    aceTrue = false; 
                end
            end
             
        end
    end
end