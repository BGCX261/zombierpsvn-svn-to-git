function combinedeathsounds( victim, weapon, killer )

local model = victim:GetModel()

if model == "models/player/combine_soldier.mdl" || model == "models/player/combine_soldier_prisonguard.mdl" || model == "models/player/combine_super_soldier.mdl" then //Combine Soldiers
util.PrecacheSound("npc/combine_soldier/die1.wav")
util.PrecacheSound("npc/combine_soldier/die2.wav")
util.PrecacheSound("npc/combine_soldier/die3.wav")
victim:EmitSound("npc/combine_soldier/die" .. math.Round(math.Rand(1,3)) .. ".wav", 72, 100)
end

if model == "models/player/barney.mdl" then //Barney
util.PrecacheSound("vo/npc/barney/ba_pain01.wav")
util.PrecacheSound("vo/npc/barney/ba_pain02.wav")
util.PrecacheSound("vo/npc/barney/ba_pain03.wav")
util.PrecacheSound("vo/npc/barney/ba_pain04.wav")
util.PrecacheSound("vo/npc/barney/ba_pain05.wav")
util.PrecacheSound("vo/npc/barney/ba_pain06.wav")
util.PrecacheSound("vo/npc/barney/ba_pain07.wav")
util.PrecacheSound("vo/npc/barney/ba_pain08.wav")
util.PrecacheSound("vo/npc/barney/ba_pain09.wav")
util.PrecacheSound("vo/npc/barney/ba_pain10.wav")
util.PrecacheSound("vo/k_lab/ba_geethanks.wav")
util.PrecacheSound("vo/npc/barney/ba_ohshit03.wav")
local decider = math.Round(math.Rand(1,5))
if decider == 1 then victim:EmitSound("vo/npc/barney/ba_pain0" .. math.Round(math.Rand(1,4)) .. ".wav", 72, 100) end
if decider == 2 then victim:EmitSound("vo/npc/barney/ba_pain0" .. math.Round(math.Rand(5,9)) .. ".wav", 72, 100) end
if decider == 3 then victim:EmitSound("vo/npc/barney/ba_pain10.wav", 72, 100) end
if decider == 4 then victim:EmitSound("vo/k_lab/ba_geethanks.wav", 72, 100) end
if decider == 5 then victim:EmitSound("vo/npc/barney/ba_ohshit03.wav", 72, 100) end
end

if model == "models/player/breen.mdl" then //Breen
util.PrecacheSound("vo/citadel/br_gravgun.wav")
util.PrecacheSound("vo/citadel/br_no.wav")
util.PrecacheSound("vo/citadel/br_mock04.wav")
util.PrecacheSound("vo/citadel/br_ohshit.wav")
util.PrecacheSound("vo/citadel/br_yesjudith.wav")
local decider = math.Round(math.Rand(1,5))
if decider == 1 then victim:EmitSound("vo/citadel/br_gravgun.wav", 72, 100) end
if decider == 2 then victim:EmitSound("vo/citadel/br_no.wav", 72, 100) end
if decider == 3 then victim:EmitSound("vo/citadel/br_mock04.wav", 72, 100) end
if decider == 4 then victim:EmitSound("vo/citadel/br_ohshit.wav", 72, 100) end
if decider == 5 then victim:EmitSound("vo/citadel/br_yesjudith.wav", 72, 100) end
end

if model == "models/player/classic.mdl" then //Zombie
util.PrecacheSound("npc/zombie/zombie_die1.wav")
util.PrecacheSound("npc/zombie/zombie_die2.wav")
util.PrecacheSound("npc/zombie/zombie_die3.wav")
victim:EmitSound("npc/zombie/zombie_die" .. math.Round(math.Rand(1,3)) .. ".wav", 72, 100)
end

if model == "models/player/kleiner.mdl" then //Kleiner
util.PrecacheSound("vo/k_lab/kl_hedyno03.wav")
util.PrecacheSound("vo/k_lab/kl_ahhhh.wav")
util.PrecacheSound("vo/k_lab/kl_fiddlesticks.wav")
util.PrecacheSound("vo/k_lab/kl_heremypet02.wav")
local decider = math.Round(math.Rand(1,4))
if decider == 1 then victim:EmitSound("vo/k_lab/kl_hedyno03.wav", 72, 100) end
if decider == 2 then victim:EmitSound("vo/k_lab/kl_ahhhh.wav", 72, 100) end
if decider == 3 then victim:EmitSound("vo/k_lab/kl_fiddlesticks.wav", 72, 100) end
if decider == 4 then victim:EmitSound("vo/k_lab/kl_heremypet02.wav", 72, 100) end
end

