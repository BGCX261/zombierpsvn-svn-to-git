-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props/cs_office/microwave.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",100)
	local ply = self.Entity:GetNWEntity( "ownu" )
	ply:SetNWInt("maxMicrowaves", ply:GetNWInt("maxMicrowaves") + 1)
end

function ENT:OnTakeDamage(dmg)
	self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage") - dmg:GetDamage())
	if(self.Entity:GetNWInt("damage") <= 0) then
		self.Entity:Destruct()
		self.Entity:Remove()
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
	self.Entity:SetNWEntity( "user", activator )
	if( not activator:CanAfford( GetGlobalInt("microwavecost") ) ) then
		Notify( activator, 1, 3, "Cannot afford this" );
	end
	if( activator:GetNWInt("maxFoods") >= 2 ) then
		Notify( activator, 1, 3, "Max Food Reached!" );
	else
		self.Entity:SetNWBool("sparking",true)
		timer.Create( self.Entity:EntIndex() .. "food", 1, 1, self.createFood, self)
	end
end

function ENT:createFood()
	local activator = self.Entity:GetNWEntity( "user" )
	activator:AddMoney( GetGlobalInt("microwavefood") * -1 );
	Notify( activator, 1, 3, "You Bought Food for $" .. GetGlobalInt("microwavefood") .. "" );
	local foodPos = self.Entity:GetPos()
	food = ents.Create("food")
	food:SetPos(Vector(foodPos.x,foodPos.y,foodPos.z + 23))
	food:SetNWEntity( "ownu", activator )
	food:Spawn()
	activator:SetNWInt("maxFoods",activator:GetNWInt("maxFoods") + 1)
	self.Entity:SetNWBool("sparking",false)
	if( activator:Team() ~= 8 ) then
		local owneguy = self.Entity:GetNWEntity( "ownu" )
		owneguy:AddMoney( GetGlobalInt("microwavefood") );
		Notify( ownerguy, 1, 3, "Paid $" .. GetGlobalInt("microwavefood") .. " for selling Food!" );
	end
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
	ply:SetNWInt("maxMicrowaves",ply:GetNWInt("maxMicrowaves") - 1)
end
