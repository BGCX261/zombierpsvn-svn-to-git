
--------------------Server and Client Swep Settings		------------------------
if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= true

end

if ( CLIENT ) then

	SWEP.PrintName      	= "Butchering Knife"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false

end


--------------------		General Swep Settings		------------------------
SWEP.Author   				= "Stingwraith"
SWEP.HitForce				= 15
SWEP.Spawnable      		= false
SWEP.AdminSpawnable  		= true
SWEP.Slot					= 0
SWEP.SlotPos				= 10
SWEP.Description			= "A semi-strong kitchen knife."
SWEP.Instructions			= ""
SWEP.ViewModel      		= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel   			= "models/weapons/w_knife_ct.mdl"
local KnifeRange 			= 85


--------------------		Primary Fire Attributes		------------------------
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo         	= "none"
SWEP.Primary.Automatic    	= false
SWEP.Primary.Delay			= 0.5
SWEP.Primary.Damage			= 4
SWEP.Primary.SwingSound		= "weapons/knife/knife_slash1.wav"
SWEP.Primary.EntitySound	= "weapons/knife/knife_hit1.wav"
SWEP.Primary.WorldSound		= "weapons/knife/knife_hitwall1.wav"


--------------------	Secondary Fire Attributes		------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo         	= "none"
SWEP.Secondary.Automatic    	= false
SWEP.Secondary.Delay			= 0.5
SWEP.Secondary.Damage			= 2
SWEP.Primary.SwingSound		= "weapons/knife/knife_slash1.wav"
SWEP.Primary.EntitySound	= "weapons/knife/knife_hit1.wav"
SWEP.Primary.WorldSound		= "weapons/knife/knife_hitwall1.wav"


/*---------------------------------------------------------
		Sound Precaching
---------------------------------------------------------*/
util.PrecacheSound("weapons/knife/knife_slash1.wav")
util.PrecacheSound("weapons/knife/knife_slash2.wav")
util.PrecacheSound("weapons/knife/knife_hit1.wav")
util.PrecacheSound("weapons/knife/knife_hit2.wav")
util.PrecacheSound("weapons/knife/knife_hitwall1.wav")
util.PrecacheSound("weapons/knife/knife_deploy1.wav")


/*---------------------------------------------------------
		Non-Human NPCs
---------------------------------------------------------*/
local non_human_npcs = { 
"npc_antlion", 
"npc_antlionguard", 
"npc_barnacle", 
"npc_crow", 
"npc_cscanner", 
"npc_pigeon", 
"npc_rollermine", 
"npc_dog", 
"npc_headcrab", 
"npc_zombie_torso", 
"npc_headcrab_black", 
"npc_headcrab_fast", 
"npc_manhack",
"npc_fastzombie", 
"npc_gman", 
"npc_kleiner", 
"npc_metropolice", 
"npc_monk", 
"npc_mossman", 
"npc_vortigaunt", 
"npc_zombie", 
"npc_citizen_rebel", 
"npc_citizen", 
"npc_citizen_dt", 
"npc_citizen_medic",
"npc_alyx", 
"npc_barney", 
"npc_breen", 
"npc_combine_s", 
"npc_combine_p", 
"npc_combine_e", 
"npc_eli" };


/*---------------------------------------------------------
		Human NPCs
---------------------------------------------------------*/
local human_npcs = {  
"npc_dog",  };


