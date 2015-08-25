

/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	self.ent = data:GetEntity()
	if ( self.ent == nil ) then return end
	if (self.ent:GetModel() == nil ) then return end
	
	self.Entity:SetModel( self.ent:GetModel() )
	self.Entity:SetPos( self.ent:GetPos() )
	self.Entity:SetAngles( self.ent:GetAngles() )
	self.Entity:SetParent( self.ent )
	
	self.Time = 4
	self.LifeTime = CurTime() + self.Time
end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
	if not self.LifeTime then self.LifeTime=4 end
	return ( self.LifeTime > CurTime() ) 
end

local matOverlay = Material( "models/shadertest/shader3" )

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

	if not self.LifeTime then self.LifeTime=4 end
	if not self.Time then self.Time=4 end
	// Todo, some kind of non refraction crappy additive blended crap crap
	if ( render.GetDXLevel() < 8 ) then return end
	
	local Fraction = (self.LifeTime - CurTime()) / self.Time
	//Fraction = math.Clamp( Fraction * 2, 0, 1 )
	//self.Entity:SetColor( 255, 255, 255, Fraction * 255 )

	Fraction = Fraction ^ 3
	
	matOverlay:SetMaterialFloat( "$refractamount", Fraction )
	
	render.UpdateScreenEffectTexture()
	
	// Place the camera a tiny bit closer to the entity - so it draw a tiny bit bigger
	local EyeNormal = self.Entity:GetPos() - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local Pos = EyePos() + EyeNormal * Distance * 0.01
	cam.Start3D( Pos, EyeAngles() )
	
	// White Outline (big)
	SetMaterialOverride( matOverlay )
		self.Entity:DrawModel()
	SetMaterialOverride( 0 )
	
	cam.End3D()

end



