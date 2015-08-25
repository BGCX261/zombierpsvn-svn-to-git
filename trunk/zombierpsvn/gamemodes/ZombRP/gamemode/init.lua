-------------
-- LightRP
-- Rick Darkaliono aka DarkCybo1
-- Jan 22, 2007
-- Done Jan 26, 2007

-- This script isn't a representation of my skillz
-------------

-------------
-- DarkRP v1.07
-- By: Rickster
-- Done June 15, 2007
-------------
-- v2.0 and up
-- By: Pcwizdan / Silent Inferno
-- All credit goes to Rickster, v2.0 just a Fix/Cleanup Mod
-------------

----------------------------------------------------------------
--|Haha, nice and big. -----------------------------------------|
--|Rofl, well anyway. ------------------------------------------|
--|ZombieRP 3.1 ------------------------------------------------|
--|Edited DarkRP2.2 by Stingwraith -----------------------------|
--|Have fun raping zombies. ------------------------------------|
----------------------------------------------------------------

--also, check player.lua for customizable Survivor models.

DeriveGamemode( "sandbox" );

AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "cl_vgui.lua" );
AddCSLuaFile( "entity.lua" );
AddCSLuaFile( "cl_scoreboard.lua" );
AddCSLuaFile( "scoreboard/admin_buttons.lua" );
AddCSLuaFile( "scoreboard/player_frame.lua" );
AddCSLuaFile( "scoreboard/player_infocard.lua" );
AddCSLuaFile( "scoreboard/player_row.lua" );
AddCSLuaFile( "scoreboard/scoreboard.lua" );
AddCSLuaFile( "scoreboard/vote_button.lua" );
AddCSLuaFile( "cl_helpvgui.lua" );
AddCSLuaFile( "bugreport.lua" );
AddCSLuaFile( "nhm.lua" );
AddCSLuaFile( "CombineSounds.lua" );
AddCSLuaFile( "zomlike.lua" );

include( "help.lua" );
include( "player.lua" );
include( "shared.lua" );
include( "chat.lua" );
include( "rplol.lua" );
include( "rprofl.lua" );
include( "economy.lua" );
include( "util.lua" );
include( "votes.lua" );
include( "admins.lua" );
include( "admincc.lua" );
include( "entity.lua" );
include( "bannedprops.lua" );
include( "commands.lua" );
include( "nhm.lua" );
include( "CombineSounds.lua" );
include( "zomlike.lua" );


AddHelpCategory( HELP_CATEGORY_CHATCMD, "Chat Commands" );
AddHelpCategory( HELP_CATEGORY_CONCMD, "Console Commands" );
AddHelpCategory( HELP_CATEGORY_ADMINTOGGLE, "Admin Toggle Commands (1 or 0!)" );
AddHelpCategory( HELP_CATEGORY_ADMINCMD, "Admin Console Commands" );

CSFiles = { }

LRP = { }
CfgVars = { }

function includeCS( dir )

	AddCSLuaFile( dir );
	table.insert( CSFiles, dir );

end

local files = file.Find( "../gamemodes/ZombRP/gamemode/modules/*.lua" );
for k, v in pairs( files ) do

	include( "modules/" .. v );

end

----------------------------------------------------------
--Resources (Feel free to add stuff.)
----------------------------------------------------------
--models
resource.AddFile( "models/weapons/v_zombiearms.mdl" );
resource.AddFile( "models/weapons/v_zombiearms.dx80.vtx" );
resource.AddFile( "models/weapons/v_zombiearms.dx90.vtx" );
resource.AddFile( "models/weapons/v_zombiearms.sw.vtx" );
resource.AddFile( "models/weapons/v_zombiearms.vvd" );
--materials
resource.AddFile( "materials/models/weapons/v_zombiearms/Zombie_Classic_sheet.vtf" );
resource.AddFile( "materials/models/weapons/v_zombiearms/Zombie_Classic_sheet.vmt" );
resource.AddFile( "materials/models/weapons/v_zombiearms/Zombie_Classic_sheet_normal.vtf" );
----------------------------------------------------------
--Thats all for resources.
----------------------------------------------------------
----------------------------------------------------------
--Sound Precaching. Add stuff if you need to.
util.PrecacheSound("vo/npc/male01/ow01.wav")
	