/*---------------------------------------------------------
		PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	local pos = self.Owner:GetShootPos()
	local ang = self.Owner:GetAimVector()
	
	local tracedata = {}
		tracedata.start = pos
		tracedata.endpos = pos + (ang * KnifeRange)
		tracedata.filter = self.Owner
	local trace = util.TraceLine(tracedata)
	
	if trace.HitNonWorld then
		if (trace.Entity:IsPlayer()) then
			self:ShootBullet() --Call the function that is stated below to shoot the invisible bullet.
			
			self.Weapon:EmitSound( self.Primary.EntitySound )
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )

			local Pos1 = trace.HitPos + trace.HitNormal
			local Pos2 = trace.HitPos - trace.HitNormal
			util.Decal("Blood", Pos1, Pos2 )

		elseif (trace.Entity:IsNPC()) then
				local class = trace.Entity:GetClass()
				
				if ( table.HasValue( non_human_npcs, class ) ) then
					self:ShootBullet()
					
				elseif ( table.HasValue( human_npcs, class) ) then
					if ( SERVER ) then
						trace.Entity:Remove()
						
						local upperbodyhalf = ents.Create("prop_ragdoll")
						upperbodyhalf:SetModel("models/gibs/fast_zombie_torso.mdl")
						upperbodyhalf:SetPos(trace.HitPos - Vector(0, 0, 40))
						upperbodyhalf:PointAtEntity(self.Owner)
						upperbodyhalf:Spawn()
						upperbodyhalf:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector() * 1500)
						upperbodyhalf:SetOwner(self.Owner);
						upperbodyhalf:Fire("kill", "", 10)
						
						local lowerbodyhalf = ents.Create("prop_ragdoll")
						lowerbodyhalf:SetModel("models/gibs/fast_zombie_legs.mdl")
						lowerbodyhalf:SetPos(trace.HitPos - Vector(0, 0, 40))
						lowerbodyhalf:PointAtEntity(self.Owner)
						lowerbodyhalf:Spawn()
						lowerbodyhalf:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector() * 1500)
						lowerbodyhalf:SetOwner(self.Owner)
						lowerbodyhalf:Fire("kill", "", 10)
						

						local bloodspew = ents.Create( "env_shooter" )
						bloodspew:SetKeyValue("m_iGibs", "3")
						bloodspew:SetKeyValue("delay", "0")
						bloodspew:SetKeyValue("gibangles", "0 0 0")
						bloodspew:SetKeyValue("m_flVelocity", 1500)
						bloodspew:SetKeyValue("m_flVariance", math.random() * 0.4)
						bloodspew:SetKeyValue("m_flGibLife", math.random() * 0.25)
						bloodspew:SetKeyValue("rendermode", "0")
						bloodspew:SetKeyValue("renderamt", "128")
						bloodspew:SetKeyValue("shootmodel", "decals/blood_gunshot_decal.vmt")
						bloodspew:SetKeyValue("shootsounds", "3")
						bloodspew:SetKeyValue("simulation", "0")
						bloodspew:SetPos(trace.HitPos)
						bloodspew:Spawn()
						bloodspew:SetAngles(self.Owner:GetAimVector():Angle())
						bloodspew:Fire("shoot", "", 0)
						bloodspew:Fire("kill", "", 0.25)
					end
				end
			
			self.Weapon:EmitSound( self.Primary.EntitySound )
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			
		elseif (trace.Entity:GetClass() == "prop_ragdoll") then --If you hit a ragdoll, then paint some bloody decals on it >:)
			self:ShootBullet()
			self.Weapon:EmitSound( self.Primary.EntitySound )
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			local Pos1 = trace.HitPos + trace.HitNormal
			local Pos2 = trace.HitPos - trace.HitNormal
			util.Decal("Blood", Pos1, Pos2 )
		else
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			self.Weapon:EmitSound( self.Primary.WorldSound )
			
			local Pos1 = trace.HitPos + trace.HitNormal
			local Pos2 = trace.HitPos - trace.HitNormal
			util.Decal("ManhackCut", Pos1, Pos2 )
		end
	elseif trace.HitWorld then
		self.Weapon:EmitSound( self.Primary.WorldSound )
		
		local Pos1 = trace.HitPos + trace.HitNormal
		local Pos2 = trace.HitPos - trace.HitNormal
		util.Decal("ManhackCut", Pos1, Pos2 )
		
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	else	
		self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
	end
	
	self.Weapon:EmitSound( self.Primary.SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

/*---------------------------------------------------------
		SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end
/*--------------------------------------------
-- I made a new function for the 
-- bullet that is shot when the trace 
-- hits either a player or an NPC.
---------------------------------------------*/
function SWEP:ShootBullet()
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = self.HitForce
	bullet.Damage = self.Primary.Damage
	self.Owner:FireBullets(bullet)
end

/*---------------------------------------------------------
--	When the swep thinks real hard >_<
---------------------------------------------------------*/
function SWEP:Think()

end

/*---------------------------------------------------------
--Gets called from the think function above.
---------------------------------------------------------*/

/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	if ( SERVER ) then
		self:SetWeaponHoldType( "melee" );
	end
end

/*---------------------------------------------------------
	When the weapon is pulled out
---------------------------------------------------------*/
function SWEP:Deploy()
	self.Weapon:EmitSound( "weapons/knife/knife_deploy1.wav" ) --Plays a nifty sound when you pull it out.
end
