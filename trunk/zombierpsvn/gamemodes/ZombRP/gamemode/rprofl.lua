--It's not safe to edit this file.

function getSalary(player)
local IDSteam = string.gsub(player:SteamID(), ":", "")
	if not file.Exists("ZombRP/salary/" .. IDSteam .. ".txt") then   
		file.Write( "ZombRP/salary/" .. IDSteam .. ".txt", CfgVars["normalsal"] )
	end

local salary = file.Read("ZombRP/salary/" .. IDSteam .. ".txt")
player:SetNWInt( "salary", salary );
end

function rpsetSalary(target, amount)
local IDSteam = string.gsub(target:SteamID(), ":", "")

file.Write( "ZombRP/salary/" .. IDSteam .. ".txt", amount )
target:SetNWInt( "salary", amount )
end

function jobsetsalary(ply, amount)
ply:SetNWInt( "salary", amount )
end

function setMoney(player, amount)
local IDSteam = string.gsub(player:SteamID(), ":", "")
local contents = file.Read("ZombRP/wallet/" .. IDSteam .. ".txt")
local newAmount = contents + amount

file.Write( "ZombRP/wallet/" .. IDSteam .. ".txt", newAmount )
end

function rpsetmoney(target, amount)
local IDSteam = string.gsub(target:SteamID(), ":", "")

file.Write( "ZombRP/wallet/" .. IDSteam .. ".txt", amount )
showMoney(target, amount)
end

function showMoney(player, newAmount)
	player:SetNWInt("money", newAmount);
end

function getMoney(player)
local IDSteam = string.gsub(player:SteamID(), ":", "")

	if not file.Exists("ZombRP/wallet/" .. IDSteam .. ".txt") then
		file.Write( "ZombRP/wallet/" .. IDSteam .. ".txt","500" )
	end
	
local contents = file.Read("ZombRP/wallet/" .. IDSteam .. ".txt")
showMoney(player, contents)
end

function spawnPos( ply, args )
	if( Admins[ply:SteamID()] ) then
		if( args == "citizen" ) then
			local citizenPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_citizen.txt",tostring(citizenPos) )
			Notify( ply, 1, 4,  "Citizen Spawn Position set." );
		elseif( args == "police" ) then
			local policePos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_police.txt",tostring(policePos) )
			Notify( ply, 1, 4,  "Police Spawn Position set." );
		elseif( args == "mayor" ) then
			local mayorPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_mayor.txt",tostring(mayorPos) )
			Notify( ply, 1, 4,  "Mayor Spawn Position set." );
		elseif( args == "gangster" ) then
			local gangsterPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_gangster.txt",tostring(gangsterPos) )
			Notify( ply, 1, 4,  "Biotec Spawn Position set." );
		elseif( args == "mobboss" ) then
			local mobbossPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_mobboss.txt",tostring(mobbossPos) )
			Notify( ply, 1, 4,  "Mob Boss Spawn Position set." );
		elseif( args == "gundealer" ) then
			local gundealPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_gundealer.txt",tostring(gundealPos) )
			Notify( ply, 1, 4,  "Gun Dealer Spawn Position set." );
		elseif( args == "medic" ) then
			local medicPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_medic.txt",tostring(medicPos) )
			Notify( ply, 1, 4,  "Medic Spawn Position set." );
		elseif( args == "cook" ) then
			local cookPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_cook.txt",tostring(cookPos) )
			Notify( ply, 1, 4,  "Cook Spawn Position set." );
		elseif( args == "chief" ) then
			local chiefPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_chief.txt",tostring(chiefPos) )
			Notify( ply, 1, 4,  "Chief Spawn Position set." );
		elseif( args == "zombie" ) then
			local chiefPos = ply:GetPos()
			file.Write( "ZombRP/Spawns/" .. game.GetMap() .. "_zombie.txt",tostring(zombiePos) )
			Notify( ply, 1, 4,  "Zombie Spawn Position set." );
		else
			Notify( ply, 1, 4,  "That is not an available Team." );
		end
		return "";
	end
	return "";
