
AddCSLuaFile("cl_init.lua")

include("server/sv_round.lua")
include("shared.lua")


function GM:PlayerSpawn( ply )

	sayHi( ply )

	beginRound()

end
