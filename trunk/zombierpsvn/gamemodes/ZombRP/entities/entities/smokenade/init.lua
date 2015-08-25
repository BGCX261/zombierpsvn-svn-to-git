
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self.Entity:SetModel( "models/Items/grenadeAmmo.mdl" )
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
    self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   
    self.Entity:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	util.PrecacheSound( "Town.d1_town_01_ball_zap1" )
	
	self.Timer = CurTime() + 5
	self.Timer2 = self.Timer + 5
	
	self.explode = true
	
	local Smoke = ents.Create("env_smoketrail")
			
	Smoke:SetKeyValue("opacity", 1)
	Smoke:SetKeyValue("spawnrate", 25)
	Smoke:SetKeyValue("lifetime", 2)
	Smoke:SetKeyValue("startcolor", "100 100 100")
	Smoke:SetKeyValue("endcolor", "125 125 125")
	Smoke:SetKeyValue("minspeed", 15)
	Smoke:SetKeyValue("maxspeed", 30)
	Smoke:SetKeyValue("startsize", 50)
	Smoke:SetKeyValue("endsize", 100)
	Smoke:SetKeyValue("spawnradius", 10)
	Smoke:SetKeyValue("emittime", 300)
	Smoke:SetKeyValue("firesprite", "sprites/firetrail.spr")
	Smoke:SetKeyValue("smokesprite", "sprites/whitepuff.spr")
	Smoke:SetPos(self:GetPos())
	Smoke:SetParent(self)
	Smoke:Spawn()
	Smoke:Activate()

end


/*---------------------------------------------------------
   Name: Think
---------------------------------------------------------*/
function ENT:Think()
	if(self.Timer < CurTime()) then
		self.explode = false
		local Smoke2 = ents.Create("env_smoketrail")
			
		Smoke2:SetKeyValue("opacity", 1)
		Smoke2:SetKeyValue("spawnrate", 100)
		Smoke2:SetKeyValue("lifetime", 10)
		Smoke2:SetKeyValue("startcolor", "100 100 100")
		Smoke2:SetKeyValue("endcolor", "125 125 125")
		Smoke2:SetKeyValue("minspeed", 40)
		Smoke2:SetKeyValue("maxspeed", 100)
		Smoke2:SetKeyValue("startsize", 50)
		Smoke2:SetKeyValue("endsize", 100)
		Smoke2:SetKeyValue("spawnradius", 150)
		Smoke2:SetKeyValue("emittime", 300)
		Smoke2:SetKeyValue("firesprite", "sprites/firetrail.spr")
		Smoke2:SetKeyValue("smokesprite", "sprites/whitepuff.spr")
		Smoke2:SetPos(self:GetPos())
		Smoke2:SetParent(self)
		Smoke2:Spawn()
		Smoke2:Activate()
		
		self:EmitSound("Town.d1_town_01_ball_zap1" )
		
		if(self.Timer2 < CurTime()) then
			self:Remove()
		end
		
	end
end 
 