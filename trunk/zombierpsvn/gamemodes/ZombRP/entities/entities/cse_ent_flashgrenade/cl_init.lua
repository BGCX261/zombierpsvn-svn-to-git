
include('shared.lua')

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/
function ENT:Draw()
	self.Entity:DrawModel()
end


/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return true
end

lasthud = lasthud or 0
lastflash = lastflash or 0
pflash = pflash or 0
curflash = curflash or 0

function drawHudVital()
	local lfn = LocalPlayer():GetNetworkedFloat("flashed")
	if lfn ~= lastflash then
		lastflash = lfn
		curflash = math.abs(lfn)
		pflash = -1
	end
	
	curflash = curflash - (0.2 * (CurTime() - lasthud))
	if curflash < 0 then
		curflash = 0
		if pflash == -1 then
			pflash = 255
		end
	end
	
	if pflash ~= -1 then
		if pflash > 0 then
			pflash = pflash - (50 * (CurTime() - lasthud))
		end
		if pflash <= 0 then
			pflash = 0
		end
	end
	
	local cflash = 0
	if curflash > 0.05 then
		cflash = 255
	elseif pflash ~= 0 then
		cflash = pflash
	end
	surface.SetDrawColor(255,255,255,math.Round(cflash))
	surface.DrawRect(0,0,surface.ScreenWidth(),surface.ScreenHeight())
	//draw.SimpleText("FLASH: "..curflash,"TargetID",w*.5,h*.5,Color(255,255,255,255),0,0)
	
	lasthud = CurTime()
end

	hook.Add("HUDPaint","drawHudVital",drawHudVital)
