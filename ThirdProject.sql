-- Listado de jugadores que al menos han jugado una partida
SELECT DISTINCT player.id_player, player.playername FROM player
INNER JOIN playerturn ON player.id_player = playerturn.id_playerturn;

-- Listado de jugadores que no han jugado una partida
SELECT  player.id_player, player.playername FROM player
LEFT JOIN playerturn ON player.id_player = playerturn.id_playerturn
WHERE playerturn.id_playerturn IS NULL;

-- Listado de jugadores que al menos han ganado una partida
SELECT DISTINCT player.id_player, player.playername FROM player
INNER JOIN playerturn ON player.id_player = playerturn.id_playerturn
WHERE playerturn.winn = 1;
---IDK
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
SELECT COUNT(playerturn.id_playerturn) AS winn_hm, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE game_id_game = 002 AND playerturn.winn = 1
GROUP BY playerturn.id_player, player.playername
ORDER BY winn_hm DESC
FETCH NEXT 3 ROWS ONLY;

-- Top 3 de los mejores jugadores ttt
SELECT COUNT(playerturn.id_playerturn) AS winn_ttt, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE game_id_game = 001 AND playerturn.winn = 1
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
WHERE game_id_game = 002 AND playerturn.winn = 0
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
WHERE game_id_game = 001 AND playerturn.winn = 0
GROUP BY playerturn.id_player, player.playername
ORDER BY loose_ttt DESC
FETCH NEXT 3 ROWS ONLY;

-- Jugador de TTT con menos tiros para ganar
SELECT MIN(playerturn.opportunities) AS OP, player.playername
FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE game_id_game = 001 
GROUP BY player.id_player, player.playername
ORDER BY OP ASC
FETCH NEXT 1 ROWS ONLY;

-- Jugador de Hangman con menos intentos al ganar
SELECT MIN(playerturn.opportunities) AS OP, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE game_id_game = 002 
GROUP BY player.id_player, player.playername
ORDER BY OP ASC
FETCH NEXT 1 ROWS ONLY;

-- Jugador de TTT con más tiros para ganar
SELECT MAX(playerturn.opportunities) AS OP, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn
WHERE game_id_game = 001 
GROUP BY player.id_player, player.playername
ORDER BY OP DESC
FETCH NEXT 1 ROWS ONLY;

-- Jugador de Hangman con más intentos para ganarend
SELECT MAX(playerturn.opportunities) AS OP, player.playername FROM player
INNER JOIN playerturn
ON player.id_player = playerturn.id_player
INNER JOIN turn
ON turn.id_turn = playerturn.turn_id_turn 
WHERE game_id_game = 002 
GROUP BY player.id_player, player.playername
ORDER BY OP DESC
FETCH NEXT 1 ROWS ONLY;

-- Promedio de tiros en TTT para ganar una partida ( partidas empatadas y en progreso no cuentan)
SELECT AVG(playerturn.opportunities) AS "Average Of Opportunities" FROM turn
INNER JOIN playerturn
ON turn.id_turn = playerturn.turn_id_turn
WHERE game_id_game = 001 AND end = 1;

-- Promedio del tamaño de palabras utilizadas en Hangman
SELECT AVG(COUNT(*)) AS "Average of words"
FROM secretword
GROUP BY id_hangedman;