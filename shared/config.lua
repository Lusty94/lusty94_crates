Config = {}


--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


--Thank you for downloading this script!

--Below you can change multiple options to suit your server needs.

Config.CoreSettings = {
    Target = {
        Type = 'qb', -- support for qb-target and ox_target    
        --use 'qb' for qb-target
        --use 'ox' for ox_target
    },
    Notify = {
        Type = 'qb', -- notification type, support for qb-core notify, okokNotify, mythic_notify, boii_ui notify and ox_lib notify
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for myhthic_notify
        --use 'boii' for boii_ui notify
        --use 'ox' for ox_lib notify
    },
    Inventory = { -- support for qb-inventory and ox_inventory
        Type = 'qb',
        --use 'qb' for qb-inventory
        --use 'ox' for ox_inventory
    },
    Timers = {
        OpenCrate = 10000, -- time it takes to open a crate
    },
    Chances = {
        FindItem = 75, -- chance in % to find items when searching crates
    },    
}

-- XP settings
Config.XP = { -- use xp 
    Enabled = false, -- Toggles xp system on or off; true = on, false = off
    Command = false, -- Toggles commands on or off use /cratexp or whatever you have named the metadata
    MetaDataName = 'cratexp', -- The name of your xp if you edit this make sure to also edit the line you added into qb-core/server/player.lua - new core goes into config - you might also need to change how metadata is assigned
    XPChance = 75, -- chance to earn xp when delivering packages
    Levels = { -- Change your xp requirements here to suit your server set these as high as you want preset xp increase = (xp / 0.8) if changing amounts dont forget to edit server file also where items are given to match new xp amounts
        150, -- level 2 
        250, -- level 3 
        500, -- level 4
        750, -- level 5
        1000, -- level 6
        1250, -- level 6
        1500, -- level 7
        1750, -- level 8
        2200, -- level 9
        2500, -- level 10  
    }
}


Config.InteractionLocations = { -- add or remove more locations as you wish - SET YOUR OWN LOCATIONS FOR YOUR OWN SERVER - THESE ARE CURRENTLY PLACED AT THE CASINO FOR TESTING PURPOSES MOVE THEM YOURSELF TO WHERE YOU WISH FOR THEM TO BE
    Crates = { -- name must be unique, propName is name of prop, item is required item to target prop, location is coords, heading is heading, targeticon is target, targetlabel is target, event is the event of the type of items you want for that crate, distance is target distance
        { Name = "itemcrate1",          PropName = 'xs_prop_arena_crate_01a',        Item = 'crowbar', Location = vector3(1072.16, -91.47, 81.84), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Item Crate',         Event = 'lusty94_crates:client:OpenItemCrate',      Distance = 2.0,},
        { Name = "itemcrate2",          PropName = 'xs_prop_arena_crate_01a',        Item = 'crowbar', Location = vector3(1063.29, -92.53, 81.86), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Item Crate',         Event = 'lusty94_crates:client:OpenItemCrate',      Distance = 2.0,},
        { Name = "medicalcrate1",       PropName = 'ba_prop_battle_crate_m_medical', Item = 'crowbar', Location = vector3(1055.12, -92.31, 81.88), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Medical Crate',      Event = 'lusty94_crates:client:OpenMedicalCrate',   Distance = 2.0,},
        { Name = "medicalcrate2",       PropName = 'ba_prop_battle_crate_m_medical', Item = 'crowbar', Location = vector3(1045.98, -90.65, 81.91), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Medical Crate',      Event = 'lusty94_crates:client:OpenMedicalCrate',   Distance = 2.0,},
        { Name = "weaponcrate1",        PropName = 'ex_prop_crate_ammo_sc',          Item = 'crowbar', Location = vector3(1045.24, -83.13, 82.19), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Weapon Crate',       Event = 'lusty94_crates:client:OpenWeaponCrate',    Distance = 2.0,},
        { Name = "weaponcrate2",        PropName = 'ex_prop_crate_ammo_sc',          Item = 'crowbar', Location = vector3(1053.64, -83.83, 82.19), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Weapon Crate',       Event = 'lusty94_crates:client:OpenWeaponCrate',    Distance = 2.0,},
        { Name = "ammocrate1",          PropName = 'ex_prop_crate_expl_sc',          Item = 'crowbar', Location = vector3(1060.77, -84.29, 82.19), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Ammo Crate',         Event = 'lusty94_crates:client:OpenAmmoCrate',      Distance = 2.0,},
        { Name = "ammocrate2",          PropName = 'ex_prop_crate_expl_sc',          Item = 'crowbar', Location = vector3(1068.87, -84.28, 82.15), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Ammo Crate',         Event = 'lusty94_crates:client:OpenAmmoCrate',      Distance = 2.0,},
        { Name = "cashcrate1",          PropName = 'prop_cash_crate_01',             Item = 'crowbar', Location = vector3(1077.76, -80.35, 82.19), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Cash Crate',         Event = 'lusty94_crates:client:OpenCashCrate',      Distance = 2.0,},
        { Name = "cashcrate2",          PropName = 'prop_cash_crate_01',             Item = 'crowbar', Location = vector3(1086.35, -76.91, 82.11), Heading = 345.93, TargetIcon = 'fa-solid fa-clipboard', TargetLabel = 'Search Cash Crate',         Event = 'lusty94_crates:client:OpenCashCrate',      Distance = 2.0,},
    },
    
}


Config.Animations = {
    SearchCrates = {
        AnimDict = 'mini@repair',
        Anim = 'fixing_a_ped',
        Prop = 'w_me_crowbar',
        Pos = vec3(0.1, -0.02, -0.04),
        Rot = vec3(-74.0, -20.0, -16.0),
        Bone = 57005,
    },
}