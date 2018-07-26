include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 200000 then return end

	local owning_ent = self:Getowning_ent()
	local owner = IsValid(owning_ent) and owning_ent:Nick() or "KyyYE"

	local pos = self:LocalToWorld(Vector(-6,0,1))
	local ang = self:LocalToWorldAngles(Angle(0,90,15))
	
	self.curBattery = self:GetNW2Float("Battery")
	self.curBatteryD = self.curBattery / 100


	cam.Start3D2D(pos + ang:Up() * 30, ang, 0.08)
		-- Main square
		draw.RoundedBox(3, -210, -141, 420, 250, Color(90, 90, 90, 255)) -- Outline
		draw.RoundedBox(3, -210, -141, 420, 250, Color(30, 30, 30, 255))

		-- Owner box
		draw.RoundedBox(3, -117, -138, 240, 36, Color(255, 255, 255, 10)) -- Outline
		draw.RoundedBox(3, -115, -136, 236, 32, Color(30, 30, 30, 255))

		-- Printer Name box
		draw.RoundedBox(3, -117, -84, 240, 36, Color(255, 255, 255, 10))-- Outline
		draw.RoundedBox(3, -115, -82, 236, 32, Color(30, 30, 30, 255))

		-- Money box
		draw.RoundedBox(3, -117, -37, 240, 74, Color(255, 255, 255, 10)) -- Outline
		draw.RoundedBox(3, -115, -35, 236, 70, Color(30, 30, 30, 255))

		-- Collect Money box
		draw.RoundedBox(3, -87, 10, 180, 21, Color(90, 90, 90, 255)) -- Outline
		draw.RoundedBox(3, -85, 12, 176, 17, Color(55, 180, 55, 255))
		draw.SimpleText("Collect", "PrinterFontMoneyCollect", 0, 20, Color(255, 255, 255, 255), 1, 1)

		-- Battery box
		draw.RoundedBox(3, -212, -142, 84.2, 228, Color(255, 255, 255, 10)) -- Outline
		draw.RoundedBox(3, -210, -140, 80, 224, Color(30, 30, 30, 255))
	
		
		draw.RoundedBox(1, -175, -90, 10, 130, Color(90, 90, 90, 255)) -- Battery bar outline
		if self.curBattery > 0 then
			-- draw.RoundedBox(1, -175, -85 * math.Clamp(self.curBatteryD, 1, 1), 10, 125, Color(55, 255, 55, 255)) -- Battery bar
						-- draw.SimpleText(math.Round(self.curBattery) .. "%", "PrinterFontMoneyCollect", -163, -82 * math.Clamp(self.curBatteryD, 0, 1), Color(255, 255, 255, 255), 0, 1)

			draw.RoundedBox(1, -175, -90 * math.Clamp(self.curBatteryD, 0, 1), 10, 15, Color(55, 255, 55, 255)) -- Battery bar
			draw.SimpleText("0%", "PrinterFontMoneyCollect", -180, 55, Color(255,255,255))
				draw.SimpleText("Battery", "PrinterFontMoneyCollect", -197, -120, Color(255, 255, 255, 255), 0, 1)
				draw.SimpleText("100%", "PrinterFontMoneyCollect", -190, -110, Color(255,255,255))
		end
			
			if self.curBattery < 1 then
			draw.SimpleText("100%", "PrinterFontMoneyCollect", -190, -110, Color(255,0,0))
			draw.SimpleText("Battery", "PrinterFontMoneyCollect", -197, -120, Color(255, 0, 0, 255), 0, 1)
			draw.SimpleText("0%", "PrinterFontMoneyCollect", -180, 55, Color(255,0,0))
		end
		if not self:GetNW2Bool("HasRecharger") then


			draw.RoundedBox(1, -115, 42, 96, 44, Color(90, 90, 90, 255)) -- Recharge outline
			draw.RoundedBox(1, -113, 44, 92, 40, Color(55, 180, 55, 255)) -- Recharge
			draw.SimpleText("Recharge", "PrinterRecharge2", -68, 54, Color(255, 255, 255, 255), 1, 1)
			draw.SimpleText("(" .. DarkRP.formatMoney(self.RechargePrice) .. ")", "PrinterRecharge2", -68, 72, Color(255, 255, 255, 255), 1, 1)
