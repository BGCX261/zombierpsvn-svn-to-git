function DoNothing( ply, args )

	ply:PrintMessage( 2, "Leave if you are going to be AFK!" );
	
	return "";
	
end

AddChatCommand( "/donothing", DoNothing );