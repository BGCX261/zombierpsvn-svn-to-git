AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	util.PrecacheModel("models/props_combine/combinebutton.mdl")
	self.Entity:SetModel("models/props_combine/combinebutton.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Lastpress=0
end

function ENT:SpawnFunction( ply, tr )
if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	SpawnPos.z = SpawnPos.z + 20
	local ent = ents.Create( "stripper_button" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:Activate()
	return ent
end

function ENT:Use()
	if self.Lastpress>CurTime() then return end
		self.Lastpress=CurTime()+1
		local sphere = ents.FindInSphere(self.Entity:GetPos(),512)
			for i=1,table.getn(sphere) do
				if sphere[i]:GetClass()=="w_stripper" then
					sphere[i]:Fire("toggle","",0)
						local sequence = self.Entity:LookupSequence("press")
						self.Entity:ResetSequence(sequence)
				end
			end
end