## QB-LootPeds 
With this script you can loot dead corps.
this script also works with zombie scripts, if you add the ped model name to the list inside config.lua.

## NOTE 
- This loot system will not work if you dont have qb-target.
- make sure `qb-target` is installed `correctly` on your server.
- check if you have `setr UseTarget true` in your server.cfg or this script will not work.


## Dependencies
- ✅ [qb-core](https://github.com/qbcore-framework/qb-core)
- ✅ [qb-target](https://github.com/qbcore-framework/qb-target)


## Install
- put the `qb-lootpeds` in `resources/[qb]/qb-lootpeds`
- open F8 type `refresh`
- ater `refresh` type `ensure qb-lootpeds` or you can restart the server.
- don't forget the admin command to `enable` or `disable` the loot system.
- check if you have `setr UseTarget true` in your server.cfg or this script will not work.

## Admin Command
- `/pedloot On`
- `/pedloot Off`


## Server side triggers Enable or Disable Lootsystem
- Enable Loot System For All Players
```lua
TriggerEvent('qb-lootpeds:server:enable')
```

- Disable Loot System For All Players
```lua
TriggerEvent('qb-lootpeds:server:disable')
```

## Any bugs or issues, let my know.


## Youtube & Discord
- [Youtube](https://www.youtube.com/c/MaDHouSe79)
- [Discord](https://discord.gg/cEMSeE9dgS)
