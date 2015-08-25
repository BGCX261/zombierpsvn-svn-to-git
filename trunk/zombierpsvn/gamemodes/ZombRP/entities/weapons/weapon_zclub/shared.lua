if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "melee"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Club"			
	SWEP.Author				= "Feihc/EdibleDev"

	SWEP.Slot				= 1
	SWEP.SlotPos			= 7
	SWEP.ViewModelFOV		= 62
	SWEP.IconLetter			= "x"

end
-----------------------Main functions----------------------------
 
-- function SWEP:Reload() --To do when reloading
-- end 
 
function SWEP:Think() -- Called every frame
end

function SWEP:Initialize()
util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
end
 
function SWEP:PrimaryAttack()
self.Weapon:SetNextPrimaryFire(CurTime() + .4)

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 1
	bullet.Damage = 12
self.Owner:FireBullets(bullet) 
self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
else
	self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end

end
 
function SWEP:SecondaryAttack()

end
-------------------------------------------------------------------

------------General Swep Info---------------
SWEP.Author   = "Valve/Feihc/EdibleDev"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = "A club."
SWEP.Spawnable      = false
SWEP.AdminSpawnable  = true
-----------------------------------------------

------------Models---------------------------
SWEP.ViewModel = Model( "models/weapons/v_stunstick.mdl" );
SWEP.WorldModel = Model( "models/weapons/w_stunbaton.mdl" );
-----------------------------------------------

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 1.4	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 12	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 1.3	--Bullet Spread
SWEP.Primary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------