if model == "models/player/Group01/Male_01.mdl" || model == "models/player/Group01/male_02.mdl" || model == "models/player/Group01/male_03.mdl" || model == "models/player/Group01/Male_04.mdl" || model == "models/player/Group01/Male_05.mdl" || model == "models/player/Group01/male_06.mdl" || model == "models/player/Group01/male_07.mdl" || model == "models/player/Group01/male_08.mdl" || model == "models/player/Group01/male_09.mdl" then //Male Civ
util.PrecacheSound("vo/npc/male01/pain01.wav")
util.PrecacheSound("vo/npc/male01/pain02.wav")
util.PrecacheSound("vo/npc/male01/pain03.wav")
util.PrecacheSound("vo/npc/male01/pain04.wav")
util.PrecacheSound("vo/npc/male01/pain05.wav")
util.PrecacheSound("vo/npc/male01/pain06.wav")
util.PrecacheSound("vo/npc/male01/pain07.wav")
util.PrecacheSound("vo/npc/male01/pain08.wav")
util.PrecacheSound("vo/npc/male01/pain09.wav")
victim:EmitSound("vo/npc/male01/pain0" .. math.Round(math.Rand(1,9)) .. ".wav", 72, 100)
end


if model == "models/player/Group03/Male_01.mdl" || model == "models/player/Group03/male_02.mdl" || model == "models/player/Group03/male_03.mdl" || model == "models/player/Group03/Male_04.mdl" || model == "models/player/Group03/Male_05.mdl" || model == "models/player/Group03/male_06.mdl" || model == "models/player/Group03/male_07.mdl" || model == "models/player/Group03/male_08.mdl" || model == "models/player/Group03/male_09.mdl" then //Male Rebel
util.PrecacheSound("vo/npc/male01/pain01.wav")
util.PrecacheSound("vo/npc/male01/pain02.wav")
util.PrecacheSound("vo/npc/male01/pain03.wav")
util.PrecacheSound("vo/npc/male01/pain04.wav")
util.PrecacheSound("vo/npc/male01/pain05.wav")
util.PrecacheSound("vo/npc/male01/pain06.wav")
util.PrecacheSound("vo/npc/male01/pain07.wav")
util.PrecacheSound("vo/npc/male01/pain08.wav")
util.PrecacheSound("vo/npc/male01/pain09.wav")
victim:EmitSound("vo/npc/male01/pain0" .. math.Round(math.Rand(1,9)) .. ".wav", 72, 100)
end

if model == "models/player/monk.mdl" then //Father Grigori
util.PrecacheSound("vo/ravenholm/monk_pain01.wav")
util.PrecacheSound("vo/ravenholm/monk_pain02.wav")
util.PrecacheSound("vo/ravenholm/monk_pain04.wav")
util.PrecacheSound("vo/ravenholm/monk_pain05.wav")
util.PrecacheSound("vo/ravenholm/monk_pain06.wav")
util.PrecacheSound("vo/ravenholm/monk_pain07.wav")
util.PrecacheSound("vo/ravenholm/monk_pain08.wav")
util.PrecacheSound("vo/ravenholm/monk_pain09.wav")
util.PrecacheSound("vo/ravenholm/monk_pain10.wav")
util.PrecacheSound("vo/ravenholm/monk_pain11.wav")
util.PrecacheSound("vo/ravenholm/monk_pain12.wav")
util.PrecacheSound("vo/ravenholm/monk_death07.wav")
local decider = math.Round(math.Rand(1,13))
if decider == 1 then victim:EmitSound("vo/ravenholm/monk_pain01.wav", 72, 100) end
if decider == 2 then victim:EmitSound("vo/ravenholm/monk_pain02.wav", 72, 100) end
if decider == 3 then victim:EmitSound("vo/ravenholm/monk_pain03.wav", 72, 100) end
if decider == 4 then victim:EmitSound("vo/ravenholm/monk_pain04.wav", 72, 100) end
if decider == 5 then victim:EmitSound("vo/ravenholm/monk_pain05.wav", 72, 100) end
if decider == 6 then victim:EmitSound("vo/ravenholm/monk_pain06.wav", 72, 100) end
if decider == 7 then victim:EmitSound("vo/ravenholm/monk_pain07.wav", 72, 100) end
if decider == 8 then victim:EmitSound("vo/ravenholm/monk_pain08.wav", 72, 100) end
if decider == 9 then victim:EmitSound("vo/ravenholm/monk_pain09.wav", 72, 100) end
if decider == 10 then victim:EmitSound("vo/ravenholm/monk_pain10.wav", 72, 100) end
if decider == 11 then victim:EmitSound("vo/ravenholm/monk_pain11.wav", 72, 100) end
if decider == 12 then victim:EmitSound("vo/ravenholm/monk_pain12.wav", 72, 100) end
if decider == 13 then victim:EmitSound("vo/ravenholm/monk_death07.wav", 72, 100) end
end

end
hook.Add( "PlayerDeath", "DeathSoundsHook", combinedeathsounds )

function removegoddamnflatline()
return true
end
hook.Add( "PlayerDeathSound", "RemoveFlatlineSound", removegoddamnflatline )