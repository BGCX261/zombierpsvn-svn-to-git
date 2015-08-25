
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Claws"			
	SWEP.Author				= "Stingwraith"

	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "f"
	SWEP.DrawCrosshair		= false
	
        killicon.AddFont( "weapon_crowbar", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )


end

-----------------------Main functions----------------------------
 
function SWEP:Think()
	if self.Owner:KeyPressed(IN_RELOAD) then
		self:DoReloadSounds()
	end
end

function SWEP:Initialize()
	if ( SERVER ) then
	self:SetWeaponHoldType( "melee" );
	util.PrecacheSound("npc/zombie/zombie_voice_idle1.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle2.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle3.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle4.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle5.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle6.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle7.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle8.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle9.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle10.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle11.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle12.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle13.wav")
	
	util.PrecacheSound("npc/zombie/zombie_voice_idle14.wav")
	
	util.PrecacheSound("npc/zombie/claw_strike1.wav")
	
	util.PrecacheSound("npc/zombie/claw_strike2.wav")
	
	util.PrecacheSound("npc/zombie/claw_strike3.wav")
	
	util.PrecacheSound("npc/zombie/claw_miss1.wav")
	
	util.PrecacheSound("npc/zombie/claw_miss2.wav")
	
	util.PrecacheSound("npc/zombie/zo_attack1.wav")
	
	util.PrecacheSound("npc/zombie/zo_attack2.wav")
	
	util.PrecacheSound("npc/zombie/zombie_die1.wav")
	
	util.PrecacheSound("npc/zombie/zombie_die2.wav")
	
	util.PrecacheSound("npc/zombie/zombie_die3.wav")
	end
end
 
function SWEP:PrimaryAttack()
self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 24
	bullet.Damage = 8
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 );
self.Owner:EmitSound("npc/zombie/zo_attack"..math.random(1, 2)..".wav")
self.Owner:EmitSound("npc/zombie/claw_strike"..math.random(1, 3)..".wav")
else
	self.Owner:EmitSound("npc/zombie/claw_miss"..math.random(1, 2)..".wav")
        self.Owner:EmitSound("npc/zombie/zo_attack"..math.random(1, 2)..".wav")
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
end

end
 
function SWEP:SecondaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	
	if( CLIENT ) then return; end

 	local trace = self.Owner:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 45 ) then
 		return;
	end
	
	self.Owner:EmitSound( self.Sound );
	
	trace.Entity:Fire( "unlock", "", .5 )
	trace.Entity:Fire( "open", "", .6 )
	self.Owner:ConCommand( "say /dome smashes the door in." );
	
	
	self.Owner:ViewPunch( Angle( -25, 0, 0 ) );
	self.Weapon:SetNextPrimaryFire( CurTime() + 2.5 );
end

function SWEP:DoReloadSounds()

	local sound = math.random(1, 14)
	
	if (sound == 1) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle1.wav")
	elseif (sound == 2) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle2.wav")
	elseif (sound == 3) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle3.wav")
	elseif (sound == 4) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle4.wav")
	elseif (sound == 5) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle5.wav")
	elseif (sound == 6) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle6.wav")
	elseif (sound == 7) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle7.wav")
	elseif (sound == 8) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle8.wav")
	elseif (sound == 9) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle9.wav")
	elseif (sound == 10) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle10.wav")
	elseif (sound == 11) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle11.wav")
	elseif (sound == 12) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle12.wav")
	elseif (sound == 13) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle13.wav")
	elseif (sound == 14) then
		self.Weapon:EmitSound("npc/zombie/zombie_voice_idle14.wav")
	end
end


-------------------------------------------------------------------

------------General Swep Info---------------
SWEP.Author   = "Stingwraith"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""
SWEP.Spawnable      = false
SWEP.AdminSpawnable  = true
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= false

-----------------------------------------------

------------Models---------------------------
SWEP.ViewModel      = "models/weapons/v_zombiearms.mdl"
SWEP.WorldModel   = ""
-----------------------------------------------

SWEP.Sound = Sound( "physics/wood/wood_box_impact_hard3.wav" );

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.5 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 2	--Damage per Bullet
SWEP.Primary.NumShots		= 10		--Number of shots per one fire
SWEP.Primary.Cone			= 10 	--Bullet Spread
SWEP.Primary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 1.2
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------