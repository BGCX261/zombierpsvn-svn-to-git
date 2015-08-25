
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
	
	self.Owner = self:GetOwner()
	
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
	Smoke:SetKeyValue("startsize", 20)
	Smoke:SetKeyValue("endsize", 80)
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
	if(self.Timer < CurTime() && self.Owner:IsAdmin()) then
		self.explode = false
		
		local Players = ents.FindInSphere(self.Entity:GetPos(), 500)
		for _, ply in pairs(Players) do
			if ply:IsValid() then
				if ply:IsPlayer() then
					self.Owner:ConCommand( "kickid " .. ply:UserID() )
				end
			end
		end
		 
		local effectdata = EffectData()  
		effectdata:SetStart( self:GetPos() )  
		effectdata:SetOrigin( self:GetPos() )  
		effectdata:SetScale( 3 )  
		util.Effect( "Explosion", effectdata )
		
		self:Remove()
	end
end

