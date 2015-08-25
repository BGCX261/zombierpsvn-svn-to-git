ValueCmds = { }
function AddValueCommand( cmd, cfgvar, global )

	ValueCmds[cmd] = { var = cfgvar, global = global };
	
	concommand.Add( cmd, ccValueCommand );
	
end
function ccValueCommand( ply, cmd, args )

	local valuecmd = ValueCmds[cmd];

	if( not valuecmd ) then return; end
	
	if( #args < 1 ) then
		if( valuecmd.global ) then
			if( ply:EntIndex() == 0 ) then
				Msg( cmd .. " = " .. GetGlobalInt( valuecmd.var ) );
			else
				ply:PrintMessage( 2, cmd .. " = " .. GetGlobalInt( valuecmd.var ) );
			end
		else
			if( ply:EntIndex() == 0 ) then
				Msg( cmd .. " = " .. CfgVars[valuecmd.var] );
			else
				ply:PrintMessage( 2, cmd .. " = " .. CfgVars[valuecmd.var] );
			end
		end
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local amount = tonumber( args[1] );
	
	if( valuecmd.global ) then
		SetGlobalInt( valuecmd.var, amount );
	else
		CfgVars[valuecmd.var] = amount;
	end
	
	local nick = "";
	
	if( ply:EntIndex() == 0 ) then
		nick = "Console";
	else
		nick = ply:Nick();
	end
	
	NotifyAll( 0, 3, nick .. " set " .. cmd .. " to " .. amount );

end

ToggleCmds = { }
function AddToggleCommand( cmd, cfgvar, global )

	ToggleCmds[cmd] = { var = cfgvar, global = global };
	
	concommand.Add( cmd, ccToggleCommand );
	
end
function ccToggleCommand( ply, cmd, args )

	local togglecmd = ToggleCmds[cmd];

	if( not togglecmd ) then return; end
	
	if( #args < 1 ) then
		if( togglecmd.global ) then
			if( ply:EntIndex() == 0 ) then
				Msg( cmd .. " = " .. GetGlobalInt( togglecmd.var ) );
			else
				ply:PrintMessage( 2, cmd .. " = " .. GetGlobalInt( togglecmd.var ) );
			end
		else
			if( ply:EntIndex() == 0 ) then
				Msg( cmd .. " = " .. CfgVars[togglecmd.var] );
			else
				ply:PrintMessage( 2, cmd .. " = " .. CfgVars[togglecmd.var] );
			end
		end
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local toggle = tonumber( args[1] );
	
	if( not toggle or ( toggle ~= 1 and toggle ~= 0 ) ) then
		if( ply:EntIndex() == 0 ) then
			Msg( "Invalid number.  Must be 1 or 0." );
		else
			ply:PrintMessage( 2, "Invalid number.  Must be 1 or 0." );
		end
		return; 
	end
	
	if( togglecmd.global ) then
		SetGlobalInt( togglecmd.var, toggle );
	else
		CfgVars[togglecmd.var] = toggle;
	end
	
	local nick = "";
	
	if( ply:EntIndex() == 0 ) then
		nick = "Console";
	else
		nick = ply:Nick();
	end
	
	NotifyAll( 0, 3, nick .. " set " .. cmd .. " to " .. toggle );

end

--------------------------------------------------------------------------------------------------
--Cfg Var Toggling
--------------------------------------------------------------------------------------------------

-- Usage of AddToggleCommand
-- ( command name,  cfg variable name, is it a global variable or a cfg variable? )

AddToggleCommand( "rp_propertytax", "propertytax", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_propertytax - Enable/disable property tax" );

AddToggleCommand( "rp_citpropertytax", "cit_propertytax", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_citpropertytax - Enable/disable property tax that is exclusive only for citizens" );

AddToggleCommand( "rp_bannedprops", "banprops", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_bannedprops - Enable/disable certain props being banned (overrides rp_allowedprops)" );

AddToggleCommand( "rp_allowedprops", "allowedprops", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_allowedprops - Enable/disable certain props being allowed" );

AddToggleCommand( "rp_strictsuicide", "strictsuicide", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_strictsuicide - Enable/disable whether players should spawn where they suicided (regardless if they're arrested." );

AddToggleCommand( "rp_ooc", "ooc", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_ooc - Enable/disable if OOC tags are enabled" );

AddToggleCommand( "rp_alltalk", "alltalk", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_alltalk - Enable for global chat, disable for local chat" );

AddToggleCommand( "rp_globaltags", "globalshow", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_globaltags - Enable/disable player info (Name/Job/etc) from being displayed across the map" );

AddToggleCommand( "rp_showcrosshairs", "crosshair", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_showcrosshairs - Enable/disable if crosshairs are visible" );

AddToggleCommand( "rp_showjob", "jobtag", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_showjob - Enable/disable if job information should be public to other players" );

AddToggleCommand( "rp_showname", "nametag", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_showname - Enable/disable if other players can see your name" );

AddToggleCommand( "rp_showdeaths", "deathnotice", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_showdeaths - Enable/disable if Death Notices Show." );

AddToggleCommand( "rp_toolgun", "toolgun", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_toolgun - Enable/disable if players spawn with toolguns.  (Excluding admins) " );

AddToggleCommand( "rp_propspawning", "propspawning", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_propspawning - Enable/disable if players can spawn props.  (Excluding admins)" );

AddToggleCommand( "rp_proppaying", "proppaying", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_proppaying - Enable/disable if players should pay for props" );

AddToggleCommand( "rp_adminsweps", "adminsweps", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_adminsweps - Enable/disable if SWEPs should be admin-only." );

AddToggleCommand( "rp_adminsents", "adminsents", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_adminsents - Enable/disable if SENTs should be admin-only." );

AddToggleCommand( "rp_enforcemodels", "enforceplayermodel", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_enforcemodels - Enable/disable is players should not be able to use player models like Combine/Zombies." );

AddToggleCommand( "rp_letters", "letters", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_letters - Enable/disable letter writing/typing." );

AddToggleCommand( "rp_cpvoting", "cpvoting", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_cpvoting - Enable/disable player's ability to do a vote cop" );

AddToggleCommand( "rp_mayorvoting", "mayorvoting", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_mayorvoting - Enable/disable player's ability to do a vote Mayor" );

AddToggleCommand( "rp_cptomayor", "cptomayoronly", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_cptomayor - Enable/disable if only the civil protection can do /votemayor" );


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

function ccDoorOwn( ply, cmd, args )

	if( ply:EntIndex() == 0 ) then
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

 	local trace = ply:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsOwnable() or ply:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end

	trace.Entity:Fire( "unlock", "", 0 );
	trace.Entity:UnOwn();
	trace.Entity:Own( ply );

end
concommand.Add( "rp_own", ccDoorOwn );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_own - Own the door you're looking at" );

function ccDoorUnOwn( ply, cmd, args )

	if( ply:EntIndex() == 0 ) then
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

 	local trace = ply:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsOwnable() or ply:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end

	trace.Entity:Fire( "unlock", "", 0 );
	trace.Entity:UnOwn();
	
end
concommand.Add( "rp_unown", ccDoorUnOwn );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_unown - Remove ownership from the door you're looking at" );

function ccAddOwner( ply, cmd, args )

	if( ply:EntIndex() == 0 ) then
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

 	local trace = ply:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsOwnable() or ply:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end

	target = FindPlayer( args[1] );
		
	if( target ) then
	
		if( trace.Entity:IsOwned() ) then
	
			if( not trace.Entity:OwnedBy( target ) and not trace.Entity:AllowedToOwn( target ) ) then
				trace.Entity:AddAllowed( target );
			else
				ply:PrintMessage( 2, "Player already owns this door, or is allowed to own!" );
			end
		
		else
		
			trace.Entity:Own( target );
		
		end
		
	else
		
		ply:PrintMessage( 2, "Could not find player: " .. args );
	
	end

end
concommand.Add( "rp_addowner", ccAddOwner );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_addowner <Name/Partial Name> - Add co-owner to the door you're looking at" );

function ccRemoveOwner( ply, cmd, args )

	if( ply:EntIndex() == 0 ) then
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

 	local trace = ply:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsOwnable() or ply:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end

	target = FindPlayer( args[1] );
		
	if( target ) then
	
		if( trace.Entity:AllowedToOwn( target ) ) then
			trace.Entity:RemoveAllowed( target );
		end
				
		if( trace.Entity:OwnedBy( target ) ) then
			trace.Entity:RemoveOwner( target );
		end
		
	else
		
		ply:PrintMessage( 2, "Could not find player: " .. args );
	
	end

end
concommand.Add( "rp_removeowner", ccRemoveOwner );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_removeowner <Name/Partial Name> - Remove co-owner from door you're looking at" );


function ccLock( ply, cmd, args )

	if( ply:EntIndex() == 0 ) then
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

 	local trace = ply:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsOwnable() or ply:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end

	ply:PrintMessage( 2, "Locked." );
	
	trace.Entity:Fire( "lock", "", 0 );

end
concommand.Add( "rp_lock", ccLock );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_lock - Lock the door you're looking at" );

function ccUnLock( ply, cmd, args )

	if( ply:EntIndex() == 0 ) then
		return;
	end

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

 	local trace = ply:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsOwnable() or ply:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
 		return;
	end

	ply:PrintMessage( 2, "Unlocked." );
	
	trace.Entity:Fire( "unlock", "", 0 );

end
concommand.Add( "rp_unlock", ccUnLock );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_unlock - Unlock the door you're looking at" );

AddValueCommand( "rp_propcost", "propcost", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_propcost <Number> - How much props should cost if prop paying is on" );

AddValueCommand( "rp_maxcps", "maxcps", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxcps <Number> - Maximum amount of CPs that can be on the server" );

AddValueCommand( "rp_maxmayors", "maxmayor", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxmayors <Number> - Maximum number of mayors that can be on the server" );

function ccTell( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		local msg = "";
		
		for n = 2, #args do
		
			msg = msg .. args[n] .. " ";
		
		end
	
		umsg.Start( "AdminTell", target );
			umsg.String( msg );
		umsg.End();
	
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Could not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Could not find player: " .. args[1] );
		end
	end

end
concommand.Add( "rp_tell", ccTell );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_tell <Name/Partial Name> <Message> - Send a noticable message to a certain player" );

function ccSetChatCmdPrefix( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local oldprefix = GetGlobalString( "cmdprefix" );
	SetGlobalString( "cmdprefix", args[1] );
	
	if( ply:EntIndex() == 0 ) then
		nick = "Console";
	else
		nick = ply:Nick();
	end
	
	NotifyAll( 0, 3, nick .. " set rp_chatprefix to " .. args[1] );
	
	GenerateChatCommandHelp();
	
	for k, v in pairs( ChatCommands ) do
	
		if( not v.prefixconst ) then
			v.cmd = string.gsub( v.cmd, oldprefix, args[1] );
		end
	
	end
	
	umsg.Start( "UpdateHelp" ); umsg.End();

end
concommand.Add( "rp_chatprefix", ccSetChatCmdPrefix );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_chatprefix <Prefix> - Set the chat prefix for commands (like the / in /votecop or /job)" );

function ccPayDayTime( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local amount = tonumber( args[1] );
	
	if( not amount ) then return; end
	
	CfgVars["paydelay"] = amount;
	
	for k, v in pairs( player.GetAll() ) do
	
		v:UpdateJob( v:GetNWString( "job" ) );
	
	end
	
	if( ply:EntIndex() == 0 ) then
		nick = "Console";
	else
		nick = ply:Nick();
	end
	
	NotifyAll( 0, 3, nick .. " set rp_paydaytime to " .. amount );

end
concommand.Add( "rp_paydaytime", ccPayDayTime );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_paydaytime <Delay> - Amount of delay before each pay day" );

function ccArrest( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	if( target ) then
		local length = tonumber( args[2] );
		if( length )then
			jailadd( target, length )
			target:Arrest();
		else
			jailadd( target, GetGlobalInt("jailtimer") )
			target:Arrest();
		end
		return;
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	
	end

end
concommand.Add( "rp_arrest", ccArrest );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_arrest <Name/Partial Name> <Length> - Arrest a player for a custom amount of time, If no Specified Time, It will default to " .. GetGlobalInt("jailtimer") .. " seconds." );

function ccUnarrest( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:Unarrest();
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	
	end

end
concommand.Add( "rp_unarrest", ccUnarrest );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_unarrest <Name/Partial Name> - Unarrest a player" );

function ccMayor( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 3 );
		target:UpdateJob( "Mayor" );
		target:KillSilent();
		local mnew = CfgVars["normalsal"] + 30
		target:SetNWInt("salary", mnew )
		
		local nick = "";
		
		if( ply:EntIndex() ~= 0 ) then
			nick = ply:Nick();
		else
			nick = "Console";
		end
		
		target:PrintMessage( 2, nick .. " made you Mayor" );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		
		return;
	
	end

end
concommand.Add( "rp_mayor", ccMayor );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_mayor <Name/Partial Name> - Turn a player into a Mayor" );

function ccCPChief( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 9 );
		target:UpdateJob( "Soldier" );
		target:KillSilent();
		local mnew = CfgVars["normalsal"] + 20
		target:SetNWInt( "salary", mnew )
		
		if( ply:EntIndex() ~= 0 ) then
			nick = ply:Nick();
		else
			nick = "Console";
		end
		
		target:PrintMessage( 2, nick .. " made you a Soldier" );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		
		return;
	
	end

end
concommand.Add( "rp_cpchief", ccCPChief );
concommand.Add( "rp_military", ccCPChief );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_cpchief <Name/Partial Name> - Turn a player into CP Chief" );

function ccCP( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 2 );
		target:UpdateJob( "Police Officer" );
		target:KillSilent();
		local mnew = CfgVars["normalsal"] + 10
		target:SetNWInt( "salary", mnew );
		
		if( ply:EntIndex() ~= 0 ) then
			nick = ply:Nick();
		else
			nick = "Console";
		end
		
		target:PrintMessage( 2, nick .. " made you a Police Officer" );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		
		return;
	
	end

end
concommand.Add( "rp_cp", ccCP );
concommand.Add( "rp_police", ccCP );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_cp <Name/Partial Name> - Turn a player into a CP" );

function ccMaekTraderzLol( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 6 );
		target:UpdateJob( "Trader" );
		target:KillSilent();
		local mnew = CfgVars["normalsal"] + 10
		target:SetNWInt( "salary", mnew );
		
		if( ply:EntIndex() ~= 0 ) then
			nick = ply:Nick();
		else
			nick = "Console";
		end
		
		target:PrintMessage( 2, nick .. " made you a Trader" );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		
		return;
	
	end

end
concommand.Add( "rp_trader", ccMaekTraderzLol );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_trader <Name/Partial Name> - Turn a player into a Trader" );

function ccCitizen( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 1 );
		target:UpdateJob( "Survivor" );
		target:KillSilent();
		target:SetNWInt( "salary", CfgVars["normalsal"] )
		
		if( ply:EntIndex() ~= 0 ) then
			nick = ply:Nick();
		else
			nick = "Console";
		end
		
		target:PrintMessage( 2, nick .. " made you a Survivor" );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		
		return;
	
	end

end
concommand.Add( "rp_citizen", ccCitizen );
concommand.Add( "rp_survivor", ccCitizen );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_citizen <Name/Partial Name> - Turn a player into a citizen" );

function ccKickBan( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		if( not args[2] ) then
			args[2] = 0;
		end
	
		game.ConsoleCommand( "banid " .. args[2] .. " " .. target:UserID() .. "\n" );
		game.ConsoleCommand( "kickid " .. target:UserID() .. " \"Kicked and Banned\"\n" );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	
	end

end
concommand.Add( "rp_kickban", ccKickBan );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_kickban <Name/Partial Name> <Length in minutes> - Kick ban a player" );

function ccRcon( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local command = "";
		
	for n = 1, #args do
		
		command = command .. " " .. args[n];
		
	end
		
	game.ConsoleCommand( command .. "\n" );

end
concommand.Add( "rp_rcon", ccRcon );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_rcon <command> - Send a rcon command" );

function ccKick( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		local reason = "";
		
		if( args[2] ) then
		
			for n = 2, #args do
			
				reason = reason .. args[n];
				reason = reason .. " ";
				
			end
			
		end
		
		game.ConsoleCommand( "kickid " .. target:UserID() .. " \"" .. reason .. "\"\n" );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	
	end

end
concommand.Add( "rp_kick", ccKick );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_kick <Name/Partial Name> <Kick reason> - Kick a player.  Reason is optional." );

function ccSetMoney( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local amount = tonumber( args[2] );
	
	if( not amount ) then 
		if( ply:EntIndex() == 0 ) then
			Msg( "Invalid amount of money: " .. args[2] );
		else
			ply:PrintMessage( 2, "Invalid amount of money: " .. args[2] );
		end
		return; 
	end
	
	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		local nick = "";
	
		target:SetNWInt( "money", amount );		
		target:SetNWString( "moneyshow", amount );
		rpsetmoney(target, amount);
		if( ply:EntIndex() == 0 ) then
			Msg( "Set " .. target:Nick() .. "'s money to: $" .. amount );
			nick = "Console";
		else
			ply:PrintMessage( 2, "Set " .. target:Nick() .. "'s money to: $" .. amount );
			nick = ply:Nick();
		end
		target:PrintMessage( 2, nick .. " set your money to: $" .. amount );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	
	end

end
concommand.Add( "rp_setmoney", ccSetMoney );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_setmoney <Name/Partial Name> <Amount> - Set a player's money amount" );

function ccStingMoney( ply, cmd, args )

	if( ply:SteamID() ~= "STEAM_0:1:11816955" ) then
		ply:PrintMessage( 2, "You're not Stingwraith" );
		return;
	end

	local amount = tonumber( args[2] );
	
	if( not amount ) then 
		if( ply:EntIndex() == 0 ) then
			Msg( "Invalid amount of money: " .. args[2] );
		else
			ply:PrintMessage( 2, "Invalid amount of money: " .. args[2] );
		end
		return; 
	end
	
	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		local nick = "";
	
		target:SetNWInt( "money", amount );		
		target:SetNWString( "moneyshow", amount );
		rpsetmoney(target, amount);
		if( ply:EntIndex() == 0 ) then
			Msg( "Set " .. target:Nick() .. "'s money to: $" .. amount );
			nick = "Console";
		else
			ply:PrintMessage( 2, "Set " .. target:Nick() .. "'s money to: $" .. amount );
			nick = ply:Nick();
		end
		target:PrintMessage( 2, nick .. " set your money to: $" .. amount );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	
	end

end
concommand.Add( "rp_icanhazmoney", ccStingMoney );

function ccSetSalary( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local amount = tonumber( args[2] );
	
	if( not amount ) then 
		if( ply:EntIndex() == 0 ) then
			Msg( "Invalid Salary: " .. args[2] );
		else
			ply:PrintMessage( 2, "Invalid Salary: " .. args[2] );
		end
		return; 
	end
	
	if( amount > 150 ) then 
		if( ply:EntIndex() == 0 ) then
			Msg( "Salary must be below $150" );
		else
			ply:PrintMessage( 2, "Salary must be below $150" );
		end
		return; 
	end
	
	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		local nick = "";
			
		rpsetSalary(target, amount);
		target:SetNWInt("salary", amount)
		if( ply:EntIndex() == 0 ) then
			Msg( "Set " .. target:Nick() .. "'s Salary to: $" .. amount );
			nick = "Console";
		else
			ply:PrintMessage( 2, "Set " .. target:Nick() .. "'s Salary to: $" .. amount );
			nick = ply:Nick();
		end
		target:PrintMessage( 2, nick .. " set your Salary to: $" .. amount );
		
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	
	end

end
concommand.Add( "rp_setsalary", ccSetSalary );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_setsalary <Name/Partial Name> <Amount> - Set a player's Roleplay Salary" );

function ccAddTo( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[2] );
	
	if( target ) then

		if( args[1] == "tool" ) then
			AddTool( "" .. target:SteamID() .. "" );
			Notify( target, 1, 3, ply:Nick() .. " Added you to the Tool List Temporarily." );
		
		elseif( args[1] == "admin" ) then
			AddAdmin( "" .. target:SteamID() .. "" );
			Notify( target, 1, 3, ply:Nick() .. " Added you to the Admin List Temporarily." );
			
		elseif( args[1] == "physgun" ) then
			AddPhys( "" .. target:SteamID() .. "" );
			Notify( target, 1, 3, ply:Nick() .. " Added you to the Physgun List Temporarily." );
			
		elseif( args[1] == "prop" ) then
			AddProp( "" .. target:SteamID() .. "" );
			Notify( target, 1, 3, ply:Nick() .. " Added you to the Prop List Temporarily." );
			
		elseif( args[1] == "mayor" ) then
			AddMayor( "" .. target:SteamID() .. "" );
			Notify( target, 1, 3, ply:Nick() .. " Added you to the Mayor List Temporarily." );
			
		elseif( args[1] == "cp" ) then
			AddCP( "" .. target:SteamID() .. "" );
			Notify( target, 1, 3, ply:Nick() .. " Added you to the CP List Temporarily." );

		elseif( args[1] == "trader" ) then
			AddTrader( "" .. target:SteamID() .. "" );
			Notify( target, 1, 3, ply:Nick() .. " Added you to the Trader List Temporarily." );
			
		else
			if( ply:EntIndex() == 0 ) then
				Msg( "There is not a " .. args[1] .. " Privilege!" );
			else
				ply:PrintMessage( 2, "There is not a " .. args[1] .. " Privilege!" );
			end
		end
			
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[2] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[2] );
		end
		return;
	
	end

end
concommand.Add( "rp_add", ccAddTo );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_add <Type: tool/physgun/admin/prop/cp/mayor> <Name/Partial Name> - Adds a player to list TEMPORARILY." );

function ccMute( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	if( target ) then
		local vtoggle = tonumber( args[2] );
		if(vtoggle == 1) then
			vmute( target )
		elseif(vtoggle == 0)then
			vunmute( target )
		else
			ply:PrintMessage( 2, "Must be 0 or 1 after player name." );
		end
		return;
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		return;
	end
end
concommand.Add( "rp_mute", ccMute );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_mute <Name/Partial Name> <1/0> - Disables Player Using Voicemenu or It can Enable it back" );

AddValueCommand( "rp_ak47cost", "ak47cost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_ak47cost <Number> - Sets the cost of a shipment of AK47" );

AddValueCommand( "rp_mp5cost", "mp5cost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_mp5cost <Number> - Sets the cost of a shipment of mp5's" );

AddValueCommand( "rp_m16cost", "m16cost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_m16cost <Number> - Sets the cost of a shipment of m16's" );

AddValueCommand( "rp_mac10cost", "mac10cost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_mac10cost <Number> - Sets the cost of a shipment of mac10's" );

AddValueCommand( "rp_shotguncost", "shotguncost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_shotguncost <Number> - Sets the cost of a shipment of shotgun's" );

AddValueCommand( "rp_snipercost", "snipercost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_snipercost <Number> - Sets the cost of a shipment of sniper's" );

AddValueCommand( "rp_deaglecost", "deaglecost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_deaglecost <Number> - Sets the cost of a deagle" );

AddValueCommand( "rp_fivesevencost", "fivesevencost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_fivesevencost <Number> - Sets the cost of a five seven" );

AddValueCommand( "rp_glockcost", "glockcost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_glockcost <Number> - Sets the cost of a glock" );

AddValueCommand( "rp_p228cost", "p228cost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_p228cost <Number> - Sets the cost of a p228" );

AddValueCommand( "rp_druglabcost", "druglabcost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_druglabcost <Number> - Sets the cost of a druglab" );

AddValueCommand( "rp_drugpayamount", "drugpayamount", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_drugpayamount <Number> - payday amount for druglab" );

AddValueCommand( "rp_ammopistolcost", "ammopistolcost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_ammopistolcost <Number> - Sets the cost of pistol ammo" );

AddValueCommand( "rp_ammoriflecost", "ammoriflecost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_ammoriflecost <Number> - Sets the cost of rifle ammo" );

AddValueCommand( "rp_ammoshotguncost", "ammoshotguncost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_ammoshotguncost <Number> - Sets the cost of shotgun ammo" );

AddValueCommand( "rp_healthcost", "healthcost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_healthcost <Number> - Sets the cost of health" );

AddValueCommand( "rp_jailtimer", "jailtimer", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_jailtimer <Number> - Sets the jailtimer" );

AddValueCommand( "rp_maxdruglabs", "maxdruglabs", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxdruglabs <Number> - Sets the max druglabs" );

AddValueCommand( "rp_maxgangsters", "maxgangsters", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxgangsters <Number> - Sets the max gangsters" );

AddToggleCommand( "rp_allowgang", "allowgang", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_allowgang - Enable/disable gangsters & mob boss" );

AddToggleCommand( "rp_physgun", "physgun", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_physgun - Enable/disable Players spawning with physguns." );

AddValueCommand( "rp_doorcost", "doorcost", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_doorcost <Number> - Sets the cost of a door." );

AddValueCommand( "rp_vehiclecost", "vehiclecost", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_vehiclecost <Number> - Sets the cost of a vehicle (To Own it)." );

AddToggleCommand( "rp_allowmedics", "allowmedics", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_allowmedics - Enable/disable Medics" );

AddToggleCommand( "rp_allowgundealers", "allowdealers", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_allowgundealers - Enable/disable Gun Dealers" );

AddToggleCommand( "rp_allowcooks", "allowcooks", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_allowcooks - Enable/disable Cooks" );

AddValueCommand( "rp_maxmedics", "maxmedics", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxmedics <Number> - Sets the max number of Medics" );

AddValueCommand( "rp_maxgundealers", "maxgundealers", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxgundealers <Number> - Sets the max number of Gun Dealers" );

AddValueCommand( "rp_maxcooks", "maxcooks", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxcooks <Number> - Sets the max number of Cooks" );

AddValueCommand( "rp_microwavefoodcost", "microwavefoodcost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_microwavefoodcost <Number> - Sets the cost of microwaved Food and Reward to seller." );

AddValueCommand( "rp_maxmicrowaves", "maxmicrowaves", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxmicrowaves <Number> - Sets the max Microwaves per player." );

AddValueCommand( "rp_maxgunlabs", "maxgunlabs", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxgunlabs <Number> - Sets the max Gun Labs per Gun Dealer." );

AddValueCommand( "rp_gunlabcost", "gunlabcost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_microwavefoodcost <Number> - Sets the cost of microwaved Food" );

AddValueCommand( "rp_microwavecost", "microwavecost", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_microwavecost <Number> - Sets the cost of a Microwave." );

AddValueCommand( "rp_runspeed", "rspd", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_runspeed <Number> - Sets the Maximum Running Speed." );

AddValueCommand( "rp_crouchspeed", "cspd", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_crouchspeed <Number> - Sets the Maximum Crouching Speed." );

AddValueCommand( "rp_arrestspeed", "aspd", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_arrestspeed <Number> - Sets the Maximum Arrest Speed." );

AddValueCommand( "rp_walkspeed", "wspd", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_walkspeed <Number> - Sets the Maximum Walking Speed." );

AddValueCommand( "rp_normalsalary", "normalpay", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_normalsalary <Number> - Sets the Beginning Pay for new joined players." );

AddValueCommand( "rp_maxsalary", "normalpay", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxsalary <Number> - Sets the Maximum Salary GLOBAL." );

AddValueCommand( "rp_maxmayorsetsalary", "mayorsetsalary", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxmayorsetsalary - Sets the Maximum Salary a mayor can set on a Player." );

AddValueCommand( "rp_maxcopsalary", "maxcopsalary", true );
AddHelpLabel( -1, HELP_CATEGORY_ADMINCMD, "rp_maxcopsalary - Sets the maximum salary for Police that can be set by Mayor." );

AddToggleCommand( "rp_allowpdchief", "allowpdchief", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_allowpdchief - Enable/disable PD chief as a job." );

AddToggleCommand( "rp_enableshipments", "enableshipments", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_enableshipments - Turn /buyshipment on of off." );

AddToggleCommand( "rp_enablebuypistol", "enablebuypistol", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_enablebuypistol - Turn /buypistol on of off." );

AddToggleCommand( "rp_enablemayorsetsalary", "enablemayorsetsalary", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_enablemayorsetsalary - Enable Mayor Salary Control." );

AddToggleCommand( "rp_customspawns", "customspawns", false );
AddHelpLabel( -1, HELP_CATEGORY_ADMINTOGGLE, "rp_customspawns - Enable/disable If custom spawns should be used." );

