
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
	
	util.PrecacheSound( "vo/coast/odessa/male01/nlo_cheer01.wav" )
	
	self.Timer = CurTime() + 5
	self.Timer2 = self.Timer + 5
	
	self.explode = true

end

/*---------------------------------------------------------
   Name: Think
---------------------------------------------------------*/
function ENT:Think()
	if(self.Timer < CurTime()) then
		self.explode = false
		
		local pplz = ents.FindInSphere(self.Entity:GetPos(), 500)
		for _, a in pairs(pplz) do
			if a:IsValid() then
				if a:IsPlayer() then
					a:ChatPrint( "Peace and love!" )
					a:ChatPrint( "No more war!" )
					a:SetHealth( 500 )
					a:StripWeapons()
				end
			end
		end
		
		local effectdata = EffectData()
		effectdata:SetEntity( self )
		effectdata:SetStart( self:GetPos() )
		effectdata:SetOrigin( self:GetPos() )
		effectdata:SetAngle( self:GetAngles() )
		effectdata:SetScale( 15 )
		effectdata:SetMagnitude( 15 )
		util.Effect( "GlassImpact", effectdata )
		
		self:EmitSound("vo/coast/odessa/male01/nlo_cheer01.wav" )
		
		util.ScreenShake( self:GetPos(), 5, 5, 3, 300 )
		
		self:Remove()
	end
end

