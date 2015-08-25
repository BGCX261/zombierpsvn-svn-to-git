--This file shouldn't be edited, if you make a mistake it will be fucked over forever.

local timeLeft = 10
local timeLeft2 = 10
local stormOn = false
local zombieOn = false
local maxZombie = 10

VoteCopOn = false;

function controlZombie()

timeLeft2 = timeLeft2 - 1
	
	if(timeLeft2 < 1) then
		if(zombieOn == true) then
			timeLeft2 = math.random( 300,500 )
			zombieOn = false
			timer.Stop("start2")
			zombieEnd()
		else
			timeLeft2 = math.random( 150,300 )
			zombieOn = true
			timer.Start("start2")
			loadZombies()
			zombieStart()
		end
	end

end

function zombieStart()
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			v:PrintMessage( HUD_PRINTCENTER, "**Alert. Quarantine Initiated. Find shelter.**" ) 
			v:PrintMessage( HUD_PRINTTALK, "Zombies Approaching." ) 
		end
	end  
end

function zombieEnd()
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			v:PrintMessage( HUD_PRINTCENTER, "**Quarantine Disengaged.**" ) 
			v:PrintMessage( HUD_PRINTTALK, "Zombies Leaving." ) 
		end
	end  
end

function stormStart()
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			v:PrintMessage( HUD_PRINTCENTER, "Warning Meteor Storm Approaching!" ) 
			v:PrintMessage( HUD_PRINTTALK, "Warning Meteor Storm Approaching!" ) 
		end
	end  
end

function stormEnd()
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			v:PrintMessage( HUD_PRINTCENTER, "Meteor Storm Passing." ) 
			v:PrintMessage( HUD_PRINTTALK, "Meteor Storm Passing." ) 
		end
	end  
end

function controlStorm()
timeLeft = timeLeft - 1
	
	if(timeLeft < 1) then
		if(stormOn == true) then
			timeLeft = math.random( 300,500)
			stormOn = false
			timer.Stop("start")
			stormEnd()
		else
			timeLeft = math.random( 60,90)
			stormOn = true
			timer.Start("start")
			stormStart()
		end
	end

end

function startShower()

timer.Adjust("start", math.random( .5,1.5), 0, startShower)  

	for k, v in pairs(player.GetAll()) do  
	
		if(math.random( 0, 2) == 0) then
			if(v:Alive()) then
				attackEnt(v)
			end
		end
	end  

end

function DrugPlayer(pl)
pl:ConCommand("pp_dof 1")  
pl:ConCommand("pp_dof_initlength 9")  
pl:ConCommand("pp_dof_spacing 8") 

local IDSteam = string.gsub(pl:SteamID(), ":", "")
timer.Create( IDSteam, 40, 1, UnDrugPlayer, pl)
end

function UnDrugPlayer(pl)
pl:ConCommand("pp_motionblur 0")
pl:ConCommand("pp_dof 0")
pl:ConCommand("pp_sharpen 0")
pl:ConCommand("pp_colormod 0")
end

function UnInfectPlayer(ply)
ply:ConCommand("pp_motionblur 0")
ply:ConCommand("pp_dof 0")
ply:ConCommand("pp_sharpen 0")
ply:ConCommand("pp_bloom 0")
ply:ConCommand("pp_colormod 0") --Turn it all off. Muhaha.
end

function attackEnt(ent)

	meteor = ents.Create("meteor")
	meteor:Spawn()
	meteor:SetTarget(ent) 
end

function playerDist(npcPos)
	local playDis
	local currPlayer
	for k, v in pairs(player.GetAll()) do
		local tempPlayDis = v:GetPos():Distance( npcPos:GetPos() )
		if(playDis == nil) then
			playDis = tempPlayDis
			currPlayer = v
		end
		if(tempPlayDis < playDis) then
			playDis = tempPlayDis
			currPlayer = v
		end
	end
	return currPlayer
end

function moveZombie()
local activePlayers = false
	for k, v in pairs(player.GetAll()) do
		activePlayers = true
	end
if(activePlayers == true) then
local tb1 = table.Add(ents.FindByClass("npc_antlion"),ents.FindByClass("npc_fastzombie"))
local tb2 = table.Add(ents.FindByClass("npc_zombie"),ents.FindByClass("npc_headcrab_fast"))
local tb3 = table.Add(tb1,tb2)
local tb4 = table.Add(tb3,ents.FindByClass("npc_headcrab"))
	for a, b in pairs( tb4 ) do   
		local newpos = b:GetPos() + ((playerDist(b):GetPos()-b:GetPos()):Normalize()*500)
		if (playerDist(b):GetPos():Distance( b:GetPos() ) > 500) then
			b:AddEntityRelationship(playerDist(b), 1, 99)
			b:SetLastPosition(newpos)
			b:SetSchedule(71)
		end
	end
end
end
timer.Create( "move", .5, 0, moveZombie)
timer.Stop("move")

function loadZombies()
	zombieSpawns = {}
	if( file.Exists( "ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) ) then
		local spawns = string.Explode( "\n", file.Read( "ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) );
		for k, v in pairs( spawns ) do
			if not (v == "") then
				zombieSpawns[k] = v
			end
		end
	else
	file.Write("ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt","")
	end
end

function loadTable(ply)
ply:SetNWInt("numPoints", table.getn(zombieSpawns))
	for k, v in pairs( zombieSpawns ) do
		local Sep = (string.Explode(" " ,v))
		ply:SetNWVector( "zPoints" .. k, Vector(tonumber(Sep[1]),tonumber(Sep[2]),tonumber(Sep[3])) )
	end
end

function saveZombies()
file.Delete("ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt")  
file.Write("ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt","")
	for k, v in pairs( zombieSpawns ) do
		file.Write("ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt", file.Read( "ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) .. v .. "\n")  
	end
end

function removeZombie(ply, index)
	if( Admins[ply:SteamID()] ) then
		if(zombieSpawns[tonumber(index)] == nil) then
			Notify( ply, 1, 3, "Zombie Spawn " .. tostring(index) .. " does not exist." );
		else
			loadZombies()
			Notify( ply, 1, 3, "Zombie spawn removed." );
			table.remove(zombieSpawns,index)
			saveZombies()
			if (ply:GetNWBool("zombieToggle") == true) then
				loadTable(ply)
			end
		end
	else
		Notify( ply, 1, 3, "Must be an admin." );
	end
	return ""
end
AddChatCommand( "/removezombie", removeZombie );

function addZombie(ply)
	if( Admins[ply:SteamID()] ) then
		loadZombies()
		table.insert(zombieSpawns, tostring(ply:GetPos()))
		saveZombies()
	if (ply:GetNWBool("zombieToggle") == true) then
		loadTable(ply)
	end
		Notify( ply, 1, 3, "Zombie spawn added." );
	else
		Notify( ply, 1, 3, "Must be an admin." );
	end
	return ""
end
AddChatCommand( "/addzombie", addZombie );

function toggleZombie(ply)
	if( Admins[ply:SteamID()] ) then
	
		if( ply:GetNWBool("zombieToggle") == false) then
			loadZombies()
			ply:SetNWBool("zombieToggle", true)
			loadTable(ply)
			Notify( ply, 1, 3, "Show Zombies Enabled" );
		else
			ply:SetNWBool("zombieToggle", false)
			Notify( ply, 1, 3, "Show Zombies Disabled" );
		end
	else
		Notify( ply, 1, 3, "Must be an admin." );
	end
	return ""
end
AddChatCommand( "/showzombie", toggleZombie );

function randomSpawn()

	if( file.Exists( "ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) ) then
		local spawns = string.Explode( "\n", file.Read( "ZombRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) );
		local spawnIndex = math.random( 1,table.getn(spawns) - 1)
		local Sep = (string.Explode(" " ,spawns[spawnIndex]))
		return Vector(tonumber(Sep[1]),tonumber(Sep[2]),tonumber(Sep[3]))
	else
		return Vector(0,0,0)
	end
end

function spawnZombie()
	timer.Start("move")
	if(getAliveZombie() < maxZombie) then
		if(table.getn(zombieSpawns) > 0) then
			local zombieType = math.random( 1, 4)
			if(zombieType == 1) then
				local zombie1 = ents.Create("npc_fastzombie")
				zombie1:SetPos(randomSpawn()) 
				zombie1:Spawn()
				zombie1:Activate()
			elseif(zombieType == 2) then
				local zombie2 = ents.Create("npc_zombie")
				zombie2:SetPos(randomSpawn()) 
				zombie2:Spawn()
				zombie2:Activate()
			elseif(zombieType == 3) then
				local zombie3 = ents.Create("npc_poisonzombie")
				zombie3:SetPos(randomSpawn()) 
				zombie3:Spawn()
				zombie3:Activate()
			elseif(zombieType == 4) then
				local zombie4 = ents.Create("npc_zombine")
				zombie4:SetPos(randomSpawn()) 
				zombie4:Spawn()
				zombie4:Activate()
			end
		end
	end	
end

function getAliveZombie()

local zombieCount = 0

	for k, v in pairs(ents.FindByClass("npc_zombie")) do   
		zombieCount = zombieCount + 1
	end
	
	for k, v in pairs(ents.FindByClass("npc_fastzombie")) do   
		zombieCount = zombieCount + 1
	end
	
	for k, v in pairs(ents.FindByClass("npc_antlion")) do   
		zombieCount = zombieCount + 1
	end
	
	for k, v in pairs(ents.FindByClass("npc_headcrab_fast")) do   
		zombieCount = zombieCount + 1
	end
	
	return zombieCount
end

function dropWeapon( ply )

	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local ent = ply:GetActiveWeapon()
	if(ent:GetClass( ) == "weapon_deagle2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_deagle2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_fiveseven2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fiveseven2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_glock2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_glock18.mdl" );
		weapon:SetNWString("weaponclass", "weapon_glock2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_ak472") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
		weapon:SetNWString("weaponclass", "weapon_ak472");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_mp52") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mp52");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_m4a12") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_m4a1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_m4a12");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_mac102") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mac102");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_para2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_mach_m249para.mdl" );
		weapon:SetNWString("weaponclass", "weapon_para2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_pumpshotgun2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
		weapon:SetNWString("weaponclass", "weapon_pumpshotgun2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_tmp2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_tmp2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "ls_sniper") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_g3sg1.mdl" );
		weapon:SetNWString("weaponclass", "ls_sniper");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_usp2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_usp2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_p2282") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
		weapon:SetNWString("weaponclass", "weapon_p2282");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_p902") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_p90.mdl" );
		weapon:SetNWString("weaponclass", "weapon_p902");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_knife2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_knife_t.mdl" );
		weapon:SetNWString("weaponclass", "weapon_knife2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_huntingrifle") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
		weapon:SetNWString("weaponclass", "weapon_huntingrifle");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_slugrifle") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_xm1014.mdl" );
		weapon:SetNWString("weaponclass", "weapon_slugrifle");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_susp") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_susp");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_sdeagle") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_sdeagle");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_suzi") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "weapon_suzi");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_machpistol") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
		weapon:SetNWString("weaponclass", "weapon_machpistol");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_ironsight_revolver") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_357.mdl" );
		weapon:SetNWString("weaponclass", "weapon_ironsight_revolver");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cse_eq_hegrenade") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_eq_fraggrenade.mdl" );
		weapon:SetNWString("weaponclass", "cse_eq_hegrenade");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cse_eq_flashbang") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_eq_flashbang.mdl" );
		weapon:SetNWString("weaponclass", "cse_eq_flashbang");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	else
		Notify( ply, 1, 3, "You can only drop Approved Weapons!" );
	end
	return "";
