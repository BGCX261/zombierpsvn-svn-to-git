
 if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end


 

SWEP.PrintName      = "Medical Kit"   
SWEP.Author   = "Jake Johnson"
SWEP.Slot         = 4;
SWEP.SlotPos            = 3;
SWEP.Description        = "Heals the wounded."
SWEP.Contact            = ""
SWEP.Purpose            = ""
SWEP.Instructions      = "Left Click to heal player infront of user."

 
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true
 
SWEP.ViewModel      = "models/weapons/v_c4.mdl"
SWEP.WorldModel   = "models/weapons/w_c4.mdl"
 
SWEP.Primary.Recoil  = 0
SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic    = false
SWEP.Primary.Delay    = 2
SWEP.Primary.Ammo      = "none"
 
SWEP.Secondary.Recoil      = 0
SWEP.Secondary.ClipSize  = -1
SWEP.Secondary.DefaultClip  = 1
SWEP.Secondary.Automatic    = true
SWEP.Secondary.Delay        = 0.3
SWEP.Secondary.Ammo  = "none"
 

util.PrecacheSound("HL1/fvox/medical_repaired.wav")
util.PrecacheSound("HL1/fvox/radiation_detected.wav")
util.PrecacheSound("HL1/fvox/automedic_on.wav")

function SWEP:PrimaryAttack()
 

 
self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
 
trace = {}
trace.start = self.Owner:GetShootPos()
trace.endpos = trace.start + (self.Owner:GetAimVector() * 85)
trace.filter = { self.Owner, self.Weapon }
tr = util.TraceLine( trace )
 
if (tr.HitNonWorld) then
local enthit = tr.Entity


            enthit:SetHealth( 100 );
			self.Owner:EmitSound("HL1/fvox/medical_repaired.wav", 150, 100)
			self.Owner:PrintMessage( HUD_PRINTTALK, "*Medic Kit* Healing Player." );

	end
        end
		