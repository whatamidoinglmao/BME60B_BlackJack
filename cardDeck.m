% cardDeck
%   This class is able to create and manage a deck and the cards within.

classdef cardDeck
    % To create a new deck, call:
    % [DECKNAME] = cardDeck();
    
    properties
        d                   % this stands for "deck"
        cards               % this stores all the card types
    end
    
    methods

        % initialize the deck class object with a deck
        function obj = cardDeck()
            
            % makes the array out of strings, so we can differentiate face
            % cards
            obj.cards = ["ace", "1", "2", "3", "4", "5", "6", "7", ...
                     "8", "9", "10", "jack", "queen", "king"];

            obj.d = strings();

            % creates a deck with 4 copies of each card
            for i = 1:length(obj.cards)
                start = i + (3*(i-1));
                obj.d(start:(start+3)) = repmat(obj.cards(i), 1, 4);
            end

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
            
            % error message, can delete later
            else
                disp("Error: Could not read card");
            end

        end


        % takes the deck property and outputs a shuffled one
        function shuffledDeck = shuffle(obj)

            shuffleIndex = randperm(length(obj.d));
            shuffledDeck = obj.d(shuffleIndex);
            clear shuffle

            % to call and shuffle a deck, use:
            % obj.d = obj.shuffle();

        end
        
        % picks the top card, outputs it, and removes it from the deck
        function [pickedCardName, pickedCardValue, newDeck] = pickCard(obj)
            if obj.d == "1"
                obj.d = "ace";
            else
                pickedCardName = obj.d(1);
            end
            
            pickedCardValue = obj.evalCard(pickedCardName);
            obj.d(1) = [];
            newDeck = obj.d;

            % to call, use:
            % [name, value, obj.d] = obj.pickCard();
            % the variable [NAME] will store the name of the card
            % the variable [VALUE] will store the value of the card

        end


    end

    % prob wont need this DELETE LATER (it's not even working...)
    methods (Static)
        function resetDeck = reset()
            cards = ["ace", "1", "2", "3", "4", "5", "6", "7", ...
                     "8", "9", "10", "jack", "queen", "king"];

            resetDeck = strings();

            for i = 1:length(cards)
                start = i + (3*(i-1));
                resetDeck(start:(start+3)) = repmat(cards(i), 1, 4);
            end

            % to reset deck:
            % obj.d = reset();
        end
    end
    % can delete this whole chunk later

end

