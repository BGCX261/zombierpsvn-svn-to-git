
//Credits to Mahalis for making it and me Warrior xXx (or kevkev on Facepunch) for adding console command and adding the NPC's from EP1 and EP2

playerfactions = true

function DoRespawn(ply)
	ply:SetVar("faction",nil)
end

hook.Add("PlayerSpawn","nhmSpawnHook",DoRespawn)

function DoMove(ply,move)
    if playerfactions == true then
	    if ply:GetVar("faction") == nil then
	    	mdl = string.sub(ply:GetModel(),15,-5)
		    local fact = ""
		    if mdl=="police" || mdl == "combine_soldier" || mdl == "combine_soldier_prisionguard" || mdl == "combine_super_soldier" || mdl == "breen" then
			    fact = "f_combine"
		    elseif mdl == "alyx" || mdl == "barney" || mdl == "eli" || mdl == "female_04" || mdl == "female_06" || mdl == "female_07" || mdl == "gman_high" || mdl == "Kleiner" || mdl == "male_02" || mdl == "male_03" || mdl == "male_08" || mdl == "monk" || mdl == "mossman" || mdl == "odessa" then
			    fact = "f_human"
		    elseif mdl == "corpse1" || mdl == "charple01" || mdl == "classic" then
			    fact = "f_zombie"
		    end
		    ply:SetVar("faction",fact)
		    ply:SetName(fact)
	    end
	end
end

hook.Add("SetupMove","nhmMoveHook",DoMove)

function SpawnedNPC(ply,npc)
    if playerfactions == true then
	    cl = npc:GetClass()
	    if cl == "npc_metropolice" || cl == "npc_combine_s" || cl == "npc_manhack" || cl == "npc_scanner" || cl == "combine_mine" || cl == "npc_combinegunship" || cl == "npc_combinedropship" || cl == "npc_combinedropship" || cl == "npc_strider" || cl == "npc_rollermine" || cl == "npc_cscanner" || cl == "npc_turret_floor" || cl == "npc_helicopter" || cl == "npc_sniper" || cl == "npc_turret_ceiling" || cl == "npc_turret_ground" || cl == "npc_combine_camera" || cl == "npc_breen" || cl == "npc_hunter" || cl == "npc_clawscanner" then
		    npc:Fire("setrelationship","f_human d_ht 99",0)
		    npc:Fire("setrelationship","f_zombie d_ht 98",0)
		    npc:Fire("setrelationship","f_combine d_li 97",0)
	    elseif cl == "npc_alyx" || cl == "npc_kleiner" || cl == "npc_eli" || cl == "npc_barney" || cl == "npc_citizen" || cl == "npc_mossman" || cl == "npc_monk" || cl == "npc_vortiguant" || cl == "npc_dog" || cl == "npc_fisherman" || cl == "npc_kleiner" || cl == "npc_magnusson" then
		    npc:Fire("setrelationship","f_combine d_ht 99",0)
		    npc:Fire("setrelationship","f_zombie d_ht 98",0)
		    npc:Fire("setrelationship","f_human d_li 97",0)
	    elseif cl == "npc_zombie" || cl == "npc_fastzombie" || cl == "npc_poisonzombie" || cl == "npc_zombie_torso" || cl == "npc_fastzombie_torso" || cl == "npc_headcrab" || cl == "npc_headcrab_fast" || cl == "npc_headcrab_black" || cl == "npc_zombine" then
		    npc:Fire("setrelationship","f_combine d_ht 99",0)
		    npc:Fire("setrelationship","f_human d_ht 98",0)
		    npc:Fire("setrelationship","f_zombie d_li 97",0)
	    end
	end
end

hook.Add("PlayerSpawnedNPC","nhmNPCHook",SpawnedNPC)

function PlayerFactions_toggle()
	if playerfactions == false then
	    playerfactions = true
		Msg("Player Factions Enabled\n") 
	elseif playerfactions == true then
	    playerfactions = false
		Msg("Player Factions Disabled\n") 
	end
end
concommand.Add( "rp_npcfaction", PlayerFactions_toggle ) 