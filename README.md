## Lusty94_Crates


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

PLEASE MAKE SURE TO READ THIS ENTIRE FILE AS IT COVERS SOME IMPORTANT INFORMATION

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




======================================
SCRIPT SUPPORT VIA DISCORD: https://discord.gg/BJGFrThmA8
======================================



## Features
- Find item crates around the map and interact with them for a chance to receive items depending on the crate type
- Easily add more crate spawn locations
- Easily change items based on crate type
- Inbuilt XP system to allow players to receive more items from searching crates
- Chance to find nothing when searching
- 5 crate types by default: item crates, medical crates, weapon crates, ammo crates and cash crates
- crates spawn once per server / resource restart


## DEPENDENCIES

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [ox_lib](https://github.com/overextended/ox_lib/releases/)



## Crate XP
If you are using the inbuilt XP system then you must add the metadata lines below to your player.lua file in core
- new qb method is via the config but you might need to edit how metadata is assigned in server files

- look for the lines that are similair for the hunger and thirst  and stress or other xp types etc
- do not forget to edit this if you have changed your `MetaDataName` inside `config.lua`

```

PlayerData.metadata['cratexp'] = PlayerData.metadata['cratexp'] or 0 -- Added for lusty94_crates

```


## INSTALLATION

- Add the ##ITEMS snippet below into your core/shared/items.lua file - ox_inventory users add the items to inventory/data/items.lua
- Add all .png images inside [images] folder into your inventory/html/images folder - ox_inventory users place images inside inventory/web/images




## QB-CORE ITEMS

```

    --crates 
    -- crowbar required to target
    crowbar = {name = 'crowbar', label = 'Crowbar', weight = 200, type = 'item', image = 'crowbar.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'Used to open stuff?'},


```

## OX_INVENTORY ITEMS

```

    
    ["crowbar"] = {
		label = "Crowbar",
		weight = 200,
		stack = true,
		close = true,
		description = "Used to open stuff?",
		client = {
			image = "crowbar.png",
		}
	},


```





