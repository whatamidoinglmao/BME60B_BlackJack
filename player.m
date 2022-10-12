classdef player < handle
    properties % Assigns respective player elements
        playerHand;
        playerValue;
        playerCard;
        playerTurn;
    end
    methods
        function obj = player(hand,card) %Initializes player
            if nargin == 2 % If there are 2 arguments in the function
                obj.playerHand = hand;
                obj.playerValue = sum(obj.playerHand);
                obj.playerCard = card;
                obj.playerTurn = false
            else % Creates an empty player
                obj.playerHand = [];
                obj.playerValue = sum(obj.playerHand);
                obj.playerCard = 0;
                obj.playerTurn = false
            end
        end

        function Hit(obj) % Adds card to hand
            obj.playerHand(end+1) = obj.playerCard;

        end

        function aceTrue = Ace(obj) %Boolean for Ace
            for i = obj.playerHand % Uses a loop to check for 11
                if i == 11
                    aceTrue = true;
                    i = 1;
                    break
                else % If no 11 found in loop, no ace
                    aceTrue = false; 
                end
            end
             
        end

        function Stand(obj)
            obj.playerTurn = false;
        end

        function Dealer(obj)
            while obj.playerTurn
                obj.Hit();
                if (obj.playerValue>=17)
                    obj.Stand()
                end
            end
        end

    end
end