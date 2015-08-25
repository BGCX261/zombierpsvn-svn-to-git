

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "pistol"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "6 Shot Magnum"			
	SWEP.Author				= ""
	SWEP.Slot				= 1
	SWEP.SlotPos			= 4
	SWEP.IconLetter			= "f"
	SWEP.ViewModelFOV		= 65
	SWEP.ViewModelFlip		= false
	
	killicon.AddFont( "weapon_ironsight_pistol", "HL2KillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end


SWEP.Base				= "weapon_cs_base2"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_357.mdl"
SWEP.WorldModel			= "models/weapons/w_357.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_357.Single" )
SWEP.Primary.Recoil			= 8.5
SWEP.Primary.Damage			= 75
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 6
SWEP.Primary.Delay			= 0.6
SWEP.Primary.DefaultClip	= 70
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( -5.64, -9, 2.67 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )