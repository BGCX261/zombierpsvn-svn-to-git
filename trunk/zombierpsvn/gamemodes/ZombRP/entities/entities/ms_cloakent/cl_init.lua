include('shared.lua')

local matBall = Material( "effects/strider_bulge_dudv" )

function ENT:Initialize()
self.Entity:SetNetworkedBool("set",false)
end

function ENT:Draw()

self.Entity:DrawModel()
local pent=self.Entity
if self.Entity:GetNetworkedBool("set")==true then
	pent=self.Entity:GetNetworkedEntity("parent")
end
   local vel=pent:GetVelocity():Length() or 0
   if vel>0 then vel=vel/5000 end
   vel=vel+math.random(0,0.01)
	matBall:SetMaterialFloat( "$refractamount", vel )
	render.UpdateScreenEffectTexture()
	render.SetMaterial( matBall )
	render.DrawSprite( self.Entity:GetPos(), 100, 100, Color(255,255,255,255) )
end