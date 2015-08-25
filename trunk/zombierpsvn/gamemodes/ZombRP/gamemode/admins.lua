Admins = { }
Mayor = { }
CP = { }
Trader = { }
Tool = { }
Phys = { }
Prop = { }
function AddAdmin( steamid )
	Admins[steamid] = { }
end
function AddMayor( steamid )
	Mayor[steamid] = { }
end
function AddCP( steamid )
	CP[steamid] = { }
end
function AddTrader( steamid )
	Trader[steamid] = { }
end
function AddTool( steamid )
	Tool[steamid] = { }
end
function AddPhys( steamid )
	Phys[steamid] = { }
end
function AddProp( steamid )
	Prop[steamid] = { }
end
-------------------------------------
-- IGNORE EVERYTHING ABOVE THIS 
-------------------------------------

-------------------------------------
-- ADD ADMINS, MAYORS, AND CPS BELOW!
-------------------------------------
-- HOW TO ADD AN ADMIN:
-- AddAdmin( stm )

-- HOW TO ADD A MAYOR
-- AddMayor( stm )

-- HOW TO ADD A CP
-- AddCP( stm )

-- HOW TO ADD A TRADER
-- AddTrader( stm )

--A STEAMID LOOKS LIKE THIS:
-- STEAM_0:1:3903209

-- HOW TO GET A STEAM ID:
-- 1. JOIN AN INTERNET SERVER (NOT YOURS, UNLESS IT IS DEDICATED AND NON LAN)
-- 2. TYPE status IN CONSOLE
-- 3. IT WILL LIST STEAMIDS


--EXAMPLE:

AddAdmin( "" ); --Add them As an admin In the ZombRP Admin Commands.
AddMayor( "" ); --They Can Become Mayor Without a vote.
AddCP( "" ); --They Can Become CP Without a Vote
AddTrader( "" ); --They Can Become Trader
AddTool( "" ); --They Spawn with a toolgun all the time.
AddPhys( "" ); --They Spawn with a Physgun all the time.
AddProp( "" ); --They Can Always Spawn props, even when rp_propspawning is 0, Admins can do this Too if it is rp_propspawning 0

if( file.Exists( "ZombRP/privilege/tool.txt" ) ) then
	local stm = string.Explode( "\n", file.Read( "ZombRP/privilege/tool.txt" ) );
	for k, v in pairs( stm ) do
		if not (v == "") then
			Tool[v] = { }
		end
	end
end

if( file.Exists( "ZombRP/privilege/phys.txt" ) ) then
	local stm = string.Explode( "\n", file.Read( "ZombRP/privilege/phys.txt" ) );
	for k, v in pairs( stm ) do
		if not (v == "") then
			Phys[v] = { }
		end
	end
end

if( file.Exists( "ZombRP/privilege/admins.txt" ) ) then
	local stm = string.Explode( "\n", file.Read( "ZombRP/privilege/admins.txt" ) );
	for k, v in pairs( stm ) do
		if not (v == "") then
			Admins[v] = { }
		end
	end
end

if( file.Exists( "ZombRP/privilege/mayor.txt" ) ) then
	local stm = string.Explode( "\n", file.Read( "ZombRP/privilege/mayor.txt" ) );
	for k, v in pairs( stm ) do
		if not (v == "") then
			Mayor[v] = { }
		end
	end
end

if( file.Exists( "ZombRP/privilege/cp.txt" ) ) then
	local stm = string.Explode( "\n", file.Read( "ZombRP/privilege/cp.txt" ) );
	for k, v in pairs( stm ) do
		if not (v == "") then
			CP[v] = { }
		end
	end
end

if( file.Exists( "ZombRP/privilege/trader.txt" ) ) then
	local stm = string.Explode( "\n", file.Read( "ZombRP/privilege/trader.txt" ) );
	for k, v in pairs( stm ) do
		if not (v == "") then
			Trader[v] = { }
		end
	end
end

if( file.Exists( "ZombRP/privilege/prop.txt" ) ) then
	local stm = string.Explode( "\n", file.Read( "ZombRP/privilege/prop.txt" ) );
	for k, v in pairs( stm ) do
		if not (v == "") then
			Prop[v] = { }
		end
	end
end
