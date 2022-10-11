classdef cardDeck
    % d -> deck
    %   This class creates and manages the deck.
    
    properties
        d
    end
    
    methods

        % todo functions
        % 1. pick a card and delete it from deck (done)
        % 2. import shuffle method (done)
        % 3. reset deck (done)
        % 4. longterm, maybe make array strings to differentiate
        % faces (suits matter less) !!

        % initialize the deck class object with a deck
        function obj = cardDeck()
            
            % define face cards
            ace = 11;
            jack = 10;
            queen = 10;
            king = 10;

            % create "deck" as array with 52 elements
            obj.d = [ace,ace,ace,ace,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6 ... 
                    7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,jack,jack,jack,jack, ...
                    queen,queen,queen,queen,king,king,king,king];
        end

        % takes the deck property and outputs a shuffled one
        function shuffledDeck = shuffle(obj)

            shuffleIndex = randperm(length(obj.d));
            shuffledDeck = obj.d(shuffleIndex);
            clear shuffle

            % to rewrite the cardDeck property in a deck class, use:
            % obj.d = shuffle(obj);

        end
        
        % picks the top card, outputs it, and removes it from the deck
        function [pickedCard, newDeck] = pickCard(obj)

            pickedCard = obj.d(1);
            obj.d(1) = [];
            newDeck = obj.d;

            % to rewrite, use:
            % [pick, obj.d] = pickCard(obj);
            % the variable pick will store the value of the top card

        end

        %prob wont need this DELETE LATER
        function resetDeck = reset(obj)
            ace = 11;
            jack = 10;
            queen = 10;
            king = 10;
            resetDeck = [ace,ace,ace,ace,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6 ... 
                    7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,jack,jack,jack,jack, ...
                    queen,queen,queen,queen,king,king,king,king];
            % to rewrite, use:
            % obj.d = reset(obj)
        end



%         function obj = playerScore(inputArg1,inputArg2)
%             %ENGINE Construct an instance of this class
%             %   Detailed explanation goes here
%             obj.Property1 = inputArg1 + inputArg2;
%         end

    end
end

