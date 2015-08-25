AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	util.PrecacheModel("models/props_c17/FurnitureShelf001b.mdl")
	self.Entity:SetModel("models/props_c17/FurnitureShelf001b.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetNetworkedBool("on",false)
	self.Entity:Strip()
end

function ENT:SpawnFunction( ply, tr )
if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	SpawnPos.z = SpawnPos.z + 10
	local ent = ents.Create( "w_stripper" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:Activate()
	return ent
end

function ENT:AcceptInput(name,activator,caller)
	if name=="toggle" then
			if self.Entity:GetNetworkedBool("on")==true then
			self.Entity:SetNetworkedBool("on",false)
		else
			self.Entity:SetNetworkedBool("on",true)
		end
	end
end

function ENT:Strip()
	if self.Entity:GetNetworkedBool("on")==true then
				local playahz=ents.FindInSphere(self.Entity:GetPos(), 200)
				local wlist={}
					for _,ply in pairs(playahz) do
						if ply:GetClass()=="player" then
							local trace={}
							trace.start=ply:GetPos()
							trace.endpos=self.Entity:GetPos()
							trace.filter = allweapons
							traceRes=util.TraceLine(trace)
								if traceRes.Entity==self.Entity or string.find(traceRes.Entity:GetClass(),"weapon") or traceRes.Entity:IsWeapon() then
									for i=1,5000 do
										local en=ents.GetByIndex(i)
											if en:IsValid() then
												if en:GetParent()==ply then
													if string.find(en:GetClass(),"weapon") or en:IsWeapon() then
														table.insert(wlist,en:GetClass())
														en:Remove()
													end
												end
											end
									end
									
									for i=1,table.getn(wlist) do
										local argh=ents.Create(wlist[i])
										argh:Spawn()
										argh:SetPos( ply:GetPos()+(self.Entity:GetPos()-ply:GetPos()):Normalize()*100 )
									end
									ply:StripWeapons()
								end
						end
					end
	end
	timer.Simple(0.1,self.Strip, self)
end

function ENT:Think()
	if self.Entity:GetNetworkedBool("on")==true then
		local entz=ents.FindInSphere(self.Entity:GetPos(), 200)
			for _,ent in pairs(entz) do
				if string.find(ent:GetClass(),"weapon") or ent:IsWeapon() then
					local physobj=ent:GetPhysicsObject()
						if physobj:IsValid() then
							physobj:SetVelocity( (self.Entity:GetPos()-ent:GetPos()):Normalize()*100 )
						end
				end
			end
	end
end
