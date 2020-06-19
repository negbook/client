
local luavehshare = {
"black",
"blank_normal",
"carbon_mesh_shader_spec",
"dinghyblack",
"dinghyblack_spec",
"epsilon_plate",
"plate01",
"plate01_n",
"plate02",
"plate02_n",
"plate03",
"plate03_n",
"plate04",
"plate04_n",
"plate05",
"plate05_n",
"plate06",
"plate06_n",
"plate07",
"plate07_n",
"plate08",
"plate08_n",
"plate09",
"plate10",
"plate10_n",
"plate11",
"plate12",
"plate13",
"plate13_n",
"plate14",
"plate14_n",
"plate15",
"plate15_n",
"plate16",
"plate16_n",
"plate17",
"plate17_n",
"plate18",
"plate18_n",
"plate19",
"plate19_n",
"plate20",
"plate21",
"plate22",
"plate22_n",
"plate23",
"plate23_n",
"plate24",
"plate24_n",
"plate25",
"plate25_n",
"plate26",
"plate27",
"plate28",
"plate29",
"plate29_n",
"plate30",
"plate30_n",
"plate31",
"plate32",
"plate32_n",
"plate33",
"plate34",
"plate35",
"plate36",
"plate37",
"plate38",
"plate38_n",
"plate39",
"plate40",
"plate40_n",
"plate41",
"plate41_n",
"plate42",
"plate42_n",
"plate43",
"plate44",
"plate44_n",
"plate45",
"plate45_n",
"plate46",
"plate46_n",
"plate47",
"plate47_n",
"plate48",
"plate48_n",
"plate50",
"plate50_n",
"plate51",
"plate51_n",
"plate52",
"plate52_n",
"plate53",
"plate53_n",
"police_new2",
"roof_dirt",
"vehicle_genericmud_car",
"vehicle_generic_alloy_silver_spec",
"vehicle_generic_black_plastic",
"vehicle_generic_burnt_int",
"vehicle_generic_burnt_out",
"vehicle_generic_carbon",
"vehicle_generic_detail2",
"vehicle_generic_detail2_normal",
"vehicle_generic_detail_spec",
"vehicle_generic_detail_stitch",
"vehicle_generic_detail_stitch_n",
"vehicle_generic_doorshut",
"vehicle_generic_doorshut_normal",
"vehicle_generic_glassdirt",
"vehicle_generic_glasswindows2",
"vehicle_generic_int_objects",
"vehicle_generic_leather2_n",
"vehicle_generic_plate_font",
"vehicle_generic_plate_font_n",
"vehicle_generic_smallspecmap",
"vehicle_generic_tyrewallblack",
"vehicle_generic_tyrewall_dirt",
"vehicle_generic_tyrewall_mod",
"vehicle_generic_tyrewall_mod_n",
"vehicle_generic_tyrewall_mod_s",
"vehicle_generic_tyrewall_mod_s2",
"vehicle_generic_tyrewall_normal",
"vehicle_generic_tyrewall_spec",
"yankton_plate",
"yankton_plate2",
"yankton_plate_n"
}

function LoadDict(dict)
    Citizen.CreateThread(function()
    RequestStreamedTextureDict(dict)
    while not HasStreamedTextureDictLoaded(dict) do Wait(100) end
        print("loaded"..dict)
        if dict == 'vehshare2' then 
                    for i,v in pairs(luavehshare) do 
                       AddReplaceTexture("vehshare", v , "vehshare2", v)
                       --print( (AddReplaceTexture("vehshare", v , "vehshare2", v) == false) and "replacevehshfail"..v or "replacevehsuccess")
                    end 
                end 
    end )
end
function LoadModel(dict)
    Citizen.CreateThread(function()
    RequestModel(dict)
    while not HasModelLoaded(dict) do Wait(100) end
        print("loaded"..dict)
    end )
