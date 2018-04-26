local deathAmt = 25 --Variable to adjust how many kills it takes to win the game.

function beginRound() --Called on serverside, tells the server to start the game / preround.

	timer.Create("beginRoundCheck", 5, 0, function() --Happens at the beginning of every round, checks if there are enough players.

		local players = player.GetCount()

		if players >= 1 then

			timer.Remove("beginRoundCheck")

			countdownRound() -- Starts the countdown.

			PrintMessage( HUD_PRINTTALK, "ERR" )

		else

			PrintMessage( HUD_PRINTTALK, "Get some players in here nerd. Ill wet myself." )
 
		end

	end)

end

function countdownRound()
	
	timeCountdown = 11

	timer.Create("TimerStart", 1, 10, function()

		local players = player.GetCount()

		if players <= 1 then --Essentially stops the server from playing the game without any players.
			beginRound()
			timer.Remove("TimerStart")
		end

		timeCountdown = timeCountdown - 1 --Countdown until the match begins.

		PrintMessage( HUD_PRINTTALK, timeCountdown .. " seconds left." )

		
		if timeCountdown == 0 then --When the timer reaches 0.
			
			timer.Remove("TimerStart")
			roundEndCheck()
			
		end
		
		
		end)

end



function roundEndCheck()
	
	local blueScore = team.GetScore( 0 )

	local redScore = team.GetScore( 1 )
	
			
			if blueScore == deathAmt then

				endRound( 0, 1 )

			end

			if redScore == deathAmt then
			
				endRound( 1, 0 ) --Ends the round with the red winning, and the blue losing.
			
			end


		
		
	end
end

function endRound(winningTeam, losingTeam) --Happens on round end / after 25 kills on the team that won. winningTeam = the team that won, losingTeam = team that lost. These are both numbers.

	for k, v in pairs(player.GetAll()) do --Enables God Mode after this function is called to get rid of excess frustration at end of matches.
			v:GodEnable()
		end
	
	timer.Create("endRound", 3, 1, function() --Timer created after the match is over.

		for k, v in pairs(team.GetPlayers(winningTeam)) do --Adds EXP to the winning team.
			v:AddEXP(500)
		end

		for k, v in pairs(team.GetPlayers(losingTeam)) --Adds EXP to the losing team.
			v:AddEXP(200)
		end

		for k, v in pairs(player.GetAll()) do --Happens to all players / clients connected on the server after the round is over / disables God Mode.
			v:GodDisable()
			v:KillSilent()
			v:Spawn()
		end
		
		game.CleanUpMap() --Cleans up the map incase certain things are missing.
		beginRound() --Calls the beginning of the round again so that the game can restart on it's own.
		timer.Remove("endRound") --Removes the timer.

	end)
	


end