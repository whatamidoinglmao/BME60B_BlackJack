% asks to print number of blackjack players
playerNumber = input("how many players? ");

% calls function createPlayers with input playerNumber
player_index = createPlayers(playerNumber); 

% creates for loop with playerNumber amount of cycles
for j = 1:playerNumber

    % outputs player1 = [0,0] player2 = [0,0] and so on
    eval(['player' num2str(j) '= player_index(' ...
            num2str(j) ',:);'])

    eval(['player' num2str(j) '= player();']);

end

clear j

% function with amount input and players output
function players = createPlayers(amount)
    % for loop with amount input cycles
    for i = 1:amount

        % creates 'a' array with number of columns = amount value
        a = (1:amount)';

        % zero matrix
        matrix = zeros(1,2);

        % property of arrays multiplication: amount x 1 * 1x2 = amount x 2
        players = a * matrix;
    end
end




