clear
clc

playerNumber = input("how many players? ");


player_index = createPlayers(playerNumber);

for j = 1:size(player_index,1)
    eval(['player' num2str(j) '= player_index(' ...
            num2str(j) ',:);'])
end

clear j
clear player_index

function [players] = createPlayers(amount)
    for i = 1:amount
        a = (1:amount)';
        matrix = zeros(1,2);
        players = a * matrix;
    end
end