end
LoadingList = {
"Shamal",
    "alt_vlight",
"cloudhat_alt_heavy",
"cloudhat_alt_light",
"cloudhat_alt_med",
"cloudhat_cirro",
"cloudhat_cirrus",
"cloudhat_clear01",
"cloudhat_cloudy",
"cloudhat_cloudy2",
"cloudhat_contrails",
"cloudhat_horizon",
"cloudhat_nimbus",
"cloudhat_puffs",
"cloudhat_rain",
"cloudhat_shower",
"cloudhat_stormy01",
"cloudhat_test",
"cloudhat_wispy",
"frontend",
"fxweather",
"prop_streetlight_01",
"prop_streetlight_03",
"prop_streetlight_03e",
"prop_trafficlight",
"prop_tree_birch_02",
"prop_veg_palm",
"prop_veg_palmfan_1",
"prop_veg_palmfan_2",
"prop_veg_palmfan_3",
"prop_walllight_09",
"skydome",
"sm1struc22",
"sm_22_ground",
"sm_22_splats1",
"venicebeachground",
"water",
"z_prop_pine_2",
"z_prop_tree_birch_01",
"z_prop_tree_ficus_3",
"z_prop_tree_oak1",
"z_prop_tree_olive_01",
"z_prop_tree_pine",
"z_tree_birch_03b",
"z_tree_pine3",
"ambulance",
"police",
"taxi1",
"taxi2",
"vehshare2"
}
LoadingListM = {
`Shamal`,
`ambulance`,
`police`,
`taxi1`,
`taxi2`,

}

local isPaused, isDead, pickups = false, false, {}
AddEventHandler('playerSpawned', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(10)
	end

	TriggerEvent('esx:restoreLoadout')

	if isFirstSpawn then
        if ESX.PlayerData.registered == true then 
            TriggerEvent('esx_skin:loadSkinOrCreate')
            ESX.Game.Teleport(PlayerPedId(), ESX.PlayerData.coords)
            TriggerEvent('spawn_manager:firstspawn')
            --TriggerEvent('localmessage','firstspawn')
            isFirstSpawn = false
             BeginTextCommandBusyspinnerOn("STRING")
            AddTextComponentString("載入資源中")
            EndTextCommandBusyspinnerOn(1)
            for i,v in pairs(LoadingList) do 
                LoadDict(v)
                
                Wait(100)
            end 
            for i,v in pairs(LoadingListM) do 
				if v ~= `Shamal` then 
					LoadModel(v)
				end 
                Wait(100)
            end 
            BusyspinnerOff()
            if IsScreenFadedOut() then
                    SetTimecycleModifier('hud_def_blur')
                    DoScreenFadeIn(1000)

                    while not IsScreenFadedIn() do
                        Citizen.Wait(0)
                    end
                    SetTimecycleModifier('default')
            end
        else 
            SetPedPropIndex(GetPlayerPed(-1), 0, 25, 0, 2)
                SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
                    SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
                    SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 4, 2) 		-- Undershirt
                    SetPedComponentVariation(GetPlayerPed(-1), 11, 6, 0, 2) 	-- Torso 2
                    
                    SetPedComponentVariation(GetPlayerPed(-1), 4, 78, 2, 2)
                
                SetPedComponentVariation(GetPlayerPed(-1), 6, 20, 0, 2)
            
            TriggerEvent('spawn_manager:firstspawn')
            --TriggerEvent('localmessage','firstspawn')
            isFirstSpawn = false
            --TriggerEvent('esx_identity:showRegisterIdentity')
            
           
            SetTimecycleModifier('default')
            Wait(1000)
			TriggerEvent('PlayCutscene','smun_intro')
			Wait(500)
            
			Wait(20000)
            DoScreenFadeOut(8000)
            for i,v in pairs(LoadingList) do 
                LoadDict(v)
                
                Wait(100)
            end 
            for i,v in pairs(LoadingListM) do 
                LoadModel(v)
                Wait(100)
            end 
            Wait(8000)
            SetTimecycleModifier('hud_def_blur')
            while not IsScreenFadedOut() or not HasCutsceneFinished() do
                Wait(0)
            end
            
            Wait(500)
            TriggerEvent('part1',false)
           -- TriggerEvent('localmessage','part1 going')
        end 
        
		
        
		
	end

	isLoadoutLoaded, isDead = true, false

	if Config.EnablePvP then
		SetCanAttackFriendly(PlayerPedId(), true, false)
		NetworkSetFriendlyFireOption(true)
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	ESX.PlayerLoaded = true
	ESX.PlayerData = playerData

	-- check if player is coming from loading screen
	if GetEntityModel(PlayerPedId()) == GetHashKey('PLAYER_ZERO') then
		local defaultModel = GetHashKey('a_m_y_stbla_02')
		RequestModel(defaultModel)

		while not HasModelLoaded(defaultModel) do
			Citizen.Wait(10)
		end

		SetPlayerModel(PlayerId(), defaultModel)
		SetPedDefaultComponentVariation(PlayerPedId())
		SetPedRandomComponentVariation(PlayerPedId(), true)
		SetModelAsNoLongerNeeded(defaultModel)
	end

	-- freeze the player
	FreezeEntityPosition(PlayerPedId(), true)

	-- enable PVP
	SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)

	-- disable wanted level
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)

	if Config.EnableHud then
		for k,v in ipairs(playerData.accounts) do
			local accountTpl = '<div><img src="img/accounts/' .. v.name .. '.png"/>&nbsp;{{money}}</div>'
			ESX.UI.HUD.RegisterElement('account_' .. v.name, k, 0, accountTpl, {money = ESX.Math.GroupDigits(v.money)})
		end

		local jobTpl = '<div>{{job_label}} - {{grade_label}}</div>'

		if playerData.job.grade_label == '' or playerData.job.grade_label == playerData.job.label then
			jobTpl = '<div>{{job_label}}</div>'
		end

		ESX.UI.HUD.RegisterElement('job', #playerData.accounts, 0, jobTpl, {
			job_label = playerData.job.label,
			grade_label = playerData.job.grade_label
		})
	end

	ESX.Game.Teleport(PlayerPedId(), {
		x = playerData.coords.x,
		y = playerData.coords.y,
		z = playerData.coords.z + 0.25,
		heading = playerData.coords.heading
	}, function()
		TriggerServerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:onPlayerSpawn')
		TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
		TriggerEvent('esx:restoreLoadout')

		Citizen.Wait(4000)
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		FreezeEntityPosition(PlayerPedId(), false)
		DoScreenFadeIn(10000)
		StartServerSyncLoops()
	end)

	TriggerEvent('esx:loadingScreenOff')
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight) ESX.PlayerData.maxWeight = newMaxWeight end)

AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(100)
	end

	TriggerEvent('esx:restoreLoadout')
end)

AddEventHandler('esx:restoreLoadout', function()
	local playerPed = PlayerPedId()
	local ammoTypes = {}
	RemoveAllPedWeapons(playerPed, true)

	for k,v in ipairs(ESX.PlayerData.loadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)

		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		SetPedWeaponTintIndex(playerPed, weaponHash, v.tintIndex)

		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for k2,v2 in ipairs(v.components) do
			local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash
			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, v.ammo)
			ammoTypes[ammoType] = true
		end
	end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end

	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('account_' .. account.name, {
			money = ESX.Math.GroupDigits(account.money)
		})
	end
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count, showNotification)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.UI.ShowInventoryItemNotification(true, v.label, count - v.count)
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end

	if showNotification then
		ESX.UI.ShowInventoryItemNotification(true, item, count)
	end

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count, showNotification)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.UI.ShowInventoryItemNotification(false, v.label, v.count - count)
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end

	if showNotification then
		ESX.UI.ShowInventoryItemNotification(false, item, count)
	end

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:setWeaponAmmo')
AddEventHandler('esx:setWeaponAmmo', function(weaponName, weaponAmmo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	SetPedAmmo(playerPed, weaponHash, weaponAmmo)
end)

RegisterNetEvent('esx:setWeaponTint')
AddEventHandler('esx:setWeaponTint', function(weaponName, weaponTintIndex)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	SetPedWeaponTintIndex(playerPed, weaponHash, weaponTintIndex)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	RemoveWeaponFromPed(playerPed, weaponHash)
	SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
end)

RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(coords)
	local playerPed = PlayerPedId()

	-- ensure decmial number
	coords.x = coords.x + 0.0
	coords.y = coords.y + 0.0
	coords.z = coords.z + 0.0

	ESX.Game.Teleport(playerPed, coords)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('job', {
			job_label = job.label,
			grade_label = job.grade_label
		})
	end
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicleName)
	local model = (type(vehicleName) == 'number' and vehicleName or GetHashKey(vehicleName))

	if IsModelInCdimage(model) then
		local playerPed = PlayerPedId()
		local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

		ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	else
		TriggerEvent('chat:addMessage', {args = {'^1SYSTEM', 'Invalid vehicle model.'}})
	end
end)