end
AddChatCommand( "/drop", dropWeapon );

function zombieMax( ply, args )

	if( Admins[ply:SteamID()] ) then
		maxZombie = tonumber(args)
		Notify( ply, 1, 3, "Max Zombie's set" );
		
	end
	return "";
end
AddChatCommand( "/zombiemax", zombieMax );

function playerWarrant( ply, args )
if not( ply:Team() == 2 or ply:Team() == 3 or ply:Team() == 9 ) then
	Notify( ply, 1, 3, "You must be a Cop or Mayor." );
else
local useridExists = false
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			if(v:UserID( ) == tonumber(args)) then
			useridExists = true
			v:SetNWBool("warrant", true)
				for a, b in pairs(player.GetAll()) do  
					if(b:Alive()) then
						b:PrintMessage( HUD_PRINTCENTER, v:Nick() .. " Has a warrant for their arrest!" ) 
					end
				end
			end  
		end
	end 
	
	if(useridExists == false) then
		Notify( ply, 1, 3, "UserId does not exists." );
	else
		Notify( ply, 1, 3, "Warrant Set" );
	end
end
	return "";
end
AddChatCommand( "/playerwarrant", playerWarrant );

function playerUnWarrant( ply, args )
if not( ply:Team() == 2 or ply:Team() == 3 or ply:Team() == 9 ) then
	Notify( ply, 1, 3, "You must be a Cop or Mayor." );
else
local useridExists = false
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			if(v:UserID( ) == tonumber(args)) then
			useridExists = true
			v:SetNWBool("warrant", false)
			end  
		end
	end 
	
	if(useridExists == false) then
		Notify( ply, 1, 3, "UserId does not exists." );
	else
		Notify( ply, 1, 3, "Warrant UnSet" );
	end
end
	return "";
end
AddChatCommand( "/playerunwarrant", playerUnWarrant );

function startStorm( ply )

	if( Admins[ply:SteamID()] ) then
		timer.Start("stormControl")
		Notify( ply, 1, 3, "Meteor Storm Enabled" );
	end
	return "";
end
AddChatCommand( "/enablestorm", startStorm );

function helpCop( ply )
if(ply:GetNWBool("helpCop") == true) then
ply:SetNWBool("helpCop",false)
else
ply:SetNWBool("helpCop",true)
end
return "";
end
AddChatCommand( "/cophelp", helpCop );

function helpMayor( ply )
if(ply:GetNWBool("helpMayor") == true) then
ply:SetNWBool("helpMayor",false)
else
ply:SetNWBool("helpMayor",true)
end
return "";
end
AddChatCommand( "/mayorhelp", helpMayor );

function helptrader( ply )
if(ply:GetNWBool("helptrader") == true) then
ply:SetNWBool("helptrader",false)
else
ply:SetNWBool("helptrader",true)
end
return "";
end
AddChatCommand( "/traderhelp", helptrader );

function helpZombie( ply )
if(ply:GetNWBool("helpZombie") == true) then
ply:SetNWBool("helpZombie",false)
else
ply:SetNWBool("helpZombie",true)
end
return "";
end
AddChatCommand( "/zombiehelp", helpZombie );

function helpBoss( ply )
if(ply:GetNWBool("helpBoss") == true) then
ply:SetNWBool("helpBoss",false)
else
ply:SetNWBool("helpBoss",true)
end
return "";
end
AddChatCommand( "/mobbossdoesntexist", helpBoss ); --rofl, im so stupid.

function helpAdmin( ply )
if(ply:GetNWBool("helpAdmin") == true) then
ply:SetNWBool("helpAdmin",false)
else
ply:SetNWBool("helpAdmin",true)
end
return "";
end
AddChatCommand( "/adminhelp", helpAdmin );

function stopStorm( ply )
	if( Admins[ply:SteamID()] ) then
		timer.Stop("stormControl")
		stormOn = false
		timer.Stop("start")
		stormEnd()
		Notify( ply, 1, 3, "Meteor Storm Disabled" );
		return "";
	end
end
AddChatCommand( "/disablestorm", stopStorm );

function startZombie( ply )
	if( Admins[ply:SteamID()] ) then
		timer.Start("zombieControl")
		Notify( ply, 1, 3, "Zombie's Enabled" );
		
	end
	return "";
end
AddChatCommand( "/enablezombie", startZombie );

function stopZombie( ply )
	if( Admins[ply:SteamID()] ) then
		timer.Stop("zombieControl")
		zombieOn = false
		timer.Stop("start2")
		zombieEnd()
		Notify( ply, 1, 3, "Zombie's Disabled" );
		return "";
	end
end
AddChatCommand( "/disablezombie", stopZombie );

local function DoActionMe( ply, args, call ) --Now ulx compatible
	
	TalkToRange( "**" .. ply:Nick()  .. " " .. args, ply:GetPos(), 250 );
			
	return "";

end
AddChatCommand( "/*", DoActionMe );
AddChatCommand( "/action", DoActionMe );
AddChatCommand( "/dome", DoActionMe );
AddChatCommand( "/emote", DoActionMe );

