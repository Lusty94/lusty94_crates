local QBCore = exports['qb-core']:GetCoreObject()
local NotifyType = Config.CoreSettings.Notify.Type
local InvType = Config.CoreSettings.Inventory.Type
local MetaDataName = Config.XP.MetaDataName
local Levels = Config.XP.Levels


--notification function
local function SendNotify(src, msg, type, time, title)
    if not title then title = "Crates" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message") return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'boii'  then
        TriggerClientEvent('boii_ui:notify', src, title, msg, type, time)
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    end
end

--crowbar callback
QBCore.Functions.CreateCallback('lusty94_crates:get:Crowbar', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local item = Ply.Functions.GetItemByName("crowbar")
    if item then
        cb(true)
    else
        cb(false)
    end
end)

-- item crates
RegisterNetEvent('lusty94_crates:server:OpenItemCrate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local CrateXP = Player.PlayerData.metadata[MetaDataName]
    local xpAmount = math.random(5,10) -- edit xp reward amount here
    if not Player then return end
    if Config.XP.Enabled then
        if CrateXP <= 150 then
            amount = math.random(1,4)
        elseif CrateXP <= 500 then
            amount = math.random(2,5)
        elseif CrateXP <= 750 then
            amount = math.random(3,6)
        elseif CrateXP <= 1250 then
            amount = math.random(4,7)
        elseif CrateXP <= 1500 then
            amount = math.random(5,8)
        elseif CrateXP <= 2200 then
            amount = math.random(6,9)
        end
    else 
        amount = math.random(1,4) -- edit item amount if not using xp here  
    end  
    local ItemCrateItems = { -- add or remove items here
        "copper", "iron", "metalscrap", "aluminum", "steel", "water_bottle", "tosti",
    }
    local items = ItemCrateItems[math.random(#ItemCrateItems)]
    if InvType == 'qb' then
        Player.Functions.AddItem(items, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[items], 'add', amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, items, amount) then
            exports.ox_inventory:AddItem(src, items, amount)
        else
            SendNotify(src,"You cant carry anymore of this item!", 'error', 5000)
        end
    end
    if Config.XP.Enabled then
        Player.Functions.SetMetaData(MetaDataName, (CrateXP + xpAmount))
        SendNotify(src,"You earned sopme XP!", 'success', 5000)
    end	
end)

-- medical crates
RegisterNetEvent('lusty94_crates:server:OpenMedicalCrate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local CrateXP = Player.PlayerData.metadata[MetaDataName]
    local xpAmount = math.random(5,10) -- edit xp reward amount here
    if not Player then return end
    if Config.XP.Enabled then
        if CrateXP <= 150 then
            amount = math.random(1,4)
        elseif CrateXP <= 500 then
            amount = math.random(2,5)
        elseif CrateXP <= 750 then
            amount = math.random(3,6)
        elseif CrateXP <= 1250 then
            amount = math.random(4,7)
        elseif CrateXP <= 1500 then
            amount = math.random(5,8)
        elseif CrateXP <= 2200 then
            amount = math.random(6,9)
        end
    else 
        amount = math.random(1,4) -- edit item amount if not using xp here  
    end  
    local MedicalCrateItems = { -- add or remove items here
        "bandage", "ifaks", "painkillers",
    }
    local items = MedicalCrateItems[math.random(#MedicalCrateItems)]
    if InvType == 'qb' then
        Player.Functions.AddItem(items, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[items], 'add', amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, items, amount) then
            exports.ox_inventory:AddItem(src, items, amount)
        else
            SendNotify(src,"You cant carry anymore of this item!", 'error', 5000)
        end
    end
    if Config.XP.Enabled then
        Player.Functions.SetMetaData(MetaDataName, (CrateXP + xpAmount))
        SendNotify(src,"You earned sopme XP!", 'success', 5000)
    end	
end)

-- weapon crates
RegisterNetEvent('lusty94_crates:server:OpenWeaponCrate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local CrateXP = Player.PlayerData.metadata[MetaDataName]
    local xpAmount = math.random(5,10) -- edit xp reward amount here
    if not Player then return end 
    local WeaponCrateItems = { -- add or remove items here
        "weapon_pistol", "weapon_smg", "weapon_microsmg", "weapon_pumpshotgun", "weapon_assaultrifle", "weapon_heavysniper", "weapon_mg",
    }
    local items = WeaponCrateItems[math.random(#WeaponCrateItems)]
    if InvType == 'qb' then
        Player.Functions.AddItem(items, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[items], 'add', 1)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, items, 1) then
            exports.ox_inventory:AddItem(src, items, 1)
        else
            SendNotify(src,"You cant carry anymore of this item!", 'error', 5000)
        end
    end
    if Config.XP.Enabled then
        Player.Functions.SetMetaData(MetaDataName, (CrateXP + xpAmount))
        SendNotify(src,"You earned sopme XP!", 'success', 5000)
    end	
end)


-- ammo crates
RegisterNetEvent('lusty94_crates:server:OpenAmmoCrate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local CrateXP = Player.PlayerData.metadata[MetaDataName]
    local xpAmount = math.random(5,10) -- edit xp reward amount here
    if not Player then return end
    if Config.XP.Enabled then
        if CrateXP <= 150 then
            amount = math.random(1,4)
        elseif CrateXP <= 500 then
            amount = math.random(2,5)
        elseif CrateXP <= 750 then
            amount = math.random(3,6)
        elseif CrateXP <= 1250 then
            amount = math.random(4,7)
        elseif CrateXP <= 1500 then
            amount = math.random(5,8)
        elseif CrateXP <= 2200 then
            amount = math.random(6,9)
        end
    else 
        amount = math.random(1,4) -- edit item amount if not using xp here  
    end  
    local AmmoCrateItems = { -- add or remove items here
        --these are qb-inventory item names
        "pistol_ammo", "rifle_ammo", "smg_ammo", "shotgun_ammo", "mg_ammo", "snp_ammo",

        --uncomment the section below if using ox_inventory as the ammo names are different
        --"ammo-rifle2", "ammo-9", "ammo-rifle", "ammo-shotgun", "ammo-45", "ammo-heavysniper", "ammo-22", "ammo-44", "ammo-sniper", "ammo-50",
        
    }
    local items = AmmoCrateItems[math.random(#AmmoCrateItems)]
    if InvType == 'qb' then
        Player.Functions.AddItem(items, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[items], 'add', amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, items, amount) then
            exports.ox_inventory:AddItem(src, items, amount)
        else
            SendNotify(src,"You cant carry anymore of this item!", 'error', 5000)
        end
    end
    if Config.XP.Enabled then
        Player.Functions.SetMetaData(MetaDataName, (CrateXP + xpAmount))
        SendNotify(src,"You earned sopme XP!", 'success', 5000)
    end	
end)

-- cash crates
RegisterNetEvent('lusty94_crates:server:OpenCashCrate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local CrateXP = Player.PlayerData.metadata[MetaDataName]
    local xpAmount = math.random(5,10) -- edit xp reward amount here
    if not Player then return end
    if Config.XP.Enabled then
        if CrateXP <= 150 then
            amount = math.random(1000,4000)
        elseif CrateXP <= 500 then
            amount = math.random(2000,5000)
        elseif CrateXP <= 750 then
            amount = math.random(3000,6000)
        elseif CrateXP <= 1250 then
            amount = math.random(4000,7000)
        elseif CrateXP <= 1500 then
            amount = math.random(5000,8000)
        elseif CrateXP <= 2200 then
            amount = math.random(6000,9000)
        end
    else 
        amount = math.random(1000,4000) -- edit item amount if not using xp here  
    end  
    if InvType == 'qb' then
        Player.Functions.AddMoney('cash', amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, 'money', amount) then
            exports.ox_inventory:AddItem(src, 'money', amount)
        else
            SendNotify(src,"You cant carry anymore of this item!", 'error', 5000)
        end
    end
    if Config.XP.Enabled then
        Player.Functions.SetMetaData(MetaDataName, (CrateXP + xpAmount))
        SendNotify(src,"You earned sopme XP!", 'success', 5000)
    end
end)


---------------------< DONT TOUCH >--------------------

--/XP Command
if Config.XP.Enabled then
    if Config.XP.Command then
        QBCore.Commands.Add(MetaDataName, "Check Your Crate Searching XP Level", {}, true, function(source, args)
            local source = source
            local src = source
            local level = 1
            local Player = QBCore.Functions.GetPlayer(source)
            local data = Player.PlayerData.metadata[MetaDataName]
            if data ~= nil then
                for i=1, #Levels, 1 do
                    if data >= Levels[i] then
                        level = i + 1
                    end
                end
                SendNotify(src, "You Are Currently Level: " ..level.. " ( You have: " ..data.. " xp)", 'success', 2000)
            end
        end)
    end
end


local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Crates/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^2Current^7: "..currentVersion.." ^2Latest^7: "..newestVersion..advice) end
	end)
end
CheckVersion()