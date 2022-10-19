--We need to Register the ServerEvent, in this is the Export implemented to GIVE the Temp Key...
--We trigger that in client/main.lua
--Because Kimis Callbacks for VKC are made to be serverside, we need to go this way... Well, it works

--Add Lines 10-11-12-13-14 in your server/main.lua! Search for other 'RegisterServerEvent' and put this lines below the last.
--Lines 16-17-18-19 are comment out and currently NOT in use! Its just Preparation if the DeleteVehicle function will be changed by ESX, like the SpawnVehicle function.



RegisterServerEvent('esx:createTempKey')                                --For CREATE a Temp Key. This is needed to make sure the VCK Temp Key is working if you can only export Clientsided 
AddEventHandler('esx:createTempKey', function (plate)
local success = exports["VehicleKeyChain"]:AddTempKey(source, plate)
print('TempKey given: '..tostring(success))                             --THIS Print say you if TempKey is successful given! Turn on to see in server-console
end)

--RegisterServerEvent('esx:revokeTempKey')                              --For REMOVE a Temp Key. This is needed to make sure the VCK Temp Key is working if you can only export Clientsided 
--AddEventHandler('esx:revokeTempKey', function (plate)
--local success = exports["VehicleKeyChain"]:RemoveTempKey(source, plate)
--end)
