--Don't touch this. It preserves that player zombies won't be attacked by Headcrabs
--and NPC zombies.
function ActivateZomLike(ply)
		DoZomLike(ply, true)
end

function DisableZomLike(ply)
		DoZomLike(ply, false)
end

function ZomInvisibility(ply, onoff)
	if onoff then
		ply:Fire("addoutput","targetname CloakedForZoms",0) 

		ZomInvisibility2("npc_zombie", true)
		ZomInvisibility2("npc_fastzombie", true)
		ZomInvisibility2("npc_fastzombie_torso", true)
		ZomInvisibility2("npc_headcrab", true)
		ZomInvisibility2("npc_headcrab_black", true)
		ZomInvisibility2("npc_headcrab_poison", true)
		ZomInvisibility2("npc_headcrab_fast", true)
		ZomInvisibility2("npc_poisonzombie", true)
		ZomInvisibility2("npc_zombie_torso", true)
		ZomInvisibility2("npc_zombine", true)

	else
		ply:Fire("addoutput","targetname ZomsCanSee",0) 

		ZomInvisibility2("npc_zombie", false)
		ZomInvisibility2("npc_fastzombie", false)
		ZomInvisibility2("npc_fastzombie_torso", false)
		ZomInvisibility2("npc_headcrab", false)
		ZomInvisibility2("npc_headcrab_black", false)
		ZomInvisibility2("npc_headcrab_poison", false)
		ZomInvisibility2("npc_headcrab_fast", false)
		ZomInvisibility2("npc_poisonzombie", false)
		ZomInvisibility2("npc_zombie_torso", false)
		ZomInvisibility2("npc_zombine", false)
	end
end

function ZomInvisibility2(class, onoff)
	if onoff then
		for _, npc in pairs(ents.FindByClass(class)) do
			npc:Fire("setrelationship","CloakedForZoms D_LI 99",0) 
		end
	else
		for _, npc in pairs(ents.FindByClass(class)) do
			npc:Fire("setrelationship","ZomsCanSee D_HT 99",0) 
		end
	end
end

function DoZomLike(ply, state)
	if state then
		ZomInvisibility(ply, true)
	else
		ZomInvisibility(ply, false)
	end

end
concommand.Add( "cl_zomoff", ActivateZomLike )
concommand.Add( "cl_zomon", DisableZomLike )