RegisterNetEvent('esx:createPickup')
AddEventHandler('esx:createPickup', function(pickupId, label, coords, type, name, components, tintIndex)
	local function setObjectProperties(object)
		SetEntityAsMissionEntity(object, true, false)
		PlaceObjectOnGroundProperly(object)
		FreezeEntityPosition(object, true)
		SetEntityCollision(object, false, true)

		pickups[pickupId] = {
			obj = object,
			label = label,
			inRange = false,
			coords = vector3(coords.x, coords.y, coords.z)
		}
	end

	if type == 'item_weapon' then
		local weaponHash = GetHashKey(name)
		ESX.Streaming.RequestWeaponAsset(weaponHash)
		local pickupObject = CreateWeaponObject(weaponHash, 50, coords.x, coords.y, coords.z, true, 1.0, 0)
		SetWeaponObjectTintIndex(pickupObject, tintIndex)

		for k,v in ipairs(components) do
			local component = ESX.GetWeaponComponent(name, v)
			GiveWeaponComponentToWeaponObject(pickupObject, component.hash)
		end

		setObjectProperties(pickupObject)
	else
		ESX.Game.SpawnLocalObject('prop_money_bag_01', coords, setObjectProperties)
	end
end)

RegisterNetEvent('esx:createMissingPickups')
AddEventHandler('esx:createMissingPickups', function(missingPickups)
	for pickupId,pickup in pairs(missingPickups) do
		TriggerEvent('esx:createPickup', pickupId, pickup.label, pickup.coords, pickup.type, pickup.name, pickup.components, pickup.tintIndex)
	end
end)

RegisterNetEvent('esx:registerSuggestions')
AddEventHandler('esx:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('esx:removePickup')
AddEventHandler('esx:removePickup', function(pickupId)
	if pickups[pickupId] and pickups[pickupId].obj then
		ESX.Game.DeleteObject(pickups[pickupId].obj)
		pickups[pickupId] = nil
	end
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(radius)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				ESX.Game.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end)

-- Pause menu disables HUD display
if Config.EnableHud then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(300)

			if IsPauseMenuActive() and not isPaused then
				isPaused = true
				ESX.UI.HUD.SetDisplay(0.0)
			elseif not IsPauseMenuActive() and isPaused then
				isPaused = false
				ESX.UI.HUD.SetDisplay(1.0)
			end
		end
	end)

	AddEventHandler('esx:loadingScreenOff', function()
		ESX.UI.HUD.SetDisplay(1.0)
	end)
end

function StartServerSyncLoops()
	-- keep track of ammo
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			if isDead then
				Citizen.Wait(500)
			else
				local playerPed = PlayerPedId()

				if IsPedShooting(playerPed) then
					local _,weaponHash = GetCurrentPedWeapon(playerPed, true)
					local weapon = ESX.GetWeaponFromHash(weaponHash)

					if weapon then
						local ammoCount = GetAmmoInPedWeapon(playerPed, weaponHash)
						TriggerServerEvent('esx:updateWeaponAmmo', weapon.name, ammoCount)
					end
				end
			end
		end
	end)

	-- sync current player coords with server
	Citizen.CreateThread(function()
		local previousCoords = vector3(ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)

		while true do
			Citizen.Wait(1000)
			local playerPed = PlayerPedId()

			if DoesEntityExist(playerPed) then
				local playerCoords = GetEntityCoords(playerPed)
				local distance = #(playerCoords - previousCoords)

				if distance > 1 then
					previousCoords = playerCoords
					local playerHeading = ESX.Math.Round(GetEntityHeading(playerPed), 1)
					local formattedCoords = {x = ESX.Math.Round(playerCoords.x, 1), y = ESX.Math.Round(playerCoords.y, 1), z = ESX.Math.Round(playerCoords.z, 1), heading = playerHeading}
					TriggerServerEvent('esx:updateCoords', formattedCoords)
				end
			end
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 289) then
			if IsInputDisabled(0) and not isDead and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
				--ESX.ShowInventory()
                TriggerEvent('HaTE:items')
			end
		end
	end
end)

-- Pickups
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords, letSleep = GetEntityCoords(playerPed), true
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer(playerCoords)

		for pickupId,pickup in pairs(pickups) do
			local distance = #(playerCoords - pickup.coords)

			if distance < 5 then
				local label = pickup.label
				letSleep = false

				if distance < 1 then
					if IsControlJustReleased(0, 38) then
						if IsPedOnFoot(playerPed) and (closestDistance == -1 or closestDistance > 3) and not pickup.inRange then
							pickup.inRange = true

							local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
							ESX.Streaming.RequestAnimDict(dict)
							TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
							Citizen.Wait(1000)

							TriggerServerEvent('esx:onPickup', pickupId)
							PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
						end
					end

					label = ('%s~n~%s'):format(label, _U('threw_pickup_prompt'))
				end

				ESX.Game.Utils.DrawText3D({
					x = pickup.coords.x,
					y = pickup.coords.y,
					z = pickup.coords.z + 0.25
				}, label, 1.2, 1)
			elseif pickup.inRange then
				pickup.inRange = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)
