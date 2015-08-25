function MayorSetSalary( ply, cmd, args )
	if( CfgVars["mayorsetsalary"] == 0 ) then
		ply:PrintMessage( 2, "Mayor SetSalary Disabled By Admin!" );
		Notify( ply, 1, 3, "Mayor SetSalary Disabled By Admin!" );
		return "Mayor SetSalary Disabled By Admin!";
	end
	
	if( ply:Team() ~= 3 ) then 
		ply:PrintMessage( 2, "You Must be Mayor to use this function!" );
		return;
	end

	local amount = tonumber( args[2] );

	if( not amount ) then 
		if( ply:EntIndex() == 0 ) then
			Msg( "Invalid Salary: " .. args[2] );
		else
			ply:PrintMessage( 2, "Invalid Salary: " .. args[2] );
		end
		return; 
	end
	
	if( amount > GetGlobalInt("mayorsetsalary") ) then 
		if( ply:EntIndex() == 0 ) then
			Msg( "Salary must be below $" .. GetGlobalInt("mayorsetsalary") .. "!" );
		else
			ply:PrintMessage( 2, "Salary must be below: $" .. GetGlobalInt("mayorsetsalary") .."!" );
		end
		return; 
	end
	local target = FindPlayer( args[1] );
	
	if( target ) then
		if( target:Team() == 3 ) then
			Notify( ply, 1, 3, "Cannot set Any Mayor's Salary!" );
			return "Cannot set Any Mayor's Salary!";
		
		elseif( target:Team() == 2 or target:Team() == 9 ) then
			if( amount > GetGlobalInt("maxcopsalary") ) then
				return "Police salary Limit: $" .. GetGlobalInt("maxcopsalary") .. "!";
			else
				local nick = "";
			
				rpsetSalary(target, amount);
				target:SetNWInt("salary", amount)
				if( ply:EntIndex() == 0 ) then
					Msg( "Set " .. target:Nick() .. "'s Salary to: $" .. amount );
					nick = "Console";
				else
					ply:PrintMessage( 2, "Set " .. target:Nick() .. "'s Salary to: $" .. amount );
					nick = ply:Nick();
				end
				target:PrintMessage( 2, nick .. " set your Salary to: $" .. amount );
				
			end
		elseif( target:Team() == 1 or target:Team() == 6 or target:Team() == 7 or target:Team() == 8 ) then
			if( amount > GetGlobalInt("maxnormsalary") ) then
				return "Normal Player salary Limit: $" .. GetGlobalInt("maxnormsalary") .. "!";
			else
				local nick = "";
				rpsetSalary(target, amount);
				target:SetNWInt("salary", amount)
				if( ply:EntIndex() == 0 ) then
					Msg( "Set " .. target:Nick() .. "'s Salary to: $" .. amount );
					nick = "Console";
				else
					ply:PrintMessage( 2, "Set " .. target:Nick() .. "'s Salary to: $" .. amount );
					nick = ply:Nick();
				end
				target:PrintMessage( 2, nick .. " set your Salary to: $" .. amount );
			end
		elseif( target:Team() == 4 or target:Team() == 5 ) then
			return "Mayor cannot set a Gang Banger's Salary";
		else
			return "Player Not on a Team Yet!";
		end
	elseif( ply:EntIndex() == 0 ) then
		Msg( "Did not find player: " .. args[1] );
	else
		ply:PrintMessage( 2, "Did not find player: " .. args[1] );
	end
	return;
end
concommand.Add( "mayor_setsalary", MayorSetSalary );

function MayorSetCPBudget( ply, cmd, args )
	local amount = tostring( args[1] );
	if( ply:Team() ~= 3 ) then
		Notify( ply, 1, 3, "You must be Mayor to Use this function" );
		return;
	else
		if( amount > GetGlobalInt("maxcpbudget") ) then
			Notify( ply, 1, 3, "Maximum CP budget: " .. GetGlobalInt("maxcpbudget") .. "" );
			return;
		else
			setcpbudget( amount )
			Notify( ply, 1, 3, "Civil Protection Budget Set To: $" .. amount .. "" );
			return "Civil Protection Budget Set To: $" .. amount .. "";
		end
	end
end
concommand.Add( "mayor_setcpbudget", MayorSetCPBudget );

function SetBail( target, amount )
local IDSteam = string.gsub(target:SteamID(), ":", "")

file.Write( "ZombRP/temp/" .. IDSteam .. ".txt", amount )
target:SetNWFloat("mybail", amount)
end
concommand.Add( "cp_setbail", SetBail );

function CPSetBail( ply, cmd, args )
	if( ply:Team() ~= 9 ) then 
		Notify( ply, 1, 4, "You Must be Police Chief to use this function!" );
		return "You Must be Police Chief to use this function!";
	end
	local setterID = string.gsub(ply:SteamID(), ":", "")
	if( file.Exists("ZombRP/temp/jail/" .. setterID .. ".txt") )then
		Notify( ply, 1, 4, "Police Chief Cannot Set Bails While Arrested!" );
		return "Military Cannot Set Bails While Arrested!";

	end
	local amount = tonumber( args[2] );

	if( not amount ) then
		if( ply:EntIndex() == 0 ) then
			Msg( "Invalid Bail: " .. args[2] );
		else
			ply:PrintMessage( 2, "Invalid Bail: " .. args[2] );
		end
		return; 
	end
	
	if( amount > GetGlobalInt("maxbail") ) then 
		if( ply:EntIndex() == 0 ) then
			Msg( "Bail must be below $" .. GetGlobalInt("maxbail") .. "!" );
		else
			ply:PrintMessage( 2, "Bail must be below: $" .. GetGlobalInt("maxbail") .."!" );
		end
		return; 
	end
	local target = FindPlayer( args[1] );
	
	if( target ) then
		if( file.Exists("ZombRP/temp/jail/" .. setterID .. ".txt") )then
			SetBail( target, amount )
			Msg( "Player: " .. target .. "'s Bail Set To: " .. amount .. " Seconds" );
		else
			return "Player Has To Be Arrested to Have a Bail!";
		end
	elseif( ply:EntIndex() == 0 )then
		Msg( "Did not find player: " .. args[1] );
	else
		ply:PrintMessage( 2, "Did not find player: " .. args[1] );
	end
	return;
end
concommand.Add( "cp_setbail", CPSetBail );
