include('shared.lua')

function ENT:Initialize()
end

function ENT:Draw()
self.Entity:DrawModel()
	if ( LocalPlayer():GetEyeTrace().Entity == self.Entity && EyePos():Distance( self.Entity:GetPos() ) < 512 ) then
			if self.Entity:GetNetworkedBool("on")==false then
				str="Weapon Stripper\nOff"
			end
			if self.Entity:GetNetworkedBool("on")==true then
				str="Weapon Stripper\nOn"
			end
		AddWorldTip(self.Entity:EntIndex(),str,0.5,self.Entity:GetPos(),self.Entity)
	end
end
