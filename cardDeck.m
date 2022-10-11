% todo functions
% 1. pick a card and delete it from deck (done)
% 2. import shuffle method (done)
% 3. reset deck (done)
% 4. longterm, maybe make array strings to differentiate
% faces (suits matter less) !!

classdef cardDeck
    % d -> deck
    %   This class creates and manages the deck.
    
    properties
        d                   % this stands for "deck"
        cards
    end
    
    methods

        %% initialize the deck class object with a deck
        function obj = cardDeck()
            
            % makes the array out of strings, so we can differentiate
            % TODO: add logic to convert a string to a value

            obj.cards = ["ace", "1", "2", "3", "4", "5", "6", "7", ...
                     "8", "9", "10", "jack", "queen", "king"];

            obj.d = strings();

            % creates a deck with 4 copies of each card
            for i = 1:length(obj.cards)
                start = i + (3*(i-1));
                obj.d(start:(start+3)) = repmat(obj.cards(i), 1, 4);
            end

%             % define face cards
%             ace = 11;
%             jack = 10;
%             queen = 10;
%             king = 10;
%
%             % create "deck" as array with 52 elements
%             obj.d = [ace,ace,ace,ace,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6 ... 
%                     7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,jack,jack,jack,jack, ...
%                     queen,queen,queen,queen,king,king,king,king];
        end


        % takes the card name as input and spits out the value
        function value = evalCard(obj, name)
            
            nameLength = strlength(name);
            
            % numerical cards only have 1 or 2 characters
            if nameLength == 1 || nameLength == 2
                value = str2double(name);

            % if it's a jack, queen, or king, then set value to 10
            elseif name == obj.cards(end-2) || name == obj.cards(end-1) || ...
                                           name == obj.cards(end)
                value = 10;

            % if it's an ace, set it to 11 
            % TODO: add more ace logic, kent will handle this
            elseif name == obj.cards(1)
                value = 11;
            
            %error message, can delete later
            else
                disp("Error: Could not read card");
            end

        end


        %% takes the deck property and outputs a shuffled one
        function shuffledDeck = shuffle(obj)

            shuffleIndex = randperm(length(obj.d));
            shuffledDeck = obj.d(shuffleIndex);
            clear shuffle

            % to rewrite the cardDeck property in a deck class, use:
            % obj.d = shuffle(obj);

        end
        
        % picks the top card, outputs it, and removes it from the deck
        function [pickedCardName, pickedCardValue, newDeck] = pickCard(obj)

            pickedCardName = obj.d(1);
            pickedCardValue = obj.evalCard(pickedCardName);
            obj.d(1) = [];
            newDeck = obj.d;

            % to rewrite, use:
            % [pick, obj.d] = pickCard(obj);
            % the variable pick will store the value of the top card

        end


    end
    %prob wont need this DELETE LATER
    methods (Static)
        function resetDeck = reset()
            ace = 11;
            jack = 10;
            queen = 10;
            king = 10;
            resetDeck = [ace,ace,ace,ace,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6 ... 
                        7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,jack,jack,jack,jack, ...
                        queen,queen,queen,queen,king,king,king,king];
            % to rewrite, use:
            % obj.d = reset()
        end
    end

end