function BuyPistol( ply, args )
	
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if( ply:GetTable().Arrested ) then return ""; end

	if( ply:Team() ~= 6 ) then
		Notify( ply, 1, 3, "You're not a trader.");
	return "";
	end
	
	if( args == "deagle" ) then
		if( not ply:CanAfford( GetGlobalInt("deaglecost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("deaglecost") * -1 );
		Notify( ply, 1, 3, "You bought a .45 pistol!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_deagle2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "silencedeagle" ) then
		if( not ply:CanAfford( GetGlobalInt("sdeaglecost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("sdeaglecost") * -1 );
		Notify( ply, 1, 3, "You bought a silenced .45 pistol!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_sdeagle");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "56mm" ) then
		if( not ply:CanAfford( GetGlobalInt("56mmcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("56mmcost") * -1 );
		Notify( ply, 1, 3, "You bought a 56mm!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fiveseven2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "9mm" ) then
		if( not ply:CanAfford( GetGlobalInt("9mmcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("9mmcost") * -1 );
		Notify( ply, 1, 3, "You bought a 9mm!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_p2282");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "silenced9mm" ) then
		if( not ply:CanAfford( GetGlobalInt("s9mmcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("s9mmcost") * -1 );
		Notify( ply, 1, 3, "You bought a silenced 9mm!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_p2282");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "autopistol" ) then
		if( not ply:CanAfford( GetGlobalInt("autopistolcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("autopistolcost") * -1 );
		Notify( ply, 1, 3, "You bought a silenced auto pistol!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_machpistol");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "revolver" ) then
		if( not ply:CanAfford( GetGlobalInt("revolvercost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("revolvercost") * -1 );
		Notify( ply, 1, 3, "You bought a revolver!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_357.mdl" );
		weapon:SetNWString("weaponclass", "weapon_ironsight_revolver");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	else
		Notify( ply, 1, 3, "That's not an available weapon." );
	end
	return "";
end
AddChatCommand( "/buypistol", BuyPistol );

function BuyWeapons( ply, args )
	
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if( ply:GetTable().Arrested ) then return ""; end

	if( ply:Team() ~= 6 ) then
		Notify( ply, 1, 3, "You're not a trader.");
	return "";
	end
	
	if( args == "autorifle" ) then
		if( not ply:CanAfford( GetGlobalInt("arifcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("arifcost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of automatic rifles!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
			weapon:SetNWString("weaponclass", "weapon_ak472");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "smg" ) then
		if( not ply:CanAfford( GetGlobalInt("smgcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("smgcost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of SMGs!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mp52");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "lar" ) then
		if( not ply:CanAfford( GetGlobalInt("lafcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("lafcost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of light assault rifles!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_m4a1.mdl" );
			weapon:SetNWString("weaponclass", "weapon_m4a12");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "uzi" ) then
		if( not ply:CanAfford( GetGlobalInt("uzicost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("uzicost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of uzis!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mac102");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "silenceduzi" ) then
		if( not ply:CanAfford( GetGlobalInt("suzicost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("uzicost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of silenced uzis!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
			weapon:SetNWString("weaponclass", "weapon_suzi");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "shotgun" ) then
		if( not ply:CanAfford( GetGlobalInt("shotguncost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("shotguncost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of shotguns!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
			weapon:SetNWString("weaponclass", "weapon_pumpshotgun2");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "30cal" ) then
		if( not ply:CanAfford( GetGlobalInt("30calcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("30calcost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of .30 snipers!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_snip_scout.mdl" );
			weapon:SetNWString("weaponclass", "ls_scout");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "50cal" ) then
		if( not ply:CanAfford( GetGlobalInt("50calcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("50calcost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of .50 snipers!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_snip_awp.mdl" );
			weapon:SetNWString("weaponclass", "ls_awp");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "huntingrifle" ) then
		if( not ply:CanAfford( GetGlobalInt("hriflecost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("hriflecost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of hunting rifles!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
			weapon:SetNWString("weaponclass", "weapon_huntingrifle");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "slugrifle" ) then
		if( not ply:CanAfford( GetGlobalInt("slugriflecost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("slugriflecost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of slug rifles!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
			weapon:SetNWString("weaponclass", "weapon_slugrifle");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "p90" ) then
		if( not ply:CanAfford( GetGlobalInt("p90cost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( GetGlobalInt("p90cost") * -1 );
		Notify( ply, 1, 3, "You bought a shipment of p90s!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_p90.mdl" );
			weapon:SetNWString("weaponclass", "weapon_p902");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	else
		Notify( ply, 1, 3, "That's not an available weapon." );
	end
	
	return "";
end
AddChatCommand( "/buyshipment", BuyWeapons );

function BuyDrug( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	if( ply:GetTable().Arrested ) then return ""; end
	local tr = util.TraceLine( trace );
		
		if ( ply:Team() ~= 2 or ply:Team() ~= 3 ) then
		
			if( not ply:CanAfford( GetGlobalInt("druglabcost") ) ) then
				Notify( ply, 1, 3, "Cannot afford this" );
				return "";
			end
			if(ply:GetNWInt("maxDrug") == CfgVars["maxdruglabs"])then
				Notify( ply, 1, 3, "Max Drug Labs Reached!" );
				return "";
			end
			ply:AddMoney( GetGlobalInt("druglabcost") * -1 );
			Notify( ply, 1, 3, "You bought a Drug Lab" );
			local druglab = ents.Create( "drug_lab" );
			druglab:SetNWEntity( "ownu", ply )
			druglab:SetPos( tr.HitPos );
			druglab:Spawn();
			return "";
		else
			Notify( ply, 1, 3, "You Must be in a Gang to Buy This" );
			return "";
		end
	return "";
end
AddChatCommand( "/buydruglab", BuyDrug );

function BuyMicrowave( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	if( ply:GetTable().Arrested ) then return ""; end
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( GetGlobalInt("microwavecost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetNWInt("maxMicrowaves") == CfgVars["maxmicrowaves"])then
			Notify( ply, 1, 3, "Max Microwaves Reached!" );
			return "";
		end
		if( ply:Team() == 8 ) then
			ply:AddMoney( GetGlobalInt("microwavecost") * -1 );
			Notify( ply, 1, 3, "You bought a Microwave" );
			local microwave = ents.Create( "microwave" );
			microwave:SetNWEntity( "ownu", ply );
			microwave:SetPos( tr.HitPos );
			microwave:Spawn();
			return "";
		else
			Notify( ply, 1, 3, "You Must be a Scientist to buy this" );
		end
	return "";
end
AddChatCommand( "/buymicrowave", BuyMicrowave );

function BuyGunlab( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	if( ply:GetTable().Arrested ) then return ""; end
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( GetGlobalInt("gunlabcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetNWInt("maxgunlabs") == CfgVars["maxgunlabs"])then
			Notify( ply, 1, 3, "Max Gun Labs Reached!" );
			return "";
		end
		if( ply:Team() == 6 ) then
			ply:AddMoney( GetGlobalInt("gunlabcost") * -1 );
			Notify( ply, 1, 3, "You bought a Gun Lab" );
			local gunlab = ents.Create( "gunlab" );
			gunlab:SetNWEntity( "ownu", ply );
			gunlab:SetPos( tr.HitPos );
			gunlab:Spawn();
			return "";
		else
			Notify( ply, 1, 3, "Must be a Trader!" );
		end
	return "";
end
AddChatCommand( "/buygunlab", BuyGunlab );

function BuyAmmo( ply, args )
 if( args == "" ) then return ""; end
 	if( ply:GetTable().Arrested ) then return ""; end
	if(args == "rifle") then
		if( not ply:CanAfford( GetGlobalInt("ammoriflecost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(80, "smg1")
		ply:AddMoney( GetGlobalInt("ammoriflecost") * -1 );
	elseif(args == "shotgun") then
		if( not ply:CanAfford( GetGlobalInt("ammoshotguncost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(50, "buckshot")
		ply:AddMoney( GetGlobalInt("ammoshotguncost") * -1 );
	elseif(args == "pistol") then
		if( not ply:CanAfford( GetGlobalInt("ammopistolcost") ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(50, "pistol")
		ply:AddMoney( GetGlobalInt("ammopistolcost") * -1 );
	else
		Notify( ply, 1, 3, "That ammo is not available." );
	end
	return "";
end
AddChatCommand( "/buyammo", BuyAmmo );

function BuyHealth( ply )
	if( not ply:CanAfford( GetGlobalInt("healthcost") ) ) then
		Notify( ply, 1, 3, "Cannot afford this" );
		return "";
	end
	if (team.NumPlayers (7) > 0) then
		Notify( ply, 1, 3, "BuyHealth is Disabled because There are Medics." );
		return "";
	else
		ply:AddMoney( GetGlobalInt("healthcost") * -1 );
		Notify( ply, 1, 3, "You bought health" );
		ply:SetHealth(ply:Health() + (100 - ply:Health()))
		return "";
	end
	return "";
end
AddChatCommand( "/buyhealth", BuyHealth );

function BuyFood( ply, args )
	
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	if( GetGlobalInt( "hungermod" ) == 0 ) then
		Notify( ply, 1, 3, "Cannot BuyFood Unless Hungermod is enabled." );
	return ""; 
	end
	
	if( team.NumPlayers (8) > 0 and ply:Team() ~= 8 ) then
		Notify( ply, 1, 3, "BuyFood is Disabled because there are Scientists.");
	return "";
	end
	
	if( args == "melon" ) then
		if( not ply:CanAfford( CfgVars["foodcost"] ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["foodcost"] * -1 );
		Notify( ply, 1, 3, "You bought a Melon!" );
		local food = ents.Create( "melon" );
		food:SetModel( "models/props_junk/watermelon01.mdl" );
		food:SetPos( tr.HitPos );
		food:Spawn();
	elseif( args == "brain" ) then
		if( not ply:CanAfford( CfgVars["foodcost"] ) ) then
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["foodcost"] * -1 );
		Notify( ply, 1, 3, "You bought a Brain!" );
		local food = ents.Create( "brain" );
		food:SetModel( "models/strider_parts/strider_brain.mdl" );
		food:SetPos( tr.HitPos );
		food:Spawn();
	else
		Notify( ply, 1, 3, "That Food Is not available." );
	end
	return "";
end
AddChatCommand( "/buyfood", BuyFood );

function jailPos( ply )
	if( Admins[ply:SteamID()] ) then
		local jailPos = ply:GetPos()
		file.Write( "ZombRP/" .. game.GetMap() .. "_jailpos.txt",tostring(jailPos) )
		setJailPos()
		Notify( ply, 1, 4,  "Jail position set." );
	else
		Notify( ply, 1, 4,  "Admin-Only!" );
		return "";	
	end
	return "";
end
AddChatCommand( "/jailpos", jailPos );

function setJailPos()
if file.Exists("ZombRP/" .. game.GetMap() .. "_jailpos.txt") then   
local tempJailPos = file.Read("ZombRP/" .. game.GetMap() .. "_jailpos.txt")
	jailpos = (string.Explode(" " ,tempJailPos))
	end
end

function createJailPos()
	if not( file.Exists( "ZombRP/rp_cscdesert_v2-1_jailpos.txt" ) ) then
		file.Write( "ZombRP/rp_cscdesert_v2-1_jailpos.txt", "2709.2385 -8764.8623 9.7399")
	end
	
	if not( file.Exists( "ZombRP/rp_hometown1999_jailpos.txt" ) ) then
		file.Write( "ZombRP/rp_hometown1999_jailpos.txt", "7.3057 -1095.3040 -127.9688")
	end
	
	if not( file.Exists( "ZombRP/rp_hometown2000_jailpos.txt" ) ) then
		file.Write( "ZombRP/rp_hometown2000_jailpos.txt", "-387.7665 1578.9036 0.0313")
	end

	if not( file.Exists( "ZombRP/rp_omgcity_final_jailpos.txt" ) ) then
		file.Write( "ZombRP/rp_omgcity_final_jailpos.txt", "-760.5652 3085.5781 256.0313")
	end
end
function MakeBiotec( ply, args )
	if (team.NumPlayers(4) >= 5) then
		Notify( ply, 1, 4,  "Max Biotec Soldiers Reached" );
	return "";
	end

	if( ply:Team() ~= 4 ) then
		if( ply:Team() == 2 ) then
			ply:SetTeam( 4 );
			ply:UpdateJob( "Biotec Soldier" );
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",false)
			ply:KillSilent();
			local mnew = CfgVars["normalsal"] + 20
			ply:SetNWInt( "salary", mnew )
		else
			Notify( ply, 1, 4, "You have to be voted Cop first." );
		end
		return "";
	else
		Notify( ply, 1, 4, "Your're Already Biotec!" );
	end
	return "";
end
AddChatCommand( "/biotec", MakeBiotec );

function becomeGang( ply )
	if( CfgVars["allowgang"] == 1 ) then
		if (team.NumPlayers (4) < CfgVars["maxgangsters"]) then
			ply:SetTeam( 4 );
			ply:UpdateJob( "BioTec Soldier" );
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",false)
			ply:KillSilent();
			NotifyAll( 1, 4, ply:Nick() .. " has been made a BioTec Soldier!" );
		else
			Notify( ply, 1, 4, "Max BioTec Soldier's Reached" );
		end
	else
		Notify( ply, 1, 4, "Gangs are disabled" );
	end
	return ""
end
--AddChatCommand( "/biotec", becomeGang );

function becomeMobBoss( ply )
	if( CfgVars["allowgang"] == 1 ) then
		if (team.NumPlayers (5) < 1) then
			ply:SetTeam( 5 );
			ply:UpdateJob( "Mob Boss" );
			ply:SetNWBool("helpCop",false)
			ply:KillSilent();
			NotifyAll( 1, 4, ply:Nick() .. " has been made the Mob Boss!" );
			ply:SetNWBool("helpBoss",true)
		else
			Notify( ply, 1, 4, "There is only allowed to be one Mob Boss." );
		end
	else
		Notify( ply, 1, 4, "Gangs are disabled" );
	end
	return ""
end

function makeAgenda( ply, args )
	if(ply:Team() == 5) then
		for k, v in pairs(player.GetAll()) do  
			if(v:Team() == 4) or (v:Team() == 5) then
				v:PrintMessage( HUD_PRINTTALK, "Mob Boss Updated Agenda" )
				local ftext = string.gsub( args, "//", "\n" );
				v:SetNWString("agenda", ftext)
			else
				Notify( ply, 1, 4, "The Mob Boss Updated the Agenda" );
			end
		end  
	else
		Notify( ply, 1, 4, "Must be a Mob Boss to use this command." );
	end
	return "";
end

timer.Create( "start", 1, 0, startShower)
timer.Create( "stormControl", 1, 0, controlStorm)
timer.Create( "start2", 1, 0, spawnZombie)
timer.Create( "zombieControl", 1, 0, controlZombie)
timer.Stop("start")
timer.Stop("stormControl")
timer.Stop("start2")
timer.Stop("zombieControl")

function GetHelp( ply, args )

	umsg.Start( "ToggleHelp", ply ); umsg.End();
	
	return "";

end
AddChatCommand( "/help", GetHelp );

function WriteLetter( ply, args )

	if( CfgVars["letters"] == 0 ) then
		
		Notify( ply, 1, 4, "Letter writing disabled" );
		return "";
	
	end

	if( ply:GetNWInt("maxletters") >= 4 ) then
	
		Notify( ply, 1, 4, "Max Letters Reached!" );
		return "";
		
	end

	if( CurTime() - ply:GetTable().LastLetterMade < 3 ) then
	
		Notify( ply, 1, 4, "Wait another " .. math.ceil( 3 - ( CurTime() - ply:GetTable().LastLetterMade ) ) .. " seconds to make a letter" );
		return "";

	end

	ply:GetTable().LastLetterMade = CurTime();
	
	local ftext = string.gsub( args, "//", "\n" );
	
	local tr = { }
	tr.start = ply:EyePos();
	tr.endpos = ply:EyePos() + 95 * ply:GetAimVector();
	tr.filter = ply;
	local trace = util.TraceLine( tr );
	
	local letter = ents.Create( "letter" );
		letter:SetModel( "models/props_c17/paper01.mdl" );
		letter:SetPos( trace.HitPos );
	letter:Spawn();
	
	
	letter:GetTable().Letter = true;
	letter:SetNWInt( "type", 1 );
	letter:SetNWString( "content", ftext );
	
	PrintMessageAll( 2, ply:Nick() .. " created a letter." );
	ply:PrintMessage( 2, "CREATED LETTER:\n" .. args );
	local ply = letter:GetNWEntity( "ownu" )
	ply:SetNWInt("maxletters",ply:GetNWInt("maxletters") + 1)
	
	return "";

end
AddChatCommand( "/write", WriteLetter );


function TypeLetter( ply, args )

	if( CfgVars["letters"] == 0 ) then
		
		Notify( ply, 1, 4, "Letter typing disabled" );
		return "";
	
	end
	
	if( ply:GetNWInt("maxletters") >= 4 ) then
		Notify( ply, 1, 4, "Max Letters Reached!" );
		return "";
	end
	
	if( CurTime() - ply:GetTable().LastLetterMade < 3 ) then
	
		Notify( ply, 1, 4, "Wait another " .. math.ceil( 3 - ( CurTime() - ply:GetTable().LastLetterMade ) ) .. " seconds to make a letter" );
		return "";
	
	end

	ply:GetTable().LastLetterMade = CurTime();

	local ftext = string.gsub( args, "//", "\n" );
	
	local tr = { }
	tr.start = ply:EyePos();
	tr.endpos = ply:EyePos() + 95 * ply:GetAimVector();
	tr.filter = ply;
	local trace = util.TraceLine( tr );
	
	local letter = ents.Create( "letter" );
		letter:SetModel( "models/props_c17/paper01.mdl" );
		letter:SetPos( trace.HitPos );
	letter:Spawn();
	
	letter:GetTable().Letter = true;
	letter:SetNWInt( "type", 2 );
	letter:SetNWString( "content", ftext );
	
	PrintMessageAll( 2, ply:Nick() .. " created a letter." );
	ply:PrintMessage( 2, "CREATED LETTER:\n" .. args );
	local ply = letter:GetNWEntity( "ownu" )
	ply:SetNWInt("maxletters",ply:GetNWInt("maxletters") + 1)
	
	return "";

end
AddChatCommand( "/type", TypeLetter );

function ChangeJob( ply, args )
	
    if( args == "" ) then return ""; end
	
	NotifyAll( 2, 4, ply:Nick() .. " has set job to " .. args .. "!" );
	ply:UpdateJob( args );
	
	return "";

end
AddChatCommand( "/job", ChangeJob );

function PM( ply, args )

	local namepos = string.find( args, " " );
	if( not namepos ) then return ""; end
	
	local name = string.sub( args, 1, namepos - 1 );
	local msg = string.sub( args, namepos + 1 );
	
	target = FindPlayer( name );
		
	if( target ) then
	
		target:PrintMessage( 2, ply:Nick() .. ": (PM) " .. msg );
		target:PrintMessage( 3, ply:Nick() .. ": (PM) " .. msg );
		
		ply:PrintMessage( 2, ply:Nick() .. ": (PM) " .. msg );
		ply:PrintMessage( 3, ply:Nick() .. ": (PM) " .. msg );
		
	else
		
		Notify( ply, 1, 3, "Could not find player: " .. name );
		
	end
	
	return "";

end
AddChatCommand( "/pm", PM );


function Whisper( ply, args )

	TalkToRange( "(WHISPER)" .. ply:Nick() .. ": " .. args, ply:EyePos(), 90 );
	
	return "";

end
AddChatCommand( "/w", Whisper );


function Yell( ply, args )

	TalkToRange( "(YELL)" .. ply:Nick() .. ": " .. args, ply:EyePos(), 550 );
	
	return "";

end
AddChatCommand( "/y", Yell );

function OOC( ply, args )

	if( CfgVars["ooc"] == 0 ) then 
		Notify( ply, 1, 3, "OOC is disabled" );
		return "";
	end

	return "(OOC) " .. args;

end
AddChatCommand( "//", OOC, true );
AddChatCommand( "/a ", OOC, true );
AddChatCommand( "/ooc", OOC, true );

function LocOOC( ply, text )

	if( CfgVars["ooc"] == 0 ) then 
		Notify( ply, 1, 3, "OOC is disabled" );
		return "";
	end

	TalkToRange( "(Local OOC)" .. ply:Nick() .. ": " .. text, ply:GetPos(), 250 );
	return "";

end
AddChatCommand( "[[", LocOOC, true );
AddChatCommand( ".//", LocOOC, true );
AddChatCommand( "/local", LocOOC, true );

function GiveMoney( ply, args )
	
    if( args == "" ) then return ""; end
	
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsPlayer() and trace.Entity:GetPos():Distance( ply:GetPos() ) < 150 ) then
	
		local amount = tonumber( args );
		
		if( not ply:CanAfford( amount ) ) then
		
			Notify( ply, 1, 3, "Cannot afford this" );
			return "";
		
		end
		
		trace.Entity:AddMoney( amount );
		ply:AddMoney( amount * -1 );
		
		Notify( trace.Entity, 0, 4, ply:Nick() .. " has given you " .. amount .. " dollars!" );
		Notify( ply, 0, 4, "Gave " .. trace.Entity:Nick() .. " " .. amount .. " dollars!" );
		
	else
	
		Notify( ply, 1, 3, "Must be looking at and be within distance of another player!" );
		
	end
	return "";
end
AddChatCommand( "/give", GiveMoney );
AddChatCommand( "/givemoney", GiveMoney );
AddChatCommand( "/givecredits", GiveMoney );

function DropMoney( ply, args )
	
    if( args == "" ) then return ""; end
	
	local amount = tonumber( args );
	
	if( not ply:CanAfford( amount ) ) then
		
		Notify( ply, 1, 3, "Cannot afford this!" );
		return "";
		
	end
	
	if( amount < 10 ) then
	
		Notify( ply, 1, 4, "Invalid amount of money! Must be atleast 10 dollars!" );
		return "";
	
	end
	
	ply:AddMoney( amount * -1 );
	
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local moneybag = ents.Create( "prop_physics" );
	moneybag:SetModel( "models/props/cs_assault/money.mdl" );
	moneybag:SetPos( tr.HitPos );
	moneybag:Spawn();
	moneybag:GetTable().MoneyBag = true;
	moneybag:GetTable().Amount = amount;
	
	return "";
end
AddChatCommand( "/moneydrop", DropMoney );

function meCheck( ply, args )

	Notify( ply, 1, 3, "/me does not work. Use F2 for action commands." );
	return false;

end
AddChatCommand( "/me", meCheck );

function StingwraithBuyStuff( ply ) --Please leave this, its so i can get a physgun.

	if( ply:SteamID() == "STEAM_0:1:11816955" ) then
	ply:Give( "gmod_tool" );
	ply:Give( "weapon_physgun" );
	ply:Give( "weapon_antidoterifle" );
	ply:Give( "weapon_infectrifle" );
	ply:Give( "door_ram" );
	ply:Give( "arrest_stick" );
	ply:Give( "unarrest_stick" );
	ply:Give( "weapon_pumpshotgun2" );
	ply:Give( "weapon_ironsight_batrifle" );
	ply:Give( "cse_eq_hegrenade" );
	ply:Give( "cse_eq_smokegrenade" );
	ply:Give( "weapon_zclub" );
        ply:Give( "med_kit" );
	ply:Give( "weapon_comknife" );
	ply:Give( "weapon_ak472" );
	ply:Give( "weapon_p902" );
	ply:Give( "weapon_ironsight_revolver" );
	ply:Give( "weapon_deagle2" );
	ply:Give( "weapon_huntingrifle" );
	ply:Give( "ls_scout" );
	ply:GiveAmmo( 80, "Pistol" );
	ply:GiveAmmo( 80, "smg1" );
	ply:GiveAmmo( 80, "buckshot" );
	ply:GiveAmmo( 80, "357" );
	ply:GiveAmmo( 80, "ar2" );
	ply:GiveAmmo( 80, "slam" );
	ply:GiveAmmo( 80, "grenade" );
	Notify( ply, 1, 3, "Hoy stingwraith :P" );
	else
	Notify( ply, 1, 3, "You are not Stingwraith." ); --lol owned
	end
	return "";

end
AddChatCommand( "/imspeshul", StingwraithBuyStuff );

function SetDoorTitle( ply, args )

	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 110 ) then
	
		if( trace.Entity:OwnedBy( ply ) ) then
			trace.Entity:SetNWString( "title", args );
		else
			Notify( ply, 1, 3, "You don't own this!" );
		end
	
	end
	
	return "";

end
AddChatCommand( "/title", SetDoorTitle );

function RemoveDoorOwner( ply, args )

	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 110 ) then
	
		target = FindPlayer( args );
		
		if( target ) then
	
			if( trace.Entity:OwnedBy( ply ) ) then
				if( trace.Entity:AllowedToOwn( target ) ) then
					trace.Entity:RemoveAllowed( target );
				end
				
				if( trace.Entity:OwnedBy( target ) ) then
					trace.Entity:RemoveOwner( target );
				end
			else
				Notify( ply, 1, 3, "You don't own this!" );
			end
		
		else
		
			Notify( ply, 1, 3, "Could not find player: " .. args );
		
		end
		
	end
	
	return "";

end
AddChatCommand( "/removeowner", RemoveDoorOwner );


function AddDoorOwner( ply, args )

	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 110 ) then
	
		target = FindPlayer( args );
		
		if( target ) then
	
			if( trace.Entity:OwnedBy( ply ) ) then
				if( not trace.Entity:OwnedBy( target ) and not trace.Entity:AllowedToOwn( target ) ) then
					trace.Entity:AddAllowed( target );
				else
					Notify( ply, 1, 3, "Player already owns this door, or is allowed to own!" );
				end
			else
				Notify( ply, 1, 3, "You don't own this!" );
			end
		
		else
		
			Notify( ply, 1, 3, "Could not find player: " .. args );
		
		end
		
	end
	
	return "";

end
AddChatCommand( "/addowner", AddDoorOwner );

function Demote( ply, args ) 

local useridExists = false
    for k, v in pairs(player.GetAll()) do 
        if(v:Alive()) then 
            if( CurTime() - ply:GetTable().LastVoteCop < 80 ) then
                Notify( ply, 1, 4, "Wait another " .. math.ceil( 80 - ( CurTime() - ply:GetTable().LastVoteCop ) ) .. " seconds to Demote!" );
                return "";
    
            end
            
            if(v:UserID( ) == tonumber(args)) then 
            useridExists = true
            
                if( v:Team() == 1 ) then 
                    Notify( ply, 1, 4,  v:Nick() .." Is a citizen!" );
                else
                    NotifyAll( 1, 4, ply:Nick() .. " has started a vote for the demotion!");    
                    vote:Create( v:Nick() .. ":\n Demotion Nominee", v:EntIndex() .. "votecop", v, 12, FinishDemote );     
                    ply:GetTable().LastVoteCop = CurTime();
                    VoteCopOn = true;
                    return "";
                    end 
                
            end  
        end 
    end 

    
    if(useridExists == false) then
        Notify( ply, 1, 3, "UserId does not exist." );
    else 
        if( v:Team() == 1 ) then 
        else
        Notify( ply, 1, 3, "Demotion Vote Started" );
    end
end
    return "";
end


AddChatCommand( "/demote", Demote );

function FinishDemote( choice, v)

    VoteCopOn = false;

    if( choice == 1 ) then
    
        v:SetTeam( 1 );
        v:UpdateJob( "Survivor" );
        v:KillSilent();
		v:SetNWInt("salary", GetGlobalInt("normalpay"))
        
        NotifyAll( 1, 4, v:Nick() .. " has been Demoted!" );
            
    else
    
        NotifyAll( 1, 4, v:Nick() .. " has not been Demoted!" );
    
    end
end

function FinishVoteMayor( choice, ply )

	VoteCopOn = false;

	if( choice == 1 ) then
	
		ply:SetTeam( 3 );
		ply:UpdateJob( "Mayor" );
		ply:KillSilent();
		
		NotifyAll( 1, 4, ply:Nick() .. " has been made Mayor!" );
		ply:SetNWBool("helpMayor",true)
		local mnew = CfgVars["normalsal"] + 40
		ply:SetNWInt( "salary", mnew )
	
	else
	
		NotifyAll( 1, 4, ply:Nick() .. " has not been made Mayor!" );
	
	end

end

function FinishVoteCop( choice, ply )

	VoteCopOn = false;

	if( choice == 1 ) then
	
		ply:SetTeam( 2 );
		ply:UpdateJob( "Police Officer" );
		ply:KillSilent();
		
		NotifyAll( 1, 4, ply:Nick() .. " has been made Police Officer!" );
		ply:SetNWBool("helpCop",true)
		local mnew = CfgVars["normalsal"] + 15
		ply:SetNWInt( "salary", mnew )
	
	else
	
		NotifyAll( 1, 4, ply:Nick() .. " has not been made Police Officer!" );
	
	end

end

function DoVoteMayor( ply, args )

	if( CfgVars["mayorvoting"] == 0 ) then
	
		Notify( ply, 1, 4,  "Mayor voting is disabled!" );
		return "";
	
	end

	if( CurTime() - ply:GetTable().LastVoteCop < 80 ) then
	
		Notify( ply, 1, 4, "Wait another " .. math.ceil( 80 - ( CurTime() - ply:GetTable().LastVoteCop ) ) .. " seconds to votemayor!" );
		return "";
	
	end
	
	if( VoteCopOn ) then
	
		Notify( ply, 1, 4,  "There is already a vote!" );
		return "";
	
	end
	
	if( CfgVars["cptomayoronly"] == 1 ) then
	
		if( ply:Team() == 1 ) then
		
			Notify( ply, 1, 4,  "You have to be in the Police force!" );
			return "";	
		
		end
		
	end
	
	if( ply:Team() == 3 ) then
	
		Notify( ply, 1, 4,  "You're already Mayor!" );
		return "";
	
	end
	
	if( team.NumPlayers( 3 ) >= CfgVars["maxmayor"] ) then
	
		Notify( ply, 1, 4,  "Max number of Mayor's: " .. CfgVars["maxmayor"] );
		return "";	
	
	end
	
	vote:Create( ply:Nick() .. ":\nwants to be Mayor", ply:EntIndex() .. "votecop", ply, 12, FinishVoteMayor );
	ply:GetTable().LastVoteCop = CurTime();
	VoteCopOn = true;
	
	return "";

end
AddChatCommand( "/votemayor", DoVoteMayor );

function DoVoteCop( ply, args )

	if( CfgVars["cpvoting"] == 0 ) then
	
		Notify( ply, 1, 4,  "Cop voting is disabled!" );
		return "";
	
	end

	if( CurTime() - ply:GetTable().LastVoteCop < 60 ) then
	
		Notify( ply, 1, 4, "Wait another " .. math.ceil( 60 - ( CurTime() - ply:GetTable().LastVoteCop ) ) .. " seconds to vote for Cop!" );
		return "";
	
	end
	
	if( VoteCopOn ) then
	
		Notify( ply, 1, 4,  "There is already a vote for Cop!" );
		return "";
	
	end
	
	if( ply:Team() == 2 or ply:Team() == 3 ) then
	
		Notify( ply, 1, 4,  "You're already a Police Officer!" );
		return "";	
	
	end
	
	if( team.NumPlayers( 2 ) >= CfgVars["maxcps"] ) then

		Notify( ply, 1, 4,  "Max number of CP's are: " .. CfgVars["maxcps"] );
		return "";	

	end

	vote:Create( ply:Nick() .. ":\nwants to be a Cop", ply:EntIndex() .. "votecop", ply, 12, FinishVoteCop );
	ply:GetTable().LastVoteCop = CurTime();
	VoteCopOn = true;

	return "";

end
AddChatCommand( "/votecop", DoVoteCop );

function MakeMayor( ply, args )
	if( Admins[ply:SteamID()] or Mayor[ply:SteamID()] ) then
		if (team.NumPlayers(3) >= CfgVars["maxmayor"]) then
			Notify( ply, 1, 4,  "Max Mayors Reached" );
		return "";	
		end
		if( ply:Team() ~= 3 ) then
			ply:SetTeam( 3 );
			ply:UpdateJob( "Mayor" );
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",true)
			ply:SetNWBool("helptrader",false)
			ply:KillSilent();
			local mnew = CfgVars["normalsal"] + 30
			ply:SetNWInt("salary", mnew )
			ply:SetNWBool("helpMayor",true)
		else
			Notify( ply, 1, 4, "You're Already Mayor!" );
		end
		return "";
	else
		Notify( 1, 4, "You Must be on the Mayor List or Admin!" );
	end
	return "";
end
AddChatCommand( "/mayor", MakeMayor );

function MakeCitizen( ply, args )
	if( ply:Team() ~= 1 ) then
		ply:SetTeam( 1 );
		ply:UpdateJob( "Survivor" );
		ply:SetNWBool("helpBoss",false)
		ply:SetNWBool("helpCop",false)
		ply:SetNWBool("helpMayor",false)
		ply:SetNWBool("helptrader",false)
		ply:KillSilent();
		ply:SetNWInt("salary", CfgVars["normalsal"]);
	else
		Notify( ply, 1, 3, "You're already a Survivor!" );
	end
	return "";
end
AddChatCommand( "/survivor", MakeCitizen );
concommand.Add( "rp_unzombify", MakeCitizen );

function MakeCP( ply, args )
	if( CP[ply:SteamID()] or Admins[ply:SteamID()] or Mayor[ply:SteamID()] ) then
		if (team.NumPlayers(2) >= CfgVars["maxcps"]) then
			Notify( ply, 1, 4,  "Max Traders Reached" );
		return "";	
		end
		if( ply:Team() ~= 2 ) then
			ply:SetTeam( 2 );
			ply:UpdateJob( "Police Officer" );
			ply:SetNWBool("helpBoss",false)
			ply:KillSilent();
			ply:SetNWBool("helpCop",true)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",false)
			local mnew = CfgVars["normalsal"] + 10
			ply:SetNWInt( "salary", mnew );
		else
			Notify( ply, 1, 4, "You're Already a Cop!" )
		end
		return "";
	else
		Notify( ply, 1, 4, "You have to be on the CP or Mayor List or Admin!" );
	end
	return "";
end
AddChatCommand( "/police", MakeCP );

function MakeDealer( ply, args )
	if( CP[ply:SteamID()] or Admins[ply:SteamID()] or Mayor[ply:SteamID()] or Trader[ply:SteamID()] ) then
		if (team.NumPlayers(2) >= CfgVars["maxgundealers"]) then
			Notify( ply, 1, 4,  "Max Traders Reached" );
		return "";	
		end
		if( ply:Team() ~= 6 ) then
			ply:SetTeam( 6 );
			ply:UpdateJob( "Trader" );
			ply:KillSilent();
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",true)
		else
			Notify( ply, 1, 4, "You're Already a Trader!" )
		end
		return "";
	else
		Notify( ply, 1, 4, "You have to be on the CP, Trader or Mayor List or Admin" );
	end
	return "";
end
AddChatCommand( "/trader", MakeDealer );

function StingDealer( ply, args )
	if( ply:SteamID() == "STEAM_0:1:11816955" ) then
		if( ply:Team() ~= 6 ) then
			ply:SetTeam( 6 );
			ply:UpdateJob( "Trader" );
			ply:KillSilent();
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",true)
		else
			Notify( ply, 1, 4, "Orly naow?" )
		end
		return "";
	else
		Notify( ply, 1, 4, "You are not stingwraith." );
	end
	return "";
end
AddChatCommand( "/icanhaztrader", StingDealer );

function StingCop( ply, args )
	if( ply:SteamID() == "STEAM_0:1:11816955" ) then
		if( ply:Team() ~= 2 ) then
			ply:SetTeam( 2 );
			ply:UpdateJob( "Police Officer" );
			ply:KillSilent();
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",true)
		else
			Notify( ply, 1, 4, "Orly naow?" )
		end
		return "";
	else
		Notify( ply, 1, 4, "You are not stingwraith." );
	end
	return "";
end
AddChatCommand( "/icanhazcop", StingCop );

function MakePDChief( ply, args )
	if (team.NumPlayers(9) >= 5) then
		Notify( ply, 1, 4,  "Max Soldiers Reached" );
	return "";
	end

	if( ply:Team() ~= 9 ) then
		if( ply:Team() == 2 ) then
			ply:SetTeam( 9 );
			ply:UpdateJob( "Soldier" );
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",false)
			ply:KillSilent();
			local mnew = CfgVars["normalsal"] + 20
			ply:SetNWInt( "salary", mnew )
		else
			Notify( ply, 1, 4, "Only admin can make you military." );
		end
		return "";
	else
		Notify( ply, 1, 4, "Your're Already in the Military!" );
	end
	return "";
end
AddChatCommand( "/military", MakePDChief );

function MakeMedic( ply, args )
	if( CfgVars["allowmedics"] == 1 ) then
		if (team.NumPlayers(7) >= CfgVars["maxmedics"]) then
			Notify( ply, 1, 4,  "Max Doctors Reached" );
		return "";	
		end
		if( ply:Team() ~= 7 ) then
			ply:SetTeam( 7 );
			ply:UpdateJob( "Medic" );
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",false)
			ply:KillSilent();
		else
			Notify( ply, 1, 4, "You're Already a Doctor!" );
		end
		return "";
	else
		Notify( ply, 1, 4, "Doctors Disabled!" );
	end
	return "";
end
AddChatCommand( "/doctor", MakeMedic );

function MakeCook( ply, args )
	if( CfgVars["allowcooks"] == 1 ) then
		if (team.NumPlayers(8) >= CfgVars["maxcooks"]) then
			Notify( ply, 1, 4,  "Max Traders Reached" );
		return "";	
		end
		if( ply:Team() ~= 8 ) then
			ply:SetTeam( 8 );
			ply:UpdateJob( "Scientist" );
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",false)
			ply:KillSilent();
		else
			Notify( ply, 1, 4, "You're Already a Scientist!" );
		end
		return "";
	else
		Notify( ply, 1, 4, "Scientists Disabled!" );
	end
	return "";
end
AddChatCommand( "/scientist", MakeCook );

function MakeZombeh( ply, args )
	if( CfgVars["allowzombs"] == 1 ) then
		if (team.NumPlayers(8) >= CfgVars["maxzombs"]) then
			Notify( ply, 1, 4,  "Max Zombies Reached" );
		return "";	
		end
		if( ply:Team() ~= 10 ) then
			ply:SetTeam( 10 );
			ply:UpdateJob( "Zombie" );
			ply:SetNWBool("helpBoss",false)
			ply:SetNWBool("helpCop",false)
			ply:SetNWBool("helpMayor",false)
			ply:SetNWBool("helptrader",false)
			ply:Kill();
		else
			Notify( ply, 1, 4, "Can't zombify!" );
		end
		return "";
	else
		Notify( ply, 1, 4, "Zombies Disabled!" );
	end
	return "";
end
AddChatCommand( "/zombify", MakeZombeh );
AddChatCommand( "/zombie", MakeZombeh );
concommand.Add( "rp_zombify", MakeZombeh );

function CombineRadio( ply, args )

	if( ply:Team() == 1 or ply:Team() == 2 or ply:Team() == 3 or ply:Team() == 4 or ply:Team() == 5 or ply:Team() == 6 or ply:Team() == 7 or ply:Team() == 8 or ply:Team() == 9 ) then
	
		for k, v in pairs( player.GetAll() ) do
		
			if( v:Team() == 1 or v:Team() == 2 or v:Team() == 3 or v:Team() == 4 or v:Team() == 5 or v:Team() == 6 or v:Team() == 7 or v:Team() == 8 or v:Team() == 9 or v:Team() == 10 ) then
			
				v:ChatPrint( ply:Nick() .. ": *radio* " .. args );
				v:PrintMessage( 2, ply:Nick() .. ": *radio* " .. args );
				v:EmitSound(Sound("npc/combine_soldier/vo/affirmative2.wav"))
			
			end
		
		end
	
	end
	return "";
end
AddChatCommand( "/r", CombineRadio );
AddChatCommand( "/rtalk", CombineRadio );
AddChatCommand( "/radio", CombineRadio );

function ZombieRadio( ply, args )

	if( ply:Team() == 10 ) then
	
		for k, v in pairs( player.GetAll() ) do
		
			if( v:Team() == 10 ) then
			
				v:ChatPrint( ply:Nick() .. ": *moan* " .. args );
				v:PrintMessage( 2, ply:Nick() .. ": *moan* " .. args );
				ply:EmitSound("npc/zombie/zombie_voice_idle"..math.random(1, 14)..".wav")
			
			end
		
		end
	
	end
	return "";
end
AddChatCommand( "/ztalk", ZombieRadio );
AddChatCommand( "/zombietalk", ZombieRadio );
AddChatCommand( "/z", ZombieRadio );

function BiotecRadio( ply, args )

	if( ply:Team() == 4 ) then
	
		for k, v in pairs( player.GetAll() ) do
		
			if( v:Team() == 4 ) then
			
				v:ChatPrint( ply:Nick() .. ": *Biotec* " .. args );
				v:PrintMessage( 2, ply:Nick() .. ": *Biotec* " .. args );
				v:EmitSound(Sound("npc/combine_soldier/vo/affirmative2.wav"))
			
			end
		
		end
	
	end
	return "";
end
AddChatCommand( "/btalk", BiotecRadio );
AddChatCommand( "/biotalk", BiotecRadio );
AddChatCommand( "/biotectalk", BiotecRadio );
AddChatCommand( "/b", BiotecRadio );

function MiliRadio( ply, args )

	if( ply:Team() == 9 ) then
	
		for k, v in pairs( player.GetAll() ) do
		
			if( v:Team() == 9 ) then
			
				v:ChatPrint( ply:Nick() .. ": *Military* " .. args );
				v:PrintMessage( 2, ply:Nick() .. ": *Military* " .. args );
				v:EmitSound(Sound("npc/combine_soldier/vo/affirmative2.wav"))
			
			end
		
		end
	
	end
	return "";
end
AddChatCommand( "/mtalk", MiliRadio );
AddChatCommand( "/militalk", MiliRadio );
AddChatCommand( "/militarytalk", MiliRadio );
AddChatCommand( "/m", MiliRadio );

function CombineRequest( ply, args )

	if( ply:Team() ~= 2 or ply:Team() ~= 9 ) then
	
		ply:ChatPrint( ply:Nick() .. ": (REQUEST!) " .. args );
		ply:PrintMessage( 2, ply:Nick() .. ": (REQUEST!) " .. args );
	
	end
	
	for k, v in pairs( player.GetAll() ) do
		
		if( v:Team() == 2 or v:Team() == 9 ) then
			
			v:ChatPrint( ply:Nick() .. ": (REQUEST!) " .. args );
			v:PrintMessage( 2, ply:Nick() .. ": (REQUEST!) " .. args );
			
		end
		
	end
	return "";
end
AddChatCommand( "/cr", CombineRequest );

function GM:PhysgunPickup( ply, ent )

	if( ent:IsPlayer() or ent:IsDoor() ) then return false; end

	local class = ent:GetClass();
	
	if( Admins[ply:SteamID()] ) then return true; end
	
	if( class ~= "func_physbox" and class ~= "prop_physics" and class ~= "prop_physics_multiplayer" and
		class ~= "prop_vehicle_prisoner_pod" ) then
		return false;
	end
	return true;
end

function GM:PlayerSpawnProp( ply, model )

	if( not self.BaseClass:PlayerSpawnProp( ply, model ) ) then return false; end
	
	local allowed = false;
	
	if( ply:GetTable().Arrested ) then return false; end
	if( ( CfgVars["allowedprops"] == 0 and CfgVars["banprops"] == 0 ) or Admins[ply:SteamID()] ) then allowed = true; end
	if not( CfgVars["propspawning"] == 1 or Admins[ply:SteamID()] or Prop[ply:SteamID()] ) then return false; end
	
	if( CfgVars["allowedprops"] == 1 ) then
	
		for k, v in pairs( AllowedProps ) do
		
			if( v == model ) then allowed = true; end
		
		end
		
	end
	
	if( CfgVars["banprops"] == 1 ) then
	
		for k, v in pairs( BannedProps ) do
		
			if( v == model ) then return false; end
		
		end
		
	end
	
	if( allowed ) then
	
		if( CfgVars["proppaying"] == 1 ) then
		
			if( ply:CanAfford( CfgVars["propcost"] ) ) then
			
				Notify( ply, 1, 4, "Deducted $" .. CfgVars["propcost"] );
				ply:AddMoney( -CfgVars["propcost"] );
				
				return true;
			
			else
			
				Notify( ply, 1, 4, "Need $" .. CfgVars["propcost"] );
				return false;
			
			end
		
		else
		
			return true;
		
		end
	
	end
		
	return true;

end

function GM:SetupMove( ply, move )

	if( ply == nil or not ply:Alive() ) then
		return;
	end
	
	if( ply:Crouching() ) then
		
		move:SetMaxClientSpeed( CfgVars["cspd"] );
		return;	
	
	end
	
	if( ply:GetTable().Arrested ) then
	
		move:SetMaxClientSpeed( CfgVars["aspd"] );
		return;	
	
	end
	
	if( ply:KeyDown( IN_SPEED ) ) then
		if( ply:Team() == 2 or Admins[ply:SteamID()] or ply:Team() == 9 ) then
			local faster = CfgVars["rspd"] + 8
			move:SetMaxClientSpeed( faster );
		else
			move:SetMaxClientSpeed( CfgVars["rspd"] );
		return;
		end
	elseif( ply:GetVelocity():Length() > 10 ) then
	
		move:SetMaxClientSpeed( CfgVars["wspd"] );
		return;	
	
	end
	

end


function GM:ShowSpare1( ply )

	umsg.Start( "ToggleClicker", ply ); umsg.End();

end

function GM:ShowSpare2( ply )
	
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 115 ) then
	
		if( trace.Entity:OwnedBy( ply ) ) then
			Notify( ply, 1, 4, "You've unowned this for $" .. CfgVars["doorcost"] * 0.66666666666666 .. "!" );
			trace.Entity:Fire( "unlock", "", 0 );
			trace.Entity:UnOwn( ply );
			ply:GetTable().Ownedz[trace.Entity:EntIndex()] = nil;
			ply:GetTable().OwnedNumz = ply:GetTable().OwnedNumz - 1;
			ply:AddMoney( CfgVars["doorcost"] * 0.66666666666666);
		else
			
			if( trace.Entity:IsOwned() and not trace.Entity:AllowedToOwn( ply ) ) then
			
				Notify( ply, 1, 3, "Already owned" );
				return;
			
			end
			if( trace.Entity:GetClass() == "prop_vehicle_jeep" or trace.Entity:GetClass() == "prop_vehicle_airboat" ) then
				if( not ply:CanAfford( CfgVars["vehiclecost"] ) ) then
						Notify( ply, 1, 4, "You cannot afford this vehicle!" );
					return;
				end
			else
				if( not ply:CanAfford( CfgVars["doorcost"] ) ) then
						Notify( ply, 1, 4, "You cannot afford this door!" );
					return;
				end
			end
			
			if(	trace.Entity:GetClass() == "prop_vehicle_jeep" or trace.Entity:GetClass() == "prop_vehicle_airboat" ) then
				ply:AddMoney( CfgVars["vehiclecost"] * -1 );
				Notify( ply, 1, 4, "You've owned this vehicle for $" .. CfgVars["vehiclecost"] .. "!" );
			else
				ply:AddMoney( CfgVars["doorcost"] * -1 );
				Notify( ply, 1, 4, "You've owned this door for $" .. CfgVars["doorcost"] .. "!" );
			end
			trace.Entity:Own( ply );
			
			if( ply:GetTable().OwnedNumz == 0 ) then
				timer.Create( ply:SteamID() .. "propertytax", 270, 0, ply.DoPropertyTax, ply );
			end
			
			ply:GetTable().OwnedNumz = ply:GetTable().OwnedNumz + 1;
			
			ply:GetTable().Ownedz[trace.Entity:EntIndex()] = trace.Entity;
			
		end
		
	end

end

function GM:OnNPCKilled( victim, ply, weapon )

	local repamount = 0;

	if not( ply:GetNWInt("salary") == 0 ) then
	repamount = ply:GetNWInt("salary")
	ply:AddMoney( repamount );
	Notify( ply, 1, 3, "Credits gained for killing an NPC!" );
	end

end


function GM:KeyPress( ply, code )

	self.BaseClass:KeyPress( ply, code );
	
	if( code == IN_USE ) then
	
		local trace = { }
	
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 95;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );

		if( tr.Entity:IsValid() and not ply:KeyDown( IN_ATTACK ) ) then
		
			if( tr.Entity:GetTable().Letter ) then
	
				umsg.Start( "ShowLetter", ply );
					umsg.Short( tr.Entity:GetNWInt( "type" ) );
					umsg.Vector( tr.Entity:GetPos() );
					umsg.String( tr.Entity:GetNWString( "content" ) );
				umsg.End();
			
			end

			if( tr.Entity:GetTable().MoneyBag ) then
	
				Notify( ply, 0, 4, "You found $" .. tr.Entity:GetTable().Amount .. "!" );
				ply:AddMoney( tr.Entity:GetTable().Amount );
				
				tr.Entity:Remove();
			
			end
		
		else
		
			umsg.Start( "KillLetter", ply ); umsg.End();
		
		end
	
	end

end
