#PingPong#
### video [https://www.youtube.com/watch?v=pu8NEmZNNcw]###
###Final project by Edgar Rodrigo Perez Contreras###

============
i made my own simpole version of tha classic game Ping Pong

I distribude the code in 4 files: main.lua, ball.lua, player.lua and ai.lua


In the main. lua file I call the other files and  and I define the initial variables 
here I star with game_state = menu and depending on what happend I use a diferent game_state 
to do a diferent action in love.update and in love.draw

In ball.lua I create the ball, its functions, update and its logic (like what to check depending
in the game_state)

In player.lua I create the 2 Players, its functions and update

for the ai.lua is the same, just that instead of defining its movens by keys it go to the ball
using iss function acquire_target