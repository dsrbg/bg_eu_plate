local plates = {
	[0] = "plate01",
	[1] = "plate02",
	[2] = "plate03",
	[3] = "plate04",
	[4] = "plate05",
	[5] = "yankton_plate",
	[6] = "plate_mod_01",
	[7] = "plate_mod_02",
	[8] = "plate_mod_03",
	[9] = "plate_mod_04",
	[10] = "plate_mod_05",
	[11] = "plate_mod_06",
	[12] = "plate_mod_07"
}
local runtimeTexture = "customPlates"
local defaultNormal = "defaultNormalTexture"
local vehShare = "vehshare"
local plateTxd = CreateRuntimeTxd(runtimeTexture)
CreateRuntimeTextureFromImage(plateTxd, defaultNormal, "plates/plateNormals.png")

for plateIndex, plateName in pairs(plates) do
	local cvarData = GetConvar("plate_override_" .. plateName, false)
	if cvarData then
		local plateOverride = json.decode(cvarData)
		local plateNormal = plateName .. "_n"
		
		if plateOverride.fileName then
			CreateRuntimeTextureFromImage(plateTxd, plateName, plateOverride.fileName)
			AddReplaceTexture(vehShare, plateName, runtimeTexture, plateName)
		end
		if plateOverride.normalName then
			CreateRuntimeTextureFromImage(plateTxd, plateNormal, plateOverride.normalName)
			AddReplaceTexture(vehShare, plateNormal, runtimeTexture, plateNormal)
		else
			AddReplaceTexture(vehShare, plateNormal, runtimeTexture, defaultNormal)
		end
		if plateOverride.pattern then
			SetDefaultVehicleNumberPlateTextPattern(plateIndex, plateOverride.pattern)
		end
	end
end