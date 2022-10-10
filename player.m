classdef player
    properties % Assigns respective player elements
        playerHand;
        playerValue;
        playerCard;
    end
    methods
        function obj = player(hand,card) %Initializes player
            if nargin == 2 % If there are 2 arguments in the function
                obj.playerHand = hand;
                obj.playerValue = sum(obj.playerHand);
                obj.playerCard = card;
            else % Creates an empty player
                obj.playerHand = [];
                obj.playerValue = sum(obj.playerHand);
                obj.playerCard = 0;
            end
        end

        function takeCard = Hit(obj) % Adds card to hand
            takeCard = obj.playerCard;
            obj.playerHand(end+1) = takeCard;
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
    end
end