
local teams = {}

teams[0] = {
name = "Blue Boy-os",
color = Color(0, 102, 255, 255)
weapons = "weapon_crowbar"
}

teams[1] = {
name = "Hot Sauce Red Boys",
color = Color(255, 26, 26, 255)
weapons = "weapon_crowbar"
}

	function ply:SetGamemodeTeam(arg)

		ply:SetTeam( arg )
		
		
		

	end