function BugSpray( ply )

	local Framed = vgui.Create( "Frame" ); 
	Framed:SetName("Bug Reporting")
	Framed:SetPos(50,50)
	Framed:SetSize( ScrW() - 260 , ScrH() - 90 )
	Framed:SetVisible( true );  
	Framed:PostMessage( "SetTitle", "text", "Post A DarkRP Bug Report" );

	local HTMLTest = vgui.Create( "HTML", Framed )
	HTMLTest:SetPos(51,51)
	HTMLTest:SetSize(390,400)
	HTMLTest:SetVisible( true );
	HTMLTest:OpenURL( "http://home.wi.rr.com/levacrescue/bugreport/" ) 
	
end
--concommand.Add( "o_lolololwut", BugSpray ); 
