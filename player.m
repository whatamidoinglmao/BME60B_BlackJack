classdef player < handle
    properties % Assigns respective player elements
        playerHand
        playerCard
        dealer
        canPlay
        aceSaves
    end

    properties (Dependent)
        playerValue
    end

    methods
        function obj = player(dealerStat) %Initializes player

                obj.playerHand = [0,0];
                obj.playerCard = strings([1,2]);
                obj.dealer = dealerStat;
                obj.canPlay = true;
                obj.aceSaves = 0;

        end

        % sums the player hand to get their score
        function value = get.playerValue(obj)
            value = sum(obj.playerHand);
        end
            

        % initialize player hands
        function [startHand, startHandNames, newDeck, newSuits] = init(obj, Deck)
            for i = 1:2
                [pick, value, Deck.d, Deck.suits] = Deck.pickCard();
                obj.playerHand(i) = value;
                obj.playerCard(i) = pick;

                % if they draw an ace, they get an ace save
                if value == 11
                    obj.aceSaves = obj.aceSaves +1;
                end
            end
            startHand = obj.playerHand;
            startHandNames = obj.playerCard;
            newDeck = Deck.d;
            newSuits = Deck.suits;
        end

        function [newDeck, newSuits, name, value] = Hit(obj,Deck) % Adds card to hand
            [pick, number, Deck.d, Deck.suits] = Deck.pickCard();
            name = pick;
            value = number;

            if value == 11
                obj.aceSaves = obj.aceSaves + 1;
            end

            obj.playerHand(end+1) = number;
            obj.playerCard(end+1) = pick;
            newDeck = Deck.d;
            newSuits = Deck.suits;
        end

        function newHand = Ace(obj) % function to change an ace 11 to a 1
            obj.aceSaves = obj.aceSaves - 1;
            for i = 1:obj.playerHand % Uses a loop to check for 11
                if obj.playerHand(i) == 11
                    obj.playerHand(i) = 1;
                    break
                end
            end
            newHand = obj.playerHand;
        end
    end
end