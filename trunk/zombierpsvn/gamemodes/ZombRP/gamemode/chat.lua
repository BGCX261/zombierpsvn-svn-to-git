
ChatCommands = { }

--Usage:
--Chat command, Callback, Should the prefix stay constant?
function AddChatCommand( cmd, callback, prefixconst )

	table.insert( ChatCommands, { cmd = cmd, callback = callback, prefixconst = prefixconst } );

end

function GM:PlayerSay( ply, text )

	self.BaseClass:PlayerSay( ply, text );

	local ftext = string.lower( text );
	
	for k, v in pairs( ChatCommands ) do
	
		local endpos = string.len( v.cmd );
		local strcmd = string.sub( ftext, 1, endpos );

		local argstart = 1;
		
		if( string.sub( text, endpos + 1, endpos + 1 ) == " " ) then
			argstart = 2;
		end
		
		if( strcmd == v.cmd ) then
			return v.callback( ply, string.sub( text, string.len( v.cmd ) + argstart ) or "" );
		end
	
	end
	
	if( CfgVars["alltalk"] == 0 ) then
		TalkToRange( ply:Nick() .. ": " .. text, ply:GetPos(), 250 );
		return "";
	end
	
	return text;

end
