--es_extended/server/commands.lua
--Suche nach dem RegisterNetEvent 'ESX.RegisterCommand('car', 'admin',' sowie 'ESX.RegisterCommand({'cardel', 'dv'}, 'admin','

--In Line 32 you can comment out the PRINT! Its to check the function for Plate
--In Line 33 we add the Export from Resource Kimi_Callbacks (resource is needed) for VKC, to Remove the TempKey
--In Line 34 you can comment out the PRINT! Its to check the function remove the TempKey after delete vehicle via Command (/cardel)

ESX.RegisterCommand('car', 'admin', function(xPlayer, args, showError)
	local GameBuild = tonumber(GetConvar("sv_enforceGameBuild", 1604))
	if not args.car then args.car = GameBuild >= 2699 and "draugur" or "prototipo" end
	ESX.DiscordLogFields("UserActions", "/car Triggered", "pink", {
		{name = "Player", value = xPlayer.name, inline = true},
		{name = "ID", value = xPlayer.source, inline = true},
    {name = "Vehicle", value = args.car, inline = true}
	})
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car',validate = false, help = _U('command_car_car'), type = 'string'}
}})   --We ADD the TempKey via a Client Trigger and a Server-Event -Kimi Callback for VCK is Serverside

ESX.RegisterCommand({'cardel', 'dv'}, 'admin', function(xPlayer, args, showError)
	local Vehicles = ESX.OneSync.GetVehiclesInArea(xPlayer.getCoords(true), tonumber(args.radius) or 4)
	for i=1, #Vehicles do 
		local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
		if DoesEntityExist(Vehicle) then
			DeleteEntity(Vehicle)
		end
		print(GetVehicleNumberPlateText(Vehicle), type(GetVehicleNumberPlateText(Vehicle)))                           --We want to Check giving a Plate and waht type ist the plate- string etc.
		local success = exports["VehicleKeyChain"]:RemoveTempKey(xPlayer.source, GetVehicleNumberPlateText(Vehicle))  --VKC|Kimi Callbacks: Want to REMOVE a Temp-Key when Delete a Vehicle
		print('TempKey entfernt: '..tostring(success))                                                                --THIS Print say you if TempKey is successful removed Turn on to see in server-console
	end
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius',validate = false, help = _U('command_cardel_radius'), type = 'number'}
}})
