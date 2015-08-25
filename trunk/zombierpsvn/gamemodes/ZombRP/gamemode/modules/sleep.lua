KnockoutTime = 5
 
function ResetKnockouts(player)
 
	player:SetNetworkedEntity("Ragdoll",NULL)
	player:SetNetworkedFloat("KnockoutTimer",0)

end
 
hook.Add("PlayerSpawn","Knockout",ResetKnockouts)
 
function KnockoutToggle(player,command,args,caller)
	if( player:Alive() ) then
		print(tostring(player:GetNetworkedBool("Knockedout")))
		if (player:GetNetworkedFloat("KnockoutTimer") + KnockoutTime < CurTime()) then
			if (player:GetNetworkedEntity("Ragdoll") != NULL) then
				local ragdoll = player:GetNetworkedEntity("Ragdoll")
				player:Spawn()
				player:SetPos(ragdoll:GetPos())
				player:SetAngles(Angle(0,ragdoll:GetPhysicsObjectNum(10):GetAngles().Yaw,0))
				player:UnSpectate()
				player:StripWeapons()
				player:ConCommand("pp_colormod 0")
				player:SetNWInt("slp",0)
				GAMEMODE:PlayerLoadout( player );
				ragdoll:Remove()
				player:SetNetworkedBool("Knockedout",false)
				player:SetNetworkedEntity("Ragdoll",NULL)
		else
				local ragdoll = ents.Create("prop_ragdoll")
				ragdoll:SetPos(player:GetPos())
				ragdoll:SetAngles(Angle(0,player:GetAngles().Yaw,0))
				ragdoll:SetModel(player:GetModel())
				ragdoll:Spawn()
				ragdoll:Activate()
				ragdoll:SetVelocity(player:GetVelocity())
				player:StripWeapons()
				player:Spectate(OBS_MODE_CHASE)
				player:SpectateEntity(ragdoll)
				player:ConCommand("pp_colormod 1")
				player:ConCommand("pp_colormod_brightness -1.0")
				player:SetNWInt("slp",1)
				player:SetNetworkedEntity("Ragdoll",ragdoll)
				player:SetNetworkedBool("Knockedout",true)
				player:SetNetworkedFloat("KnockoutTimer",CurTime())
				end
		end
		print(tostring(player:GetNetworkedBool("Knockedout")))
		return "";
	else
		Notify( player, 1, 4, "Sleep Disabled When You Are Dead." )
		return "";
	end
end
 
concommand.Add("-knockout_toggle",KnockoutToggle)
concommand.Add("+knockout_toggle",function() end) 

AddChatCommand( "/sleep", KnockoutToggle );