util.PrecacheSound("vo/npc/male01/ow02.wav")
	
util.PrecacheSound("vo/npc/male01/pain01.wav")
	
util.PrecacheSound("vo/npc/male01/pain02.wav")
	
util.PrecacheSound("vo/npc/male01/pain03.wav")
	
util.PrecacheSound("vo/npc/male01/pain04.wav")
	
util.PrecacheSound("vo/npc/male01/pain05.wav")
	
util.PrecacheSound("vo/npc/male01/pain06.wav")
	
util.PrecacheSound("vo/npc/male01/pain07.wav")
	
util.PrecacheSound("vo/npc/male01/pain08.wav")
	
util.PrecacheSound("vo/npc/male01/pain09.wav")
	
----------------------------------------------------------
----------------------------------------------------------
--These are the recommended settings for ZombieRP.
--If you change them, do note you are altering the Roleplay experience.
----------------------------------------------------------


-- 1 or 0
-- 1 FOR YES
-- 0 FOR NO

CfgVars["adrenalinefx"] = 1; --set this to 0 if you dont want the Adrenaline effects

CfgVars["ooc"] = 1; --No shit sherlock
CfgVars["alltalk"] = 0; --Don't touch this either
CfgVars["crosshair"] = 0; --Should leave this off, unless you want DM'ing minges.
CfgVars["maxmayor"] = 1; --Maximum amount of Mayors you can have (should be 1)
CfgVars["maxcps"] = 4; --Max number of Police you can have (4 is recommended)
CfgVars["maxzombs"] = 10; --Do not change, will ruin the gamemode if you do.
CfgVars["strictsuicide"] = 1; --Dont touch this
CfgVars["propertytax"] = 0; --No touchy
CfgVars["cit_propertytax"] = 0; --No touchy
CfgVars["paydelay"] = 300; --5 minute cred/ammo delay (rations, and are needed.)
CfgVars["banprops"] = 1; --Prop banning
CfgVars["toolgun"] = 1; --Tool gun enabled?
CfgVars["allowedprops"] = 0; --Should players be only able to spawn "allowed" props?
CfgVars["propspawning"] = 1; --Prop spawning enabled?
CfgVars["adminsents"] = 1; --No touchy.
CfgVars["adminsweps"] = 1; --No touchy.
CfgVars["cpvote"] = 1; --Should set this to '1' if your running this on a Dedicated
CfgVars["mayorvote"] = 1; --Should set this to '1' if your running this on a Dedicated
CfgVars["enforceplayermodel"] = 1; --Do not touch
CfgVars["proppaying"] = 1; --Makes it better if they do.
CfgVars["propcost"] = 10; --Prop cost (You choose.)
CfgVars["letters"] = 1; --Allow letter writing
CfgVars["cpvoting"] = 1; --Allow CP voting(stated above)
CfgVars["mayorvoting"] = 1; --Allow Mayor voting(stated above)
CfgVars["cptomayoronly"] = 0; --Only CPs can do /votemayor
CfgVars["physgun"] = 1; --Physguns for everybody? 0 = Admins only. Should set to '0' for Dedi
CfgVars["netplay"] = 0; --NetPlay, Have fun with MySquid! (lolwtf is netplay)
CfgVars["teletojail"] = 1; --Should Criminals Be AUTOMATICALLY Teleported TO jail?
CfgVars["telefromjail"] = 1; --Should Jailed People be automatically Teleported FROM jail?
CfgVars["aspd"] = 210; --Arrested speed
CfgVars["cspd"] = 140; --Crouch Speed
CfgVars["rspd"] = 220; --Run Speed
CfgVars["wspd"] = 160; --Walk Speed
CfgVars["zrspd"] = 180; --Zombie Run Speed
CfgVars["zwspd"] = 120; --Zombie Walk Speed
CfgVars["doorcost"] = 30; --Cost to buy a door.
CfgVars["vehiclecost"] = 40; --Car/Airboat Cost
CfgVars["normalsal"] = 5;
CfgVars["refvar"] = 0;
CfgVars["zomdelay"] = 1; --Will break the gamemode if you change.

