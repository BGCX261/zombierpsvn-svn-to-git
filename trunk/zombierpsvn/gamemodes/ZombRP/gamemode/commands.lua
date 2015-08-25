
function ccSWEPSpawn( ply, cmd, args )

	if( CfgVars["adminsweps"] == 1 ) then
	
		if( not Admins[ply:SteamID()] and not ply:IsAdmin() and not ply:IsSuperAdmin() ) then
			Notify( ply, 1, 2, "Admin-Only!" );
			return;
		end
	
	end
	
	CCSpawnSWEP( ply, cmd, args );

end
concommand.Add( "gm_giveswep", ccSWEPSpawn );

function ccSENTSPawn( ply, cmd, args )

	if( CfgVars["adminsents"] == 1 ) then
	
		if( not Admins[ply:SteamID()] and not ply:IsAdmin() and not ply:IsSuperAdmin() ) then
			Notify( ply, 1, 2, "Admin-Only!" );
			return;
		end
	
	end

	CCSpawnSENT( ply, cmd, args );

end
concommand.Add( "gm_spawnsent", ccSENTSPawn )