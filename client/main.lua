--es_extended/client/main.lua

--Search for RegisterNetEvent 'esx:spawnVehicle'
-- Inside the TriggerServerCallbacks AFTER 'SetVehicleNeonLightsColour' Add:
TriggerServerEvent('esx:createTempKey', GetVehicleNumberPlateText(vehicle))

-- See Example in Line 45!
--We are Done here! Now we give a Temporary Key when spawn a car via Commands like /car XXXX (Works also in txAdmin)
--Kimis Exports works only Serverside! So to make it work with Esx 1.8.5, we trigger here an Event called 'esx:createTempKey' 

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicle)
	ESX.TriggerServerCallback("esx:isUserAdmin", function(admin)
		if admin then
			local model = (type(vehicle) == 'number' and vehicle or joaat(vehicle))

			if IsModelInCdimage(model) then
				local playerCoords, playerHeading = GetEntityCoords(ESX.PlayerData.ped), GetEntityHeading(ESX.PlayerData.ped)

				ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
					TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vehicle, -1)
					SetVehicleDirtLevel(vehicle, 0)
					SetVehicleFuelLevel(vehicle, 100.0)
					SetEntityAsMissionEntity(vehicle, true, true)				-- Persistant Vehicle

					if Config.MaxAdminVehicles then 													      -- Max out vehicle upgrades
						SetVehicleExplodesOnHighExplosionDamage(vehicle, true)
						SetVehicleModKit(vehicle, 0)
						SetVehicleMod(vehicle, 11, 3, true)				-- modEngine
						SetVehicleMod(vehicle, 12, 2, true)				-- modBrakes
						SetVehicleMod(vehicle, 13, 2, false)				-- modTransmission
						SetVehicleMod(vehicle, 15, 3, true)				-- modSuspension
						SetVehicleMod(vehicle, 16, 4, true)				-- modArmor
						ToggleVehicleMod(vehicle, 18, true)				-- modTurbo
						SetVehicleTurboPressure(vehicle, 100.0)
						SetVehicleNumberPlateText(vehicle, "SCL RP")			--SpawnedVehicle Numberplate
						SetVehicleNumberPlateTextIndex(vehicle, 1)
						SetVehicleNitroEnabled(vehicle, true)

						for i=0, 3 do
							SetVehicleNeonLightEnabled(vehicle, i, true)
						end
						SetVehicleNeonLightsColour(vehicle, 55, 140, 191)		-- ESX Blue
            
						TriggerServerEvent('esx:createTempKey', GetVehicleNumberPlateText(vehicle))	--Here we create a New separate Trigger the Server-Event for VKC called esx:createTempKey
					end
				end)
			else
				ESX.ShowNotification('Invalid vehicle model.')
			end
		end
	end)
end)
