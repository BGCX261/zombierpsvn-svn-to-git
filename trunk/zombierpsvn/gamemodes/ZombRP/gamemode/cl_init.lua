DeriveGamemode( "sandbox" );

GUIToggled = false;
HelpToggled = false;

HelpLabels = { }
HelpCategories = { }

AdminTellAlpha = -1;
AdminTellStartTime = 0;
AdminTellMsg = "";

if( HelpVGUI ) then
	HelpVGUI:Remove();
end

HelpVGUI = nil;

StunStickFlashAlpha = -1;

function GM:Initialize()

	self.BaseClass:Initialize();

end

function LoadModules( msg )

	local num = msg:ReadShort();
	
	for n = 1, num do
	
		include( "ZombRP/gamemode/modules/" .. msg:ReadString() );
	
	end

end
usermessage.Hook( "LoadModules", LoadModules );

include( "shared.lua" );
include( "cl_vgui.lua" );
include( "entity.lua" );
include( "cl_scoreboard.lua" );
include( "cl_helpvgui.lua" );
include( "bugreport.lua" );

surface.CreateFont( "akbar", 20, 500, true, false, "AckBarWriting" );

--NO TOUCH.
function TakeNotify( um )
GAMEMODE:AddNotify(um:ReadString(), um:ReadLong(), um:ReadLong())
end
usermessage.Hook("fixedNotify", TakeNotify)
--Keeps servers from getting attacked, and keeps them safe.

function GetTextHeight( font, str )

	surface.SetFont( font );
	local w, h = surface.GetTextSize( str );
	
	return h;
	
end

