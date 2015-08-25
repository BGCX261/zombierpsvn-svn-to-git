AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
self.Entity:SetModel("models/props_c17/door01_left.mdl")
  self.Entity:PhysicsInit( SOLID_VPHYSICS )
  self.Entity:SetMoveType( MOVETYPE_NONE )
  self.Entity:SetSolid( SOLID_NONE )
  self.Entity:SetColor(255,255,255,1)
end