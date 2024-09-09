local QBCore = exports['qb-core']:GetCoreObject()
local TargetType = Config.CoreSettings.Target.Type
local NotifyType = Config.CoreSettings.Notify.Type
local InvType = Config.CoreSettings.Inventory.Type
local busy = false
local spawnedCrates = {}



--notification function
local function SendNotify(msg,type,time,title)
    if NotifyType == nil then print("Lusty94_Crates: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Crates" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message.") return end
    if NotifyType == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif NotifyType == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, true)
    elseif NotifyType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, msg)
    elseif NotifyType == 'boii' then
        exports['boii_ui']:notify(title, msg, type, time)
    elseif NotifyType == 'ox' then
        lib.notify({ title = title, description = msg, type = type, duration = time})
    end
end




CreateThread(function()
	for k, v in pairs(Config.InteractionLocations.Crates) do
		lib.requestModel(v.PropName)
		crateObjects = CreateObject(v.PropName, v.Location.x, v.Location.y, v.Location.z - 1, false, true, false)
		SetEntityHeading(crateObjects, v.Heading)
		PlaceObjectOnGroundProperly(crateObjects, true)
		FreezeEntityPosition(crateObjects, true)
		spawnedCrates[#spawnedCrates+1] = crateObjects
		SetModelAsNoLongerNeeded(v.PropName)
		if TargetType == 'qb' then
		    exports['qb-target']:AddTargetEntity(crateObjects, { options = { { type = "client", item = v.Item, event = v.Event, icon = v.TargetIcon, label = v.TargetLabel, }, }, distance = v.Distance })
        elseif TargetType == 'ox' then
            exports.ox_target:addLocalEntity(crateObjects, { { name = 'crateObjects', items = v.Item, icon = v.TargetIcon, label = v.TargetLabel, event = v.Event, distance = v.Distance} })
        end
	end
end)



--search item crate
RegisterNetEvent("lusty94_crates:client:OpenItemCrate", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #spawnedCrates, 1 do
		if #(coords - GetEntityCoords(spawnedCrates[i])) < 3 then
			nearbyObject, nearbyID = spawnedCrates[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		QBCore.Functions.TriggerCallback('lusty94_crates:get:Crowbar', function(HasItems)  
			if HasItems then
				if busy then
					SendNotify("You Are Already Doing Something!", 'error', 2000)
				else
					local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                	if success then
						busy = true
						LockInventory(true)
						if lib.progressCircle({ 
							duration = Config.CoreSettings.Timers.OpenCrate, 
							label = 'Searching Crate', 
							position = 'bottom', 
							useWhileDead = false, 
							canCancel = true, 
							disable = { car = false, move = true, }, 
							anim = { dict = Config.Animations.SearchCrates.AnimDict, clip = Config.Animations.SearchCrates.Anim }, 
							prop = { model = Config.Animations.SearchCrates.Prop, pos = Config.Animations.SearchCrates.Pos, rot = Config.Animations.SearchCrates.Rot, bone = Config.Animations.SearchCrates.Bone }, 
					}) then  
							SetEntityAsMissionEntity(nearbyObject, false, true)
							DeleteObject(nearbyObject)
							spawnedCrates[nearbyID] = nil
							local chance = math.random(1,100)
							local chance2 = Config.CoreSettings.Chances.FindItem
							if chance <= chance2 then
								TriggerServerEvent('lusty94_crates:server:OpenItemCrate')
							else
								SendNotify('Nothing found', 'error', 2000)
							end
							busy = false
							LockInventory(false)
						else 
							busy = false
							LockInventory(false)
							SendNotify('Action cancelled', 'error', 2000)
						end
					else
						SendNotify("Action failed.", 'error', 2000)
					end
				end
			else
				SendNotify("You cant open a crate without a crowbar!", 'error', 2500)
			end
		end)
	end
end)


--search Medical crate
RegisterNetEvent("lusty94_crates:client:OpenMedicalCrate", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #spawnedCrates, 1 do
		if #(coords - GetEntityCoords(spawnedCrates[i])) < 3 then
			nearbyObject, nearbyID = spawnedCrates[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		QBCore.Functions.TriggerCallback('lusty94_crates:get:Crowbar', function(HasItems)  
			if HasItems then
				if busy then
					SendNotify("You Are Already Doing Something!", 'error', 2000)
				else
					local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                	if success then
						busy = true
						LockInventory(true)
						if lib.progressCircle({ 
							duration = Config.CoreSettings.Timers.OpenCrate, 
							label = 'Searching Crate', 
							position = 'bottom', 
							useWhileDead = false, 
							canCancel = true, 
							disable = { car = false, move = true, }, 
							anim = { dict = Config.Animations.SearchCrates.AnimDict, clip = Config.Animations.SearchCrates.Anim }, 
							prop = { model = Config.Animations.SearchCrates.Prop, pos = Config.Animations.SearchCrates.Pos, rot = Config.Animations.SearchCrates.Rot, bone = Config.Animations.SearchCrates.Bone }, 
						}) then  
							SetEntityAsMissionEntity(nearbyObject, false, true)
							DeleteObject(nearbyObject)
							spawnedCrates[nearbyID] = nil
							local chance = math.random(1,100)
							local chance2 = Config.CoreSettings.Chances.FindItem
							if chance <= chance2 then
								TriggerServerEvent('lusty94_crates:server:OpenMedicalCrate')
							else
								SendNotify('Nothing found', 'error', 2000)
							end
							busy = false
							LockInventory(false)
						else 
							busy = false
							LockInventory(false)
							SendNotify('Action cancelled', 'error', 2000)
						end
					else
						SendNotify("Action failed.", 'error', 2000)
					end
				end
			else
				SendNotify("You cant open a crate without a crowbar!", 'error', 2500)
			end
		end)
	end
end)


--search Weapon crate
RegisterNetEvent("lusty94_crates:client:OpenWeaponCrate", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #spawnedCrates, 1 do
		if #(coords - GetEntityCoords(spawnedCrates[i])) < 3 then
			nearbyObject, nearbyID = spawnedCrates[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		QBCore.Functions.TriggerCallback('lusty94_crates:get:Crowbar', function(HasItems)  
			if HasItems then
				if busy then
					SendNotify("You Are Already Doing Something!", 'error', 2000)
				else
					local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                	if success then
						busy = true
						LockInventory(true)
						if lib.progressCircle({ 
							duration = Config.CoreSettings.Timers.OpenCrate, 
							label = 'Searching Crate', 
							position = 'bottom', 
							useWhileDead = false, 
							canCancel = true, 
							disable = { car = false, move = true, }, 
							anim = { dict = Config.Animations.SearchCrates.AnimDict, clip = Config.Animations.SearchCrates.Anim }, 
							prop = { model = Config.Animations.SearchCrates.Prop, pos = Config.Animations.SearchCrates.Pos, rot = Config.Animations.SearchCrates.Rot, bone = Config.Animations.SearchCrates.Bone }, 
						}) then
							SetEntityAsMissionEntity(nearbyObject, false, true)
							DeleteObject(nearbyObject)
							spawnedCrates[nearbyID] = nil
							local chance = math.random(1,100)
							local chance2 = Config.CoreSettings.Chances.FindItem
							if chance <= chance2 then
								TriggerServerEvent('lusty94_crates:server:OpenWeaponCrate')
							else
								SendNotify('Nothing found', 'error', 2000)
							busy = false
							LockInventory(false)
							end
						else 
							busy = false
							LockInventory(false)
							SendNotify('Action cancelled', 'error', 2000)
						end
					else
						SendNotify("Action failed.", 'error', 2000)
					end
				end
			else
				SendNotify("You cant open a crate without a crowbar!", 'error', 2500)
			end
		end)
	end
end)

--search Ammo crate
RegisterNetEvent("lusty94_crates:client:OpenAmmoCrate", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #spawnedCrates, 1 do
		if #(coords - GetEntityCoords(spawnedCrates[i])) < 3 then
			nearbyObject, nearbyID = spawnedCrates[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		QBCore.Functions.TriggerCallback('lusty94_crates:get:Crowbar', function(HasItems)  
			if HasItems then
				if busy then
					SendNotify("You Are Already Doing Something!", 'error', 2000)
				else
					local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                	if success then
						busy = true
						LockInventory(true)
						if lib.progressCircle({ 
							duration = Config.CoreSettings.Timers.OpenCrate, 
							label = 'Searching Crate', 
							position = 'bottom', 
							useWhileDead = false, 
							canCancel = true, 
							disable = { car = false, move = true, }, 
							anim = { dict = Config.Animations.SearchCrates.AnimDict, clip = Config.Animations.SearchCrates.Anim }, 
							prop = { model = Config.Animations.SearchCrates.Prop, pos = Config.Animations.SearchCrates.Pos, rot = Config.Animations.SearchCrates.Rot, bone = Config.Animations.SearchCrates.Bone }, 
						}) then  
							SetEntityAsMissionEntity(nearbyObject, false, true)
							DeleteObject(nearbyObject)
							spawnedCrates[nearbyID] = nil
							local chance = math.random(1,100)
							local chance2 = Config.CoreSettings.Chances.FindItem
							if chance <= chance2 then
								TriggerServerEvent('lusty94_crates:server:OpenAmmoCrate')
							else
								SendNotify('Nothing found', 'error', 2000)
							end
							busy = false
							LockInventory(false)
						else 
							busy = false
							LockInventory(false)
							SendNotify('Action cancelled', 'error', 2000)
						end
					else
						SendNotify("Action failed.", 'error', 2000)
					end
				end
			else
				SendNotify("You cant open a crate without a crowbar!", 'error', 2500)
			end
		end)
	end
end)

--search Cash crate
RegisterNetEvent("lusty94_crates:client:OpenCashCrate", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #spawnedCrates, 1 do
		if #(coords - GetEntityCoords(spawnedCrates[i])) < 3 then
			nearbyObject, nearbyID = spawnedCrates[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		QBCore.Functions.TriggerCallback('lusty94_crates:get:Crowbar', function(HasItems)  
			if HasItems then
				if busy then
					SendNotify("You Are Already Doing Something!", 'error', 2000)
				else
					local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                	if success then
						busy = true
						LockInventory(true)
						if lib.progressCircle({ 
							duration = Config.CoreSettings.Timers.OpenCrate, 
							label = 'Searching Crate', 
							position = 'bottom', 
							useWhileDead = false, 
							canCancel = true, 
							disable = { car = false, move = true, }, 
							anim = { dict = Config.Animations.SearchCrates.AnimDict, 
							clip = Config.Animations.SearchCrates.Anim }, 
							prop = { model = Config.Animations.SearchCrates.Prop, pos = Config.Animations.SearchCrates.Pos, rot = Config.Animations.SearchCrates.Rot, bone = Config.Animations.SearchCrates.Bone },
						}) then  
							SetEntityAsMissionEntity(nearbyObject, false, true)
							DeleteObject(nearbyObject)
							spawnedCrates[nearbyID] = nil
							local chance = math.random(1,100)
							local chance2 = Config.CoreSettings.Chances.FindItem
							if chance <= chance2 then
								TriggerServerEvent('lusty94_crates:server:OpenCashCrate')
							else
								SendNotify('Nothing found', 'error', 2000)
							end
							busy = false
							LockInventory(false)
						else 
							busy = false
							LockInventory(false)
							SendNotify('Action cancelled', 'error', 2000)
						end
					else
						SendNotify("Action failed.", 'error', 2000)
					end
				end
			else
				SendNotify("You cant open a crate without a crowbar!", 'error', 2500)
			end
		end)
	end
end)


-- function to lock inventory to prevent exploits
function LockInventory(toggle) -- big up to jim for how to do this
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true) -- used by qb, ps and ox
        --this is the old method below
        --[[         
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
            TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", true, true)
        end         
        ]]
    else 
        LocalPlayer.state:set("inv_busy", false, true) -- used by qb, ps and ox
        --this is the old method below
        --[[        
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
         TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", false, true)
        end        
        ]]
    end
end



AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		busy = false
		LockInventory(false)
		for _, v in pairs(spawnedCrates) do SetEntityAsMissionEntity(v, false, true) DeleteObject(v) end
        if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(crateObjects, 'crateObjects') elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(crateObjects, 'crateObjects') end
		print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Crates V1.0.1 Stopped Successfully ^5--<^3!^5>--^7')
	end
end)            