function DrawPlayerInfo( ply )

	if( not ply:Alive() ) then return; end

	local pos = ply:EyePos();
				
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
				
	if( GetGlobalInt( "nametag" ) == 1 ) then
		draw.DrawText( ply:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( ply:Nick(), "TargetID", pos.x, pos.y, team.GetColor( ply:Team() ), 1 );
	end
					
	if( GetGlobalInt( "jobtag" ) == 1 ) then
		draw.DrawText( ply:GetNWString( "job" ), "TargetID", pos.x + 1, pos.y + 21, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( ply:GetNWString( "job" ), "TargetID", pos.x, pos.y + 20, Color( 255, 255, 255, 200 ), 1 );
	end

end

function DrawWarrantInfo( ply )

	if( not ply:Alive() ) then return; end

	local pos = ply:EyePos();
				
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
				
	if( GetGlobalInt( "nametag" ) == 1 ) then
		draw.DrawText( ply:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( ply:Nick(), "TargetID", pos.x, pos.y, team.GetColor( ply:Team() ), 1 );
	end
		draw.DrawText( "!", "TargetID", pos.x, pos.y - 20, Color( 255, 255, 255, 200 ), 1 );
		draw.DrawText( "!", "TargetID", pos.x + 1, pos.y - 21, Color( 255, 0, 0, 255 ), 1 );
		

end

function DrawZombieInfo( ply )

		for x=1, LocalPlayer():GetNWInt("numPoints"), 1 do
			local zPoint = LocalPlayer():GetNWVector( "zPoints" .. x)
			zPoint = zPoint:ToScreen();
			draw.DrawText( "Zombie Spawn (" .. x .. ")", "TargetID", zPoint.x, zPoint.y - 20, Color( 255, 255, 255, 200 ), 1 );
			draw.DrawText( "Zombie Spawn (" .. x .. ")", "TargetID", zPoint.x + 1, zPoint.y - 21, Color( 255, 0, 0, 255 ), 1 );
		end
end

function GM:HUDPaint()

	self.BaseClass:HUDPaint();
	
	local hx = 9;
	local hy = ScrH() - 25;
	local hw = 190;
	local hh = 10;
	
	draw.RoundedBox( 6, hx - 8, hy - 90, hw + 30, hh + 110, Color( 0, 0, 0, 100 ) );
	
	draw.RoundedBox( 6, hx - 4, hy - 4, hw + 8, hh + 8, Color( 0, 0, 0, 200 ) );
	
	if( LocalPlayer():Health() > 0 ) then
		draw.RoundedBox( 4, hx, hy, math.Clamp( hw * ( LocalPlayer():Health() / 100 ), 0, 190 ), hh, Color( 140, 0, 0, 180 ) );
	end
	
	draw.DrawText( LocalPlayer():Health(), "TargetID", hx + hw / 2, hy - 6, Color( 255, 255, 255, 200 ), 1 );
	
	--draw.DrawText( "Position: " .. LocalPlayer():GetNWString( "job" ) .. "\n$" .. LocalPlayer():GetNWInt( "money" ), "TargetID", hx - 1, hy - 49, Color( 0, 0, 0, 200 ), 0 );
	draw.DrawText( "Position: " .. LocalPlayer():GetNWString( "job" ) .. "\nCredits: $" .. LocalPlayer():GetNWInt( "money" ) .. "", "TargetID", hx + 1, hy - 49, Color( 0, 0, 0, 200 ), 0 );
	draw.DrawText( "Position: " .. LocalPlayer():GetNWString( "job" ) .. "\nCredits: $" .. LocalPlayer():GetNWInt( "money" ) .. "", "TargetID", hx, hy - 50, Color( 150, 0, 0, 255 ), 0 );
	draw.DrawText( "Reputation: " .. LocalPlayer():GetNWInt( "salary" ), "TargetID", hx + 1, hy - 70, Color( 0, 0, 0, 200 ), 0 );
	draw.DrawText( "Reputation: " .. LocalPlayer():GetNWInt( "salary" ), "TargetID", hx, hy - 71, Color( 150, 150, 0, 255 ), 0 );


	local function DrawDisplay()
				for k, v in pairs( player.GetAll() ) do
					if(v:GetNWBool("zombieToggle") == true) then
						DrawZombieInfo(v)
					end
					if(v:GetNWBool("warrant") == true) then
						DrawWarrantInfo( v )
					end
			
			end
			
		local tr = LocalPlayer():GetEyeTrace();
		
		if( GetGlobalInt( "globalshow" ) == 1 ) then
		
			for k, v in pairs( player.GetAll() ) do
			
				DrawPlayerInfo( v );
			
			end
		
		end
		
		if( tr.Entity:IsValid() && tr.Entity:GetPos():Distance( LocalPlayer():GetPos() ) < 400 ) then
		
			if( GetGlobalInt( "globalshow" ) == 0 ) then
		
				if( tr.Entity:IsPlayer() ) then
				
					DrawPlayerInfo( tr.Entity );
					
				end
				
			end
			
			if( tr.Entity:IsOwnable() ) then
			
				local ent = ents.GetByIndex( tr.Entity:EntIndex() );
			
				pos = LocalPlayer():GetEyeTrace().HitPos:ToScreen();
				
				local ownerstr = "";
				
				if( ent:GetNWInt( "Ownerz" ) > 0 ) then
					if( player.GetByID( ent:GetNWInt( "Ownerz" ) ):IsValid() ) then
						ownerstr = player.GetByID( ent:GetNWInt( "Ownerz" ) ):Nick() .. "\n";
					end
				end
				
				local num = ent:GetNWInt( "OwnerNumz" );
				
				for n = 1, num do
				
					if( ( ent:GetNWInt( "Ownersz" .. n ) or -1 ) > -1 ) then
						if( player.GetByID( ent:GetNWInt( "Ownersz" .. n ) ):IsValid() ) then
							ownerstr = ownerstr .. player.GetByID( ent:GetNWInt( "Ownersz" .. n ) ):Nick() .. "\n";
						end
					end
				
				end
				
				num = ent:GetNWInt( "AllowedNum" );
				
				for n = 1, num do
				
					if( ent:GetNWInt( "Allowed" .. n ) == LocalPlayer():EntIndex() ) then
					
						ownerstr = ownerstr .. "You are allowed to co-own this door (Press F4 to own)";
					
					elseif( ent:GetNWInt( "Allowed" .. n ) > -1 ) then
					
						if( player.GetByID( ent:GetNWInt( "Allowed" .. n ) ):IsValid() ) then
							ownerstr = ownerstr .. player.GetByID( ent:GetNWInt( "Allowed" .. n ) ):Nick() .. " is allowed to co-own this door\n";
						end
					end
				
				end

				if( ent:IsOwned() ) then
					draw.DrawText( ent:GetNWString( "title" ) .. "\nOwned by:\n" .. ownerstr, "TargetID", pos.x + 1, pos.y + 1, Color( 0,  0, 0, 200 ), 1 );
					draw.DrawText( ent:GetNWString( "title" ) .. "\nOwned by:\n" .. ownerstr, "TargetID", pos.x, pos.y, Color( 255, 255, 255, 200 ), 1 );
				else
					draw.DrawText( "Unowned (Press F4 to own)", "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
					draw.DrawText( "Unowned (Press F4 to own)", "TargetID", pos.x, pos.y, Color( 128, 30, 30, 255 ), 1 );
				end
			
			end
	
		end

		if( PanelNum > 0 ) then
		
			draw.RoundedBox( 2, 0, 0, 100, 20, Color( 0, 0, 0, 128 ) );
			draw.DrawText( "Hit F3 to vote", "ChatFont", 2, 2, Color( 255, 255, 255, 200 ), 0 );
		
		end
		
	end
	
	if( LetterAlpha > -1 ) then
	
		if( LetterY > ScrH() * .25 ) then
		
			LetterY = math.Clamp( LetterY - 300 * FrameTime(), ScrH() * .25, ScrH() / 2 );
		
		end
		
		if( LetterAlpha < 255 ) then
		
			LetterAlpha = math.Clamp( LetterAlpha + 400 * FrameTime(), 0, 255 );
		
		end
		
		local font = "";
		
		if( LetterType == 1 ) then
			font = "AckBarWriting";
		else
			font = "Default";
		end
		
		draw.RoundedBox( 2, ScrW() * .2, LetterY, ScrW() * .8 - ( ScrW() * .2 ), ScrH(), Color( 255, 255, 255, math.Clamp( LetterAlpha, 0, 200 ) ) );
		draw.DrawText( LetterMsg, font, ScrW() * .25 + 20, LetterY + 80, Color( 0, 0, 0, LetterAlpha ), 0 );
	
	end
	
	DrawDisplay();
	
	if( StunStickFlashAlpha > -1 ) then
	
		surface.SetDrawColor( 255, 255, 255, StunStickFlashAlpha );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
	
		StunStickFlashAlpha = math.Clamp( StunStickFlashAlpha + 1500 * FrameTime(), 0, 255 );
	
	end
	
	if( AdminTellAlpha > -1 ) then
	
		local dir = 1;
		
		if( CurTime() - AdminTellStartTime > 10 ) then
			dir = -1;
			
			if( AdminTellAlpha <= 0 ) then
				AdminTellAlpha = -1;
			end
			
		end
		
		if( AdminTellAlpha > -1 ) then
		
			AdminTellAlpha = math.Clamp( AdminTellAlpha + FrameTime() * dir * 300, 0, 190 );
		
			draw.RoundedBox( 4, 10, 10, ScrW() - 20, 100, Color( 0, 0, 0, AdminTellAlpha ) );
			draw.DrawText( "The Admin Tells You:", "GModToolName", ScrW() / 2 + 10, 10, Color( 255, 255, 255, AdminTellAlpha ), 1 );
			draw.DrawText( AdminTellMsg, "ChatFont", ScrW() / 2 + 10, 65, Color( 200, 30, 30, AdminTellAlpha ), 1 );
		
		end
	
		if( not LocalPlayer():Alive() )then
			draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color(0,0,0,255) );
			draw.SimpleText( "New Life Rule: Do Not Revenge Arrest/Kill.", "ChatFont", ScrW() / 2 +10, ScrH() / 2 - 5, Color(200,0,0,255),1 );
		end
	end
	
	
	if(LocalPlayer():GetNetworkedBool("helpMenu") == true) then

draw.RoundedBox(10, 10, 10, 860, 594, Color(0, 0, 0, 255))  
draw.RoundedBox(10, 12, 12, 856, 590, Color(51, 58, 51, 200))  
draw.RoundedBox(10, 12, 12, 856, 20, Color(0, 0, 70, 200))  
draw.DrawText("Server commands - # of Connected Players:" .. #player.GetAll( ) .. "/" .. MaxPlayers( ) .. "", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 

draw.DrawText("--Actions and OOC--\n/*, /emote, /action, /dome - for in character Actions.\n//, /ooc, /a - for OOC Chat\n/[[, .//, /local - for local OOC chat\n\n--Chat Commands--\n/buydruglab ($" .. tostring(GetGlobalInt("druglabcost")) .. ") -DRUUUGSSS (Earns you $" .. tostring(GetGlobalInt("drugpayamount")) .. " a minute.)\n/buymicrowave ($" .. tostring(GetGlobalInt("microwavecost")) .. ") -Scientist ONLY (Earns you $" .. tostring(GetGlobalInt("microwavefood")) .. " a sale.)\n/buygunlab ($" .. tostring(GetGlobalInt("gunlabcost")) .. ") -Trader ONLY (Earns you $" .. tostring(GetGlobalInt("p228cost")) .. " a sale.)\n/buyhealth ($" .. tostring(GetGlobalInt("healthcost")) .. ")\n/drop drops the weapon you are holding.\n\n--Classes--\n/biotec Makes you part of the BioTec Institute\n/doctor - Makes you a Medic\n/trader - Makes you a Trader\n/scientist -Makes you a scientist\n/zombify - Makes you a zombieeee!!!\n\n--Votes and Help Cmds--\n/votecop - Vote to elect yourself as cop\n/votemayor - vote to elect yourself as mayor\n/sleep - to sleep (you will lose extra weapons)\n/cophelp - help for Cops\n/traderhelp - help for traders\n/mayorhelp - help for mayors\n/adminhelp list of admin commands\n\n--Radio stuff--\n/m, /militarytalk, /militalk, /mtalk - for military only radio\n/b, /biotectalk, /biotalk, /btalk - for BioTec only radio\n/z, /zombietalk, /ztalk - for zombie only communication\n/r, /rtalk, /radio - for default everyone radio.", "ScoreboardText", 30, 30, Color(255,255,255,255),0)

end

	if(LocalPlayer():GetNetworkedBool("helpCop") == true) then

draw.RoundedBox(10, 10, 10, 590, 194, Color(0, 0, 0, 255))  
draw.RoundedBox(10, 12, 12, 586, 190, Color(51, 58, 51, 200))  
draw.RoundedBox(10, 12, 12, 586, 20, Color(0, 0, 70, 200))  
draw.DrawText("Cop Help", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 

draw.DrawText("Things Cops need to know-\n-Please don't abuse your job\n-When you arrest someone they are auto transported to jail.\n-They are auto let out of jail after " .. GetGlobalInt("jailtimer") .. " seconds\n-Type /playerwarrant USERID to set a warant for a player.\n-Type /playerunwarrant USERID to remover a warrant for a player.\n-TYPE status IN CONSOLE TO SEE THE USERID (ex. /playerwarrant 14)\n-Type /jailpos to set the Jailposition\n-Type /cophelp to toggle this menu.", "ScoreboardText", 30, 35, Color(255,255,255,255),0)

end

	if(LocalPlayer():GetNetworkedBool("helpMayor") == true) then

draw.RoundedBox(10, 10, 10, 590, 158, Color(0, 0, 0, 255))  
draw.RoundedBox(10, 12, 12, 586, 154, Color(51, 58, 51, 200))  
draw.RoundedBox(10, 12, 12, 586, 20, Color(0, 0, 70, 200))  
draw.DrawText("Mayor Help", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 

draw.DrawText("Type /lockdown to initiate a Quarantine(zombs)\nType /mayorhelp to close this", "ScoreboardText", 30, 35, Color(255,255,255,255),0)

end

	if(LocalPlayer():GetNetworkedBool("helptrader") == true) then

draw.RoundedBox(10, 10, 10, 590, 158, Color(0, 0, 0, 255))  
draw.RoundedBox(10, 12, 12, 586, 154, Color(51, 58, 51, 200))  
draw.RoundedBox(10, 12, 12, 586, 20, Color(0, 0, 70, 200))  
draw.DrawText("Trader Help", "ScoreboardText", 30, 10, Color(255,0,0,255),0) 

draw.DrawText("(Basically you just sell stuff.) \nUse /buyshipment and /buypistol to buy, with the name afterwards.\nPistols: 9mm, silenced9mm, deagle, silencedeagle, 56mm, autopistol, revolver\nShotguns: shotgun, huntingrifle, slugrifle\nAuto: p90, uzi, silenceduzi, lar, smg, autorifle\n Snipers: 30cal, 50cal\nType /traderhelp to close this", "ScoreboardText", 30, 35, Color(255,255,255,255),0)

end

if(LocalPlayer():GetNetworkedBool("helpAdmin") == true) then

draw.RoundedBox(10, 10, 10, 560, 260, Color(0, 0, 0, 255))  
draw.RoundedBox(10, 12, 12, 556, 256, Color(51, 58, 51, 200))  
draw.RoundedBox(10, 12, 12, 556, 20, Color(0, 0, 70, 200))  
draw.DrawText("Admin Help", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 

draw.DrawText("/zombiehelp Shows you how to setup zombie mode\n/enablestorm enables meteor storms\n/disablestorm Disables meteor storms\n\nYou can change the price of weapons, jailtimer, max gangsters, ect.\nTo do this press F1 then scroll down and you will see all of the console commands\nIf you edit the init.lua file you can save the vars.\n/jailpos sets the jailposition!\n/setspawn <team> - Enter teamname Ex. police, mayor, gangster\n/adminhelp toggles this menu.", "ScoreboardText", 30, 35, Color(255,255,255,255),0)

end

	if(LocalPlayer():GetNetworkedBool("helpZombie") == true) then

draw.RoundedBox(10, 10, 10, 860, 230, Color(0, 0, 0, 255))  
draw.RoundedBox(10, 12, 12, 856, 226, Color(51, 58, 51, 200))  
draw.RoundedBox(10, 12, 12, 856, 20, Color(0, 0, 70, 200))  
draw.DrawText("Zombie Help", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 

draw.DrawText("/addzombie (creates a zombie spawn)\n/removezombie index (removes a zombie spawn, index is the number inside ()\n/showzombie (shows where the zombie spawns are)\n/enablezombie (enables zombiemode)\n/disablezombie (disables zombiemode)\n/zombiehelp (toggles this menu)\n\nAll the zombie commands are admin only, the spawns are saved on different maps so you\ncan have a different set of zombie spawns depending on which map you are on.\nThe zombie spawns file is located in garrysmod/data/ZombRP if it ever becomes corrupt just delete it.", "ScoreboardText", 30, 35, Color(255,255,255,255),0)

end

	if(LocalPlayer():GetNetworkedBool("helpBoss") == true) then

draw.RoundedBox(10, 10, 10, 560, 130, Color(0, 0, 0, 255))  
draw.RoundedBox(10, 12, 12, 556, 126, Color(51, 58, 51, 200))  
draw.RoundedBox(10, 12, 12, 556, 20, Color(0, 0, 70, 200))  
draw.DrawText("Mob Boss Help", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 

draw.DrawText("As a the Mob Boss you decide what you want the other Gangsters to do\nAlso you get a Unarrest Stick you can use to break people out of jail\n/agenda messagehere (Sets the Gangsters agenda use // the goto then next line)\nType /mobbosshelp to close this menu. ", "ScoreboardText", 30, 35, Color(255,255,255,255),0)

end
	
end

function GM:HUDDrawTargetID()

end

function GM:HUDShouldDraw( name )

	if( name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" ) then return false; end
	if( HelpToggled and name == "CHudChat" ) then return false; end
	
	return true;

end

function EndStunStickFlash()

	StunStickFlashAlpha = -1;

end

function StunStickFlash()

	if( StunStickFlashAlpha == -1  ) then
		StunStickFlashAlpha = 0;
	end
	
	timer.Create( LocalPlayer():EntIndex() .. "StunStickFlashTimer", .3, 1, EndStunStickFlash );

end
usermessage.Hook( "StunStickFlash", StunStickFlash );

function ToggleHelp()

	if( not HelpVGUI ) then
		HelpVGUI = vgui.Create( "HelpVGUI" );
	end
	
	HelpToggled = !HelpToggled;
	
	HelpVGUI.HelpX = HelpVGUI.StartHelpX;
	HelpVGUI:SetVisible( HelpToggled );
	gui.EnableScreenClicker( HelpToggled );

end
usermessage.Hook( "ToggleHelp", ToggleHelp );

function AdminTell( msg )

	AdminTellStartTime = CurTime();
	AdminTellAlpha = 0;
	AdminTellMsg = msg:ReadString();

end
usermessage.Hook( "AdminTell", AdminTell );

LetterY = 0;
LetterAlpha = -1;
LetterMsg = "";
LetterType = 0;
LetterStartTime = 0;
LetterPos = Vector( 0, 0, 0 );

function ShowLetter( msg )

	LetterType = msg:ReadShort();
	LetterPos = msg:ReadVector();
	LetterMsg = msg:ReadString();
	LetterY = ScrH() / 2;
	LetterAlpha = 0;
	LetterStartTime = CurTime();

end
usermessage.Hook( "ShowLetter", ShowLetter );

function GM:Think()

	if( LetterAlpha > -1 and LocalPlayer():GetPos():Distance( LetterPos ) > 125 ) then
	
		LetterAlpha = -1;
	
	end
end

function KillLetter( msg )

	LetterAlpha = -1;

end
usermessage.Hook( "KillLetter", KillLetter );

function UpdateHelp()

	function tDelayHelp()

		if( HelpVGUI ) then

			HelpVGUI:Remove();
			
			if( HelpToggled ) then
				HelpVGUI = vgui.Create( "HelpVGUI" );
			end
			
		end
	
	end
	
	timer.Simple( .5, tDelayHelp );
	
end
usermessage.Hook( "UpdateHelp", UpdateHelp );

function ToggleClicker()

	GUIToggled = !GUIToggled;

	gui.EnableScreenClicker( GUIToggled );

	for k, v in pairs( VoteVGUI ) do
	
		v:SetMouseInputEnabled( GUIToggled );
	
	end

end
usermessage.Hook( "ToggleClicker", ToggleClicker );

function AddHelpLabel( msg )

	local id = msg:ReadShort();
	local category = msg:ReadShort();
	local text = msg:ReadString();
	local constant = msg:ReadShort();
	
	local function tAddHelpLabel( id, category, text, constant )

		for k, v in pairs( HelpLabels ) do
		
			if( v.id == id ) then
			
				v.text = text;
				return;
			
			end
		
		end
		
		table.insert( HelpLabels, { id = id, category = category, text = text, constant = constant } );
		
	end
	
	timer.Simple( .01, tAddHelpLabel, id, category, text, constant );

end
usermessage.Hook( "AddHelpLabel", AddHelpLabel );

function ChangeHelpLabel( msg )

	local id = msg:ReadShort();
	local text = msg:ReadString();

	local function tChangeHelpLabel( id, text )
	
		for k, v in pairs( HelpLabels ) do
		
			if( v.id == id ) then
			
				v.text = text;
				return;
			
			end
		
		end
		
	end
	
	timer.Simple( .01, tChangeHelpLabel, id, text );

end
usermessage.Hook( "ChangeHelpLabel", ChangeHelpLabel );

function AddHelpCategory( msg )

	local id = msg:ReadShort();
	local text = msg:ReadString();
	
	local function tAddHelpCategory( id, text )
	
		table.insert( HelpCategories, { id = id, text = text } );

	end
		
	timer.Simple( .01, tAddHelpCategory, id, text );
		
end
usermessage.Hook( "AddHelpCategory", AddHelpCategory );
