<p align="center">
    <img width="140" src="https://icons.iconarchive.com/icons/iconarchive/red-orb-alphabet/128/Letter-M-icon.png" />  
    <h1 align="center">Hi 👋, I'm MaDHouSe</h1>
    <h3 align="center">A passionate allround developer </h3>    
</p>

<p align="center">
  <a href="https://github.com/MaDHouSe79/mh-lootpeds/issues">
    <img src="https://img.shields.io/github/issues/MaDHouSe79/mh-lootpeds"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-lootpeds/network/members">
    <img src="https://img.shields.io/github/forks/MaDHouSe79/mh-lootpeds"/> 
  </a>  
  <a href="https://github.com/MaDHouSe79/mh-lootpeds/stargazers">
    <img src="https://img.shields.io/github/stars/MaDHouSe79/mh-lootpeds?color=white"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-lootpeds/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/MaDHouSe79/mh-lootpeds?color=black"/> 
  </a>      
</p>

<p align="center">
  <img alig src="https://github-profile-trophy.vercel.app/?username=MaDHouSe79&margin-w=15&column=6" />
</p>

<p align="center">
  <img alig src="https://raw.githubusercontent.com/kamranahmedse/driver.js/master/demo/images/split.png" />
</p>

## MH-LootPeds 
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
- create a folder in `resources` [mh]
- put the `mh-lootpeds` in `resources/[mh]/`
- open F8 type `refresh`
- ater `refresh` type `ensure mh-lootpeds` or you can restart the server.
- don't forget the admin command to `enable` or `disable` the loot system.

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

# 🙈 Youtube
- [Youtube](https://www.youtube.com/c/MaDHouSe79)
