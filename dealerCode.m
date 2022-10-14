

dealer = []; %introducing dealer as variable
[dealer, deck.d] = initHands(dealer, deck); % function call and dealer takes two random cards from deck

cycle_num = 0;

while sum(dealer) <=21
    cycle_num = cycle_num + 1; % count number of cycles of loop

    if sum(dealer) < 18 % additional condition
        dealer(end+1) = deck.pickCard(); % add a new card 
    elseif (sum(dealer) > 20) && (sum(dealer) <=21)
        dealer = dealer; % do not take cards and pass

    else
        break %% jump out of loops!
    end
    
end

%{
while sum(dealer) <= 21
    if  sum(dealer) > 21 % if sum of cards is bigger than 21
        dealer = []; % loose all cards
        disp("Sorry, you lost!")

    elseif (sum(dealer) > 20) && (sum(dealer) <=21)
        dealer = dealer; % do not take cards and pass
    else
        dealer(end+1) = deck.pickCard(); % otherwise, add a new card
    end
end
%}

function [startingHand, newDeck] = initHands(emptyHand, deck)
    % adds one card from the deck to the emptyhand
    [pickedCard, deck.d] = deck.pickCard();
    emptyHand(end+1) = pickedCard;

    % adds the second card from the deck to the emptyhand
    [pickedCard, deck.d] = deck.pickCard();
    emptyHand(end+1) = pickedCard;
    
    startingHand = emptyHand;
    newDeck = deck.d;
end
