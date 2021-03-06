
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/glassjug01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWInt("damage",10)
end

function ENT:OnTakeDamage(dmg)
self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage") - dmg:GetDamage())

	if(self.Entity:GetNWInt("damage") <= 0) then
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() )
		effectdata:SetMagnitude( 2 )
		effectdata:SetScale( 2 )
		effectdata:SetRadius( 3 )
	util.Effect( "Sparks", effectdata )
		self.Entity:Remove()
	end
end

function ENT:Use(activator,caller)
DrugPlayer(caller)
self.Entity:Remove()
end

function ENT:Think()

end

function ENT:OnRemove( )
	local ply = self.Entity:GetNWEntity( "ownu" )
	ply:SetNWInt("maxDrugs",ply:GetNWInt("maxDrugs") - 1)
end

