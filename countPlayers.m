playerNumber = input("how many players? ");

player_index = createPlayers(playerNumber);

for j = 1:playerNumber
    eval(['player' num2str(j) '= player_index(' ...
            num2str(j) ',:);'])
end

clear j

function players = createPlayers(amount)
    for i = 1:amount
        a = (1:amount)';
        matrix = zeros(1,2);
        players = a * matrix;
    end
end