else
			draw.SimpleText("Solar Power", "PrinterRecharge2", -70, 50, Color(255, 255, 255, 255), 1, 1)
			draw.SimpleText("Installed", "PrinterRecharge2", -70, 70, Color(255, 255, 255, 255), 1, 1)
		end

			draw.RoundedBox(1, -18, 42, 42.5, 44, Color(255, 255, 255, 10)) -- Recharge outline
			draw.RoundedBox(1, -16, 44, 39, 40, Color(255, 0, 0, 255)) -- Recharge
			draw.SimpleText("SOS", "PrinterRecharge2", 3, 63, Color(255, 255, 255, 255), 1, 1)

		-- Cooler box
		self.curTemp = self:GetNW2Float("Temperature")
		self.tempColor = Color(0, 220, 255, 255)

		self.curTempD = self.curTemp / 75

		if self.curTemp < 30 then self.tempColor = Color(0, 220, 255, 255) end
		if self.curTemp >= 30 and self.curTemp < 60 then self.tempColor = Color(255, 157, 0, 255) end
		if self.curTemp >= 60 and self.curTemp < 100 then self.tempColor = Color(255, 50, 50, 255) end
		

		draw.RoundedBox(3, 133, -140, 77, 226, Color(255,255,255, 10)) -- Outline
		draw.RoundedBox(3, 135, -138, 73, 221, Color(30, 30, 30, 255))
		draw.SimpleText("Temperature", "PrinterTemperature", 136, -120, Color(255, 255, 255, 255), 0, 1)
		draw.SimpleText("100C", "PrinterTemperatureNumber", 153, -100, Color(255,0,0,255), 0, 1)
		draw.SimpleText("-20C", "PrinterTemperatureNumber", 153, 63, self.tempColor, 0, 1)
		if not self:GetNW2Bool("HasCooler") then
			-- (1, -107, 42, 92, 14
			draw.RoundedBox(1, 26, 42, 96, 44, Color(255, 255, 255, 10)) -- Buy cooler outline
			draw.RoundedBox(1, 28, 44, 92, 40, Color(30,144,255, 125)) -- Buy cooler
			draw.SimpleText("Cool", "PrinterRecharge2", 72, 54, Color(255, 255, 255, 255), 1, 1)
			draw.SimpleText("$" .. self.CoolPrice, "PrinterRecharge2", 73, 72, Color(255, 255, 255, 255), 1, 1)
		else
			draw.SimpleText("Cooler", "PrinterRecharge2", 80, 50, Color(255, 255, 255, 255), 1, 1)
			draw.SimpleText("Installed", "PrinterRecharge2", 82, 70, Color(255, 255, 255, 255), 1, 1)
		end
		draw.RoundedBox(1, 163, -90, 10, 130, Color(90, 90, 90, 255)) -- Temperature bar outline

	
		-- draw.SimpleText(math.Round(self.curTemp) .. "C", "PrinterFontMoneyCollect", 175, -78 * math.Clamp(self.curTempD, 0, 1),self.tempColor, 0, 1)
		draw.RoundedBox(1, 163, -90 * math.Clamp(self.curTempD, 0, 1), 10, 15, self.tempColor) -- Temperature bar
		

		draw.SimpleText(owner, "PrinterFontName", 0, -120, Color(255, 255, 255, 255), 1, 1)
		draw.SimpleText(self.PrintName, "PrinterFontName", 0, -67, self.PrinterColor, 1, 1)
		draw.SimpleText(DarkRP.formatMoney(self:GetNW2Int("MoneyStored")) .. "/" .. self.MaxStorage, "PrinterFontMoney", 0, -12, Color(255, 255, 255, 255), 1, 1)
	cam.End3D2D()
end
