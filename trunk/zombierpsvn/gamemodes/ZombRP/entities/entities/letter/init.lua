
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_c17/paper01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
end

function ENT:Think()

end

function ENT:OnRemove()
	local ply = self.Entity:GetNWEntity( "ownu" )
	ply:SetNWInt("maxletters",ply:GetNWInt("maxletters") - 1)
end