end
AddChatCommand( "/setspawn", spawnPos );

function setspawnPos( ply )
	if( CfgVars["customspawns"] == 1 ) then
		if( ply:Team() == 1 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_citizen.txt") then   
				local tempcitizenPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_citizen.txt")
				tempcitizenPos = (string.Explode(" " ,tempcitizenPos))
				ply:SetPos(Vector(tonumber(tempcitizenPos[1]),tonumber(tempcitizenPos[2]),tonumber(tempcitizenPos[3])))
			end
			return "";
		elseif( ply:Team() == 2 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_police.txt") then   
				local temppolicePos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_police.txt")
				temppolicePos = (string.Explode(" " ,temppolicePos))
				ply:SetPos(Vector(tonumber(temppolicePos[1]),tonumber(temppolicePos[2]),tonumber(temppolicePos[3])))
			end
			return "";
		elseif( ply:Team() == 3 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_mayor.txt") then   
				local tempmayorPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_mayor.txt")
				tempmayorPos = (string.Explode(" " ,tempmayorPos))
				ply:SetPos(Vector(tonumber(tempmayorPos[1]),tonumber(tempmayorPos[2]),tonumber(tempmayorPos[3])))
			end
			return "";
		elseif( ply:Team() == 4 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_gangster.txt") then   
				local tempgangsterPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_gangster.txt")
				tempgangsterPos = (string.Explode(" " ,tempgangsterPos))
				ply:SetPos(Vector(tonumber(tempgangsterPos[1]),tonumber(tempgangsterPos[2]),tonumber(tempgangsterPos[3])))
			end
			return "";
		elseif( ply:Team() == 5 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_mobboss.txt") then   
				local tempmobbossPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_mobboss.txt")
				tempmobbossPos = (string.Explode(" " ,tempmobbossPos))
				ply:SetPos(Vector(tonumber(tempmobbossPos[1]),tonumber(tempmobbossPos[2]),tonumber(tempmobbossPos[3])))
			end
			return "";
		elseif( ply:Team() == 6 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_gundealer.txt") then   
				local tempgundealerPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_gundealer.txt")
				tempgundealerPos = (string.Explode(" " ,tempgundealerPos))
				ply:SetPos(Vector(tonumber(tempgundealerPos[1]),tonumber(tempgundealerPos[2]),tonumber(tempgundealerPos[3])))
			end
			return "";
		elseif( ply:Team() == 7 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_medic.txt") then   
				local tempmedicPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_medic.txt")
				tempmedicPos = (string.Explode(" " ,tempmedicPos))
				ply:SetPos(Vector(tonumber(tempmedicPos[1]),tonumber(tempmedicPos[2]),tonumber(tempmedicPos[3])))
			end
			return "";
		elseif( ply:Team() == 8 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_cook.txt") then   
				local tempcookPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_cook.txt")
				tempcookPos = (string.Explode(" " ,tempcookPos))
				ply:SetPos(Vector(tonumber(tempcookPos[1]),tonumber(tempcookPos[2]),tonumber(tempcookPos[3])))
			end
		elseif( ply:Team() == 10 ) then
			if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_zombie.txt") then   
				local tempzombiePos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_zombie.txt")
				tempzombiePos = (string.Explode(" " ,tempzombiePos))
				ply:SetPos(Vector(tonumber(tempzombiePos[1]),tonumber(tempzombiePos[2]),tonumber(tempzombiePos[3])))
			end
			return "";
		end
		return "";
	end
	return "";
end

function initspawnPos()
	if( CfgVars["customspawns"] == 1 ) then
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_citizen.txt") then   
			local tempcitizenPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_citizen.txt")
			tempcitizenPos = (string.Explode(" " ,tempcitizenPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_police.txt") then   
			local temppolicePos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_police.txt")
			temppolicePos = (string.Explode(" " ,temppolicePos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_mayor.txt") then   
			local tempmayorPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_mayor.txt")
			tempmayorPos = (string.Explode(" " ,tempmayorPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_gangster.txt") then   
			local tempgangsterPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_gangster.txt")
			tempgangsterPos = (string.Explode(" " ,tempgangsterPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_mobboss.txt") then   
			local tempmobbossPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_mobboss.txt")
			tempmobbossPos = (string.Explode(" " ,tempmobbossPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_gundealer.txt") then   
			local tempgundealerPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_gundealer.txt")
			tempgundealerPos = (string.Explode(" " ,tempgundealerPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_medic.txt") then   
			local tempmedicPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_medic.txt")
			tempmedicPos = (string.Explode(" " ,tempmedicPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_cook.txt") then   
			local tempcookPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_cook.txt")
			tempcookPos = (string.Explode(" " ,tempcookPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_chief.txt") then   
			local tempcookPos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_chief.txt")
			tempchiefPos = (string.Explode(" " ,tempchiefPos))
		end
		if file.Exists("ZombRP/Spawns/" .. game.GetMap() .. "_zombie.txt") then   
			local tempzombiePos = file.Read("ZombRP/Spawns/" .. game.GetMap() .. "_zombie.txt")
			tempzombiePos = (string.Explode(" " ,tempzombiePos))
		end
	end
	return "";
end

function createspawnPos()
	if not( file.Exists( "ZombRP/Spawns/rp_hometown2000_police.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_hometown2000_police.txt", "-548.1580 1445.1908 0.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_hometown2000_mayor.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_hometown2000_mayor.txt", "514.3461 -562.3296 520.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_hometown2000_gundealer.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_hometown2000_gundealer.txt", "164.7026 -442.4947 0.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_hometown2000_cook.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_hometown2000_cook.txt", "309.3052 490.3089 0.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_hometown2000_medic.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_hometown2000_medic.txt", "1353.2319 1461.4639 0.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_citizen.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_citizen.txt", "2032.3468 -8547.3477 0.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_police.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_police.txt", "2744.3958 -8635.9121 8.0313")
	end

	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_mayor.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_mayor.txt", "2800.3171 -8932.0430 0.0313")
	end

	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_gangster.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_gangster.txt", "2140.9670 -8256.4404 0.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_mobboss.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_mobboss.txt", "1600.5671 -8790.8174 0.0313")
	end

	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_medic.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_medic.txt", "2800.3171 -8932.0430 0.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_cook.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_cook.txt", "1846.3209 -9462.4131 8.0313")
	end
	
	if not( file.Exists( "ZombRP/Spawns/rp_cscdesert_v2-1_gundealer.txt" ) ) then
		file.Write( "ZombRP/Spawns/rp_cscdesert_v2-1_gundealer.txt", "2169.7620 -9353.6826 0.0313")
	end
end

function foodHeal( ply )
	if( GetGlobalInt( "hungermod" ) == 0 ) then
		ply:SetHealth(ply:Health() + (100 - ply:Health()))
	else
		ply:SetNWInt( "Energy", math.Clamp( ply:GetNWInt( "Energy" ) + 100, 0, 100 ) );
        umsg.Start( "AteFoodIcon" ); umsg.End();
		end
	return "";
end

function lockdown( ply )
	if( GetGlobalInt("lstat") ~= 1 ) then
		if( ply:Team() == 3 or Admins[ply:SteamID()] ) then
			for k,v in pairs(player.GetAll()) do
				v:ConCommand("play npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav\n");
			end
			SetGlobalInt("lstat", 1)
			PrintMessageAll( HUD_PRINTTALK , "Quarantine In Progress, Stay indoors." )
			NotifyAll( 4, 3, ply:Nick() .. " Has Initiated a Quarantine, Stay indoors." );
			return "";
		end
		return "";
	end
	return "";
end	
concommand.Add( "rp_lockdown", lockdown );
AddChatCommand( "/lockdown", lockdown );

function unlockdown( ply )
	if( GetGlobalInt("lstat") == 1 and GetGlobalInt("ulstat") == 0) then
		if( ply:Team() == 3 or Admins[ply:SteamID()] ) then
			PrintMessageAll( HUD_PRINTTALK , "Quarantine has ended." )
			NotifyAll( 4, 3, ply:Nick() .. " Has ended the Quarantine." );
			SetGlobalInt("ulstat", 1)
			timer.Create("spamlock", 20, 1, waitlock, "")
		end
		return "";
	end
	return "";
end	
concommand.Add( "rp_unlockdown", unlockdown );
AddChatCommand( "/unlockdown", unlockdown );

function waitlock()
SetGlobalInt("ulstat", 0)
SetGlobalInt("lstat", 0)
timer.Destroy("spamlock")
end

function setcpbudget( amount )
file.Write( "ZombRP/temp/budgets/cpbudget.txt", amount )
end

function jailadd( target, length )
local IDSteam = string.gsub(target:SteamID(), ":", "")

file.Write( "ZombRP/temp/jail/" .. IDSteam .. ".txt", length )
end

function jailremove( target )
local IDSteam = string.gsub(target:SteamID(), ":", "")

file.Delete( "ZombRP/temp/jail/" .. IDSteam .. ".txt" )
end

function punish( ply )
local IDSteam = string.gsub(ply:SteamID(), ":", "")
	if not( file.Exists( "ZombRP/temp/jail/" .. IDSteam .. ".txt" ) ) then 
		return "";
	else
		local uwillpay = file.Read( "ZombRP/temp/jail/" .. IDSteam .. ".txt" )
		ply:SetNWInt( "jailtime", uwillpay )
		ply:Arrest();
		Notify( ply, 0, 5, "Punishment!: Jailed For: " .. uwillpay .. " Seconds." )
		return "";
	end
end

function refvar( ply )
	if( CfgVars["refvar"] ~= 1 ) then
		SetGlobalInt("ak47cost", 2200)
		SetGlobalInt("mp5cost", 1500)
		SetGlobalInt("m16cost", 1600)
		SetGlobalInt("mac10cost", 1500)
		SetGlobalInt("shotguncost", 1750)
		SetGlobalInt("snipercost", 4000)
		SetGlobalInt("deaglecost", 460)
		SetGlobalInt("fivesevencost", 300)
		SetGlobalInt("glockcost", 280)
		SetGlobalInt("p228cost", 300)
		SetGlobalInt("druglabcost", 400)
		SetGlobalInt("gunlabcost", 500)
		SetGlobalInt("microwavecost", 400)
		SetGlobalInt("drugpayamount", 15)
		SetGlobalInt("ammopistolcost", 30)
		SetGlobalInt("ammoriflecost", 60)
		SetGlobalInt("ammoshotguncost", 70)
		SetGlobalInt("healthcost", 60)
		SetGlobalInt("jailtimer", 120)
		SetGlobalInt("microwavefoodcost", 30)
		SetGlobalInt("maxsalary", 150)
		SetGlobalInt("mayorsetsalary", 120)
		SetGlobalInt("maxcopsalary", 100)
		SetGlobalInt("maxnormsalary", 80)
		SetGlobalInt("maxdrugfood", 2)
		SetGlobalInt( "nametag", 1 )
		SetGlobalInt( "jobtag", 1 )
		SetGlobalInt( "globalshow", 0 )
		
	end
	CfgVars["refvar"] = 1
	timer.Simple( 30, refwait, ply)
end


function verifyv( ply )
	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then
		ply:PrintMessage( 2, "Must Be an admin To Refresh Variables" );
		return;
	else
		local nick = "";
		if( ply:EntIndex() == 0 ) then
			nick = "Console";
		else
			nick = ply:Nick();
		end
		NotifyAll( 0, 6, nick .. " refreshed The GlobalInt's!" );
		refvar( ply );
	end
end
concommand.Add( "refresh_int", verifyv );

function refwait( ply )
	CfgVars["refvar"] = 0
end