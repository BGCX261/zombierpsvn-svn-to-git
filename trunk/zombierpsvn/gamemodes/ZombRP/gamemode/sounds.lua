//////////////////
// CIV SOUNDS   //
//////////////////

function CallForGood(ply, say, teamsay)
         if string.find(say, "Good god") == 1 then
            ply:EmitSound(Sound("/vo/npc/male01/goodgod.wav"),500)
         end
end
hook.Add("PlayerSay","CallForGod_ChatHook",CallForGood)

function CallForNo(ply, say, teamsay)
         if string.find(say, "no") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/no02.wav"),500)
         end
end
hook.Add("PlayerSay","CallForNo_ChatHook",CallForNo)

function CallForExcuse(ply, say, teamsay)
         if string.find(say, "excuse me") == 1 then
            ply:EmitSound(Sound("/vo/npc/male01/excuseme01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForExcuse_ChatHook",CallForExcuse)

function CallForOk(ply, say, teamsay)
         if string.find(say, "okay") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/ok01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForOk_ChatHook",CallForOk)

function CallForOut(ply, say, teamsay)
         if string.find(say, "/y GET THE HELL OUT OF HERE!") == 1 then
            ply:EmitSound(Sound("/vo/npc/male01/gethellout.wav"),500)
         end
end
hook.Add("PlayerSay","CallForOut_ChatHook",CallForOut)

function CallForHelp(ply, say, teamsay)
         if string.find(say, "/y HELP") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/help01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForHelp_ChatHook",CallForHelp)

function CallForSorry(ply, say, teamsay)
         if string.find(say, "sorry") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/sorry01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForSorry_ChatHook",CallForSorry)

function CallForYeah(ply, say, teamsay)
         if string.find(say, "yeah") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/yeah02.wav"),500)
         end
end
hook.Add("PlayerSay","CallForYeah_ChatHook",CallForYeah)

function CallForWhat(ply, say, teamsay)
         if string.find(say, "what") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/vquestion01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForWhat_ChatHook",CallForWhat)

function CallForHi(ply, say, teamsay)
         if string.find(say, "hi") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/hi01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForHi_ChatHook",CallForHi)

function CallForHi(ply, say, teamsay)
         if string.find(say, "hello") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/hi02.wav"),500)
         end
end
hook.Add("PlayerSay","CallForHello_ChatHook",CallForHi)

function CallForCps(ply, say, teamsay)
         if string.find(say, "cops") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/cps01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForCps_ChatHook",CallForCps)

function CallForPardonMe(ply, say, teamsay)
         if string.find(say, "pardon") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/pardonme01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForPardonMe_ChatHook",CallForPardonMe)

function CallForBusy(ply, say, teamsay)
         if string.find(say, "busy") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/busy02.wav"),500)
         end
end
hook.Add("PlayerSay","CallForBusy_ChatHook",CallForBusy)

function CallForGet(ply, say, teamsay)
         if string.find(say, "get out") == 1 then
            ply:EmitSound(Sound("vo/canals/boxcar_go_nag03.wav"),500)
         end
end
hook.Add("PlayerSay","CallForGet_ChatHook",CallForGet)

function CallForFantastic(ply, say, teamsay)
         if string.find(say, "fantastic") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/fantastic01.wav"),500)
         end
end
hook.Add("PlayerSay","CallForFantastic_ChatHook",CallForFantastic)

function CallForRun(ply, say, teamsay)
         if string.find(say, "run") == 1 then
            ply:EmitSound(Sound("vo/npc/male01/strider_run.wav"),500)
         end
end
hook.Add("PlayerSay","CallForRun_ChatHook",CallForRun)

//////////////////////
// METRO COP SOUNDS //
//////////////////////

function CallForAff(ply, say, teamsay)
         if string.find(say, "Aff") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/affirmative.wav"),500)
         end
end
hook.Add("PlayerSay","CallForAff_ChatHook",CallForAff) 

function CallForMove(ply, say, teamsay)
         if string.find(say, "movealong") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/movealong3.wav"),500)
         end
end
hook.Add("PlayerSay","CallForMove_ChatHook",CallForMove)

function CallForMoveB(ply, say, teamsay)
         if string.find(say, "moveback") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/movebackrightnow.wav"),500)
         end
end
hook.Add("PlayerSay","CallForMoveB_ChatHook",CallForMoveB)

function CallForDontMove(ply, say, teamsay)
         if string.find(say, "dmove") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/dontmove.wav"),500)
         end
end
hook.Add("PlayerSay","CallForDontMove_ChatHook",CallForDontMove)

function CallForSecond(ply, say, teamsay)
         if string.find(say, "second") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/thisisyoursecondwarning.wav"),500)
         end
end
hook.Add("PlayerSay","CallForSecond_ChatHook",CallForSecond)

function CallForFirst(ply, say, teamsay)
         if string.find(say, "first") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/firstwarningmove.wav"),500)
         end
end
hook.Add("PlayerSay","CallForFirst_ChatHook",CallForFirst)

function CallForComeWithMe(ply, say, teamsay)
         if string.find(say, "come") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("vo/trainyard/ba_youcomewith.wav"),500)
         end
