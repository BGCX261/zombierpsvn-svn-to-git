-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel( "models/props_combine/combine_mine01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( self.Entity, 60, 0, self.giveMoney, self)
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",100)
	local ply = self.Entity:GetNWEntity( "ownu" )
	ply:SetNWInt("maxDrug",ply:GetNWInt("maxDrug") + 1)
end

function ENT:OnTakeDamage(dmg)
	self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage") - dmg:GetDamage())
	if(self.Entity:GetNWInt("damage") <= 0) then
		self.Entity:Destruct()  
		self.Entity:Remove()
	end
end

function ENT:giveMoney()
	local ply = self.Entity:GetNWEntity( "ownu" )
	if(ply:Alive()) then
		ply:AddMoney( GetGlobalInt("drugpayamount") );
		Notify( ply, 1, 3, "Paid $" .. GetGlobalInt("drugpayamount") .. " for selling drugs." );
	end
end

function ENT:Destruct()

	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint )
	effectdata:SetScale( 1 )
	util.Effect( "Explosion", effectdata )

end

function ENT:Use(activator,caller)
	self.Entity:SetNWEntity( "usero", activator )
	if( activator:GetNWInt("maxDrugs") >= 2 ) then
		Notify( activator, 1, 3, "Reached Max Drugs" );
	else
		self.Entity:SetNWBool("sparking",true)
		timer.Create( self.Entity:EntIndex() .. "drug", 1, 1, self.createDrug, self )
	end
end

function ENT:createDrug()
local userb = self.Entity:GetNWEntity( "usero" )
local drugPos = self.Entity:GetPos()
drug = ents.Create("drug")
drug:SetPos(Vector(drugPos.x,drugPos.y,drugPos.z + 10))
drug:SetNWEntity( "ownu", userb )
drug:Spawn()
userb:SetNWInt("maxDrugs",userb:GetNWInt("maxDrugs") + 1)
self.Entity:SetNWBool("sparking",false)
end

function ENT:Think()
if(self.Entity:GetNWBool("sparking") == true) then
	local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() )
		effectdata:SetMagnitude( 1 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 2 )
	util.Effect( "Sparks", effectdata )
end
end

function ENT:OnRemove( )
timer.Destroy(self.Entity:EntIndex()) 
	local ply = self.Entity:GetNWEntity( "ownu" )
	ply:SetNWInt("maxDrug",ply:GetNWInt("maxDrug") - 1)
end