----[Weapon Costs]----
--pistols--
SetGlobalInt("deaglecost", 460) --45 cal Pistol
SetGlobalInt("sdeaglecost", 520) --silenced 45 cal Pistol
SetGlobalInt("56mmcost", 305) --56mm pistol
SetGlobalInt("9mmcost", 310) --9mm pistol
SetGlobalInt("s9mmcost", 340) --silenced 9mm
SetGlobalInt("revolvercost", 510) --revolver
SetGlobalInt("autopistolcost", 360) --Automatic Pistol (really not too good)
--automatic weapons--
SetGlobalInt("arifcost", 2200) --Automatic Rifle
SetGlobalInt("smgcost", 1500) --Sub Machine Gun
SetGlobalInt("lafcost", 1600) --Light Assault Rifle
SetGlobalInt("p90cost", 1800) --P90
SetGlobalInt("uzicost", 1500) --Uzi
SetGlobalInt("suzicost", 1800) --Silenced Uzi
--shotguns/rifles--
SetGlobalInt("shotguncost", 1750) --Shotgun
SetGlobalInt("hriflecost", 420) --Hunting Rifle
SetGlobalInt("slugriflecost", 460) --Slug Rifle
--snipers--
SetGlobalInt("30calcost", 4000) --30 cal sniper
SetGlobalInt("50calcost", 6000) --50 cal sniper

----[Other]----
--Misc Stuff--
SetGlobalInt("druglabcost", 410)
SetGlobalInt("gunlabcost", 500)
SetGlobalInt("microwavecost", 420)
SetGlobalInt("drugpayamount", 15)
--Ammo and health--
SetGlobalInt("ammopistolcost", 30)
SetGlobalInt("ammoriflecost", 60)
SetGlobalInt("ammoshotguncost", 70)
SetGlobalInt("healthcost", 60)
--food--
SetGlobalInt("microwavefood", 30)
--jail time--
SetGlobalInt("jailtimer", 120)
--salaries--
SetGlobalInt("maxcopsalary", 100)
SetGlobalInt("maxnormsalary", 80)

--This one doesnt really exist, but for some reason has to be here.
SetGlobalInt("glockcost", 280) --NON EXISTANT!

--No touchey
CfgVars["maxdruglabs"] = 1
CfgVars["maxMicrowaves"] = 1
CfgVars["maxgunlabs"] = 1
CfgVars["maxgangsters"] = 3
CfgVars["maxmedics"] = 3
CfgVars["maxgundealers"] = 1
CfgVars["maxcooks"] = 2
CfgVars["allowgang"] = 1
CfgVars["allowmedics"] = 1
CfgVars["allowdealers"] = 1
CfgVars["allowcooks"] = 1
CfgVars["allowzombs"] = 1 --CHANGE THIS AND EVERYTHING BREAKS! DO NOT CHANGE!!!
CfgVars["customspawns"] = 1

SetGlobalInt( "nametag", 1 )
SetGlobalInt( "jobtag", 1 )
SetGlobalInt( "globalshow", 0 )
SetGlobalString( "cmdprefix", "/" ); --Prefix before any chat commands

---------------------------------------------------
--And everything below here should be disregarded.
---------------------------------------------------

if( not file.IsDir( "ZombRP/" ) ) then

	file.CreateDir( "ZomRP" );

end

if( not file.IsDir( "ZombRP/privilege/" ) ) then

	file.CreateDir( "ZombRP/privilege" );

end

if( not file.IsDir( "ZombRP/Spawns/" ) ) then

	file.CreateDir( "ZombRP/Spawns" );

end

if( not file.IsDir( "ZombRP/Spawns/npc/" ) ) then

	file.CreateDir( "ZombRP/Spawns/npc" );

end

if( not file.IsDir( "ZombRP/salary/" ) ) then

	file.CreateDir( "ZombRP/salary" );

end

if( not file.IsDir( "ZombRP/temp/" ) ) then

	file.CreateDir( "ZombRP/temp" );

end

if( not file.IsDir( "ZombRP/temp/jail/" ) ) then

	file.CreateDir( "ZombRP/temp/jail" );

end

if( not file.IsDir( "ZombRP/temp/budgets/" ) ) then

	file.CreateDir( "ZombRP/temp/budgets" );

end

if( not file.IsDir( "ZombRP/wallet/" ) ) then

	file.CreateDir( "ZombRP/wallet" );

end

if( not file.Exists( "ZombRP/WHAT_YOU_CAN_DO_IN_THIS_FOLDER.txt" ) ) then

	local str = [[
	In this folder, you can create a file named servercfg.txt. 
	
	You can put in RP admin console commands in this file, and they'll be executed whenever the server starts.  
	Meaning you don't have to edit the script to change the default cvars!
	
	Example content of what can be in servercfg.txt:
	
	rp_chatprefix ! --Only if you need to use ! to use the chat commands.
	rp_propertytax 1
	rp_citpropertytax 1
	rp_toolgun 0
	rp_letters 0
	]]
	
	file.Write( "ZombRP/WHAT_YOU_CAN_DO_IN_THIS_FOLDER.txt" , str );

end

if( file.Exists( "ZombRP/servercfg.txt" ) ) then

	local cmds = string.Explode( "\n", file.Read( "ZombRP/servercfg.txt" ) );

	for k, v in pairs( cmds ) do

		game.ConsoleCommand( v .. "\n" );
		
	end
end

GenerateChatCommandHelp();

function GM:Initialize()
	self.BaseClass:Initialize();
	createJailPos()
	setJailPos()
	createspawnPos()
	initspawnPos()
end

for k, v in pairs( player.GetAll() ) do

	v:NewData();
	v:SetNetworkedBool("helpMenu",false)
	getMoney(ply);
end

AddHelpLabel( -1, HELP_CATEGORY_CONCMD, "gm_showhelp - Toggle help menu (bind this to F1 if you haven't already)" );
AddHelpLabel( -1, HELP_CATEGORY_CONCMD, "serverHelp - Show's server help." );
AddHelpLabel( -1, HELP_CATEGORY_CONCMD, "gm_showspare1 - Toggle vote clicker (bind this to F3 if you haven't already)" );
AddHelpLabel( -1, HELP_CATEGORY_CONCMD, "gm_showspare2 - Own/unown doors (bind this to F4 if you haven't already)" );

function ShowSpare1( ply )

	ply:ConCommand( "gm_showspare1\n" );

end
concommand.Add( "gm_spare1", ShowSpare1 );
 
function serverHelp( player ) 
 
	if(player:GetNetworkedBool("helpMenu") == false) then
		player:SetNetworkedBool("helpMenu",true)
	else
		player:SetNetworkedBool("helpMenu",false)
	end
 
end    
concommand.Add( "serverHelp", serverHelp ) 

 function GM:ShowTeam( ply )
 
	ply:ConCommand( "serverHelp\n" );
 
 end

function ShowSpare2( ply )

	ply:ConCommand( "gm_showspare2\n" );

end
concommand.Add( "gm_spare2", ShowSpare2 );

function GM:ShowHelp( ply )

	umsg.Start( "ToggleHelp", ply ); umsg.End();

end

GM.Name = "ZombieRP 3.4";
GM.Author = "Original: Rickster | Updated: Pcwizdan | Zombified: Stingwraith";
