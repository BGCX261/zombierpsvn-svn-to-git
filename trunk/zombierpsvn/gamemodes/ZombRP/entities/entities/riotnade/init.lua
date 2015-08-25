
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
	
	util.PrecacheSound( "vo/ravenholm/monk_rant01.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant02.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant03.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant04.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant05.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant06.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant07.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant08.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant09.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant10.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant11.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant12.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant13.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant14.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant15.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant16.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant17.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant18.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant19.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant20.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant21.wav" )
	util.PrecacheSound( "vo/ravenholm/monk_rant22.wav" )
	
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
		
		self:EmitSound("vo/ravenholm/monk_rant" .. math.random( 1, 22 ) .. ".wav" )
		
		local effectdata = EffectData()  
		effectdata:SetStart( self:GetPos() )  
		effectdata:SetOrigin( self:GetPos() )  
		effectdata:SetScale( 3 )  
		util.Effect( "HelicopterMegaBomb", effectdata )
		
		self:Remove()
	end
end

