-- Listado de jugadores que al menos han jugado una partida
SELECT DISTINCT player.id_player, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_playerturn;

-- Listado de jugadores que no han jugado una partida
SELECT  player.id_player, player.playername FROM player
LEFT JOIN playerturn
ON player.id_player = playerturn.id_playerturn
WHERE playerturn.id_playerturn IS NULL;

-- Listado de jugadores que al menos han ganado una partida
SELECT DISTINCT player.id_player, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_playerturn
WHERE playerturn.winn = 1;

SELECT id_player, playername FROM player
WHERE win_points > 0;

-- Listado de Jugadores que no han perdido una partida
SELECT id_player, playername FROM player
WHERE loose_points = 0;

-- Top 3 de los peores jugadores (partidas perdidas)
SELECT id_player, playername, loose_points FROM player
ORDER BY loose_points DESC
FETCH NEXT 3 ROWS ONLY;

-- Top 3 de los mejores jugadores (partidas ganadas)
SELECT id_player, playername, win_points FROM player
ORDER BY win_points DESC
FETCH NEXT 3 ROWS ONLY;

-- Top 3 de los mejores jugadores hangman
SELECT COUNT(playerturn.id_playerturn) 
AS winn_hm, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE id_game = 002 AND playerturn.winn = 1
GROUP BY playerturn.id_player, player.playername
ORDER BY winn_hm DESC
FETCH NEXT 3 ROWS ONLY;

-- Top 3 de los mejores jugadores ttt
SELECT COUNT(playerturn.id_playerturn) 
AS winn_ttt, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE id_game = 001 AND playerturn.winn = 1
GROUP BY playerturn.id_player, player.playername
ORDER BY winn_ttt DESC
FETCH NEXT 3 ROWS ONLY;

-- Top 3 de los peores jugadores hangman
SELECT COUNT(playerturn.id_playerturn) 
AS loose_hm, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE id_game = 002 AND playerturn.winn = 0
GROUP BY playerturn.id_player, player.playername
ORDER BY loose_hm DESC
FETCH NEXT 3 ROWS ONLY;

-- Top 3 de los peores jugadores ttt
SELECT COUNT(playerturn.id_playerturn) 
AS loose_ttt, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE id_game = 001 AND playerturn.winn = 0
GROUP BY playerturn.id_player, player.playername
ORDER BY loose_ttt DESC
FETCH NEXT 3 ROWS ONLY;


