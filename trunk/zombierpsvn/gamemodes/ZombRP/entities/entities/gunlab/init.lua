-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_c17/TrapPropeller_Engine.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",100)
	local ply = self.Entity:GetNWEntity( "ownu" )
	ply:SetNWInt("maxgunlabs",ply:GetNWInt("maxgunlabs") + 1)
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

function ENT:Use( activator )
	self.Entity:SetNWEntity( "user", activator )
	if( not activator:CanAfford( GetGlobalInt("p228cost") ) ) then
		Notify( activator, 1, 3, "Cannot afford this" );
		return "";
	end
	self.Entity:SetNWBool("sparking",true)
	timer.Create( self.Entity:EntIndex() .. "spawned_weapon", 1, 1, self.createGun, self)
end

function ENT:createGun()
	local gun = ents.Create( "spawned_weapon" );
	gun = ents.Create("spawned_weapon")
	gun:SetModel( "models/weapons/w_pist_p228.mdl" );
	gun:SetNWString("weaponclass", "weapon_p2282");
	local gunPos = self.Entity:GetPos()
	gun:SetPos(Vector(gunPos.x, gunPos.y, gunPos.z + 27));
	gun:Spawn();
	local activator = self.Entity:GetNWEntity( "user" )
	if( activator:Team() ~= 6 ) then
		local owner = self.Entity:GetNWEntity( "ownu" )
		owner:AddMoney( GetGlobalInt("p228cost") );
		Notify( owner, 1, 3, "Paid $" .. GetGlobalInt("p228cost") .. " for selling a P228!" );
	end
	activator:AddMoney( GetGlobalInt("p228cost") * -1 );
	Notify( activator, 1, 3, "You bought a P228 for $" .. GetGlobalInt("p228cost") .. "!" );
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
timer.Destroy(self.Entity)
	local ply = self.Entity:GetNWEntity( "ownu" )
	ply:SetNWInt("maxgunlabs",ply:GetNWInt("maxgunlabs") - 1)
end