end
hook.Add("PlayerSay","CallForComeWithMe_ChatHook",CallForComeWithMe)

function CallForHold(ply, say, teamsay)
         if string.find(say, "holdit") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/holditrightthere.wav"),500)
         end
end
hook.Add("PlayerSay","CallForHold_ChatHook",CallForHold)

function CallForTake(ply, say, teamsay)
         if string.find(say, "takedown") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/takedown.wav"),500)
         end
end
hook.Add("PlayerSay","CallForTake_ChatHook",CallForTake)

function CallForFinal(ply, say, teamsay)
         if string.find(say, "final") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/finalwarning.wav"),500)
         end
end
hook.Add("PlayerSay","CallForFinal_ChatHook",CallForFinal)

function CallForKnock(ply, say, teamsay)
         if string.find(say, "knocked") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/youknockeditover.wav"),500)
         end
end
hook.Add("PlayerSay","CallForKnock_ChatHook",CallForKnock)

function CallForPick(ply, say, teamsay)
         if string.find(say, "pick") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/pickupthecan2.wav"),500)
         end
end
hook.Add("PlayerSay","CallForPick_ChatHook",CallForPick)

function CallForTrash(ply, say, teamsay)
         if string.find(say, "trash") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/putitinthetrash1.wav"),500)
         end
end
hook.Add("PlayerSay","CallForTrash_ChatHook",CallForTrash)

function CallForHeavyr(ply, say, teamsay)
         if string.find(say, "heavy") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/combine_soldier/vo/heavyresistance.wav"),500)
         end
end
hook.Add("PlayerSay","CallForHeavyr_ChatHook",CallForHeavyr)

function CallForTakeFire(ply, say, teamsay)
         if string.find(say, "officerfire") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/officerunderfiretakingcover.wav"),500)
         end
end
hook.Add("PlayerSay","CallForTakeFire_ChatHook",CallForTakeFire)

function CallForOfficerHelp(ply, say, teamsay)
         if string.find(say, "needhelp") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/officerneedshelp.wav"),500)
         end
end
hook.Add("PlayerSay","CallForOfficerHelp_ChatHook",CallForOfficerHelp)

function CallForFired(ply, say, teamsay)
         if string.find(say, "shots") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/shotsfiredhostilemalignants.wav"),500)
         end
end
hook.Add("PlayerSay","CallForFired_ChatHook",CallForFired)

function CallForNowGet(ply, say, teamsay)
         if string.find(say, "nowgetout") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/nowgetoutofhere.wav"),500)
         end
end
hook.Add("PlayerSay","CallForNowGet_ChatHook",CallForNowGet)

function CallForYouCanGo(ply, say, teamsay)
         if string.find(say, "youcango") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/allrightyoucango.wav"),500)
         end
end
hook.Add("PlayerSay","CallForYouCanGo_ChatHook",CallForYouCanGo)

function CallForha(ply, say, teamsay)
         if string.find(say, "ha") == 1 and ply:Team() == 2 then
            ply:EmitSound(Sound("npc/metropolice/vo/chuckle.wav"),500)
         end
end
hook.Add("PlayerSay","CallForha_ChatHook",CallForha)
