--GTFO PLEASE

function Notify( ply, msgtype, len, msg )
ply:PrintMessage( 2, msg );
umsg.Start("fixedNotify",ply);
umsg.String(msg)
umsg.Long(msgtype)
umsg.Long(len)
umsg.End()
end

function NotifyAll( msgtype, len, msg )

	for k, v in pairs( player.GetAll() ) do
		
		Notify( v, msgtype, len, msg );
		
	end

end

function PrintMessageAll( msgtype, msg )

	for k, v in pairs( player.GetAll() ) do
	
		v:PrintMessage( msgtype, msg );
	
	end

end

function TalkToRange( msg, pos, size )

	local ents = ents.FindInSphere( pos, size );
	
	for k, v in pairs( ents ) do
	
		if( v:IsPlayer() ) then
		
			v:ChatPrint( msg );
			v:PrintMessage( 2, msg );
		
		end
	
	end

end

function FindPlayer( info )

	for k, v in pairs( player.GetAll() ) do
		
		if( tonumber( info ) == v:EntIndex() ) then
			return v;
		end
		
		if( info == v:SteamID() ) then
			return v;
		end
		
		if( string.find( v:Nick(), info ) ~= nil ) then
			return v;
		end
		
	end
	
	return nil;

end

