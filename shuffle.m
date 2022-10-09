%%function to shuffle deck
function shuffledDeck = shuffle(cardDeck)
    shuffle = randperm(52);
    shuffledDeck = cardDeck(shuffle);
    clear shuffle
end
