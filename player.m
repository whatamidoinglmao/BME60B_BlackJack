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

        function [newDeck, name, value] = Hit(obj,Deck) % Adds card to hand
            [pick, number, Deck.d] = Deck.pickCard();
            name = pick;
            value = number;
            obj.playerHand(end+1) = number;
            obj.playerCard(end+1) = pick;
            newDeck = Deck.d;
        end

        function Ace(obj) %Boolean for Ace
            i = 1;
            for i = 1:obj.playerHand % Uses a loop to check for 11
                if obj.playerHand(i) == str2double("11")
                    obj.playerHand(i) = str2double("1");
                    break
                end
            end
             
        end
    end
end