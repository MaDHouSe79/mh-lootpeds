--[[ ===================================================== ]]--
--[[          QBCore Loot Peds System by MaDHouSe          ]]--
--[[ ===================================================== ]]--

local QBCore = exports['qb-core']:GetCoreObject()
local SystemIsEnable = Config.EnableOnStart
local isAEventEnable = false

--PLAYER ON JOIN 
RegisterNetEvent('mh-lootpeds:server:onjoin', function()
    local src = source
    if SystemIsEnable then TriggerClientEvent('mh-lootpeds:client:enable', src)  end
end)

-- ENABLE LOOT SYSTEM
RegisterServerEvent('mh-lootpeds:server:enable', function(eventname)
    SystemIsEnable = true
end)

-- DISABLE LOOT SYSTEM 
RegisterServerEvent('mh-lootpeds:server:disable', function(eventname)
    SystemIsEnable = false
end)

-- ENABLE EVENT MODE SYSTEM
RegisterServerEvent('mh-lootpeds:server:enableEvent', function()
    SystemIsEnable = true
    isAEventEnable = true
end)

-- DISABLE EVENT MODE SYSTEM 
RegisterServerEvent('mh-lootpeds:server:disableEvent', function()
    isAEventEnable = false
end)

--------------------------------------------------------------------------------
------------------------Dont Edit This Below, It Works Fine-----------------------
-- TAKE RANDOM LOOT FROM DEAD NPC 
RegisterNetEvent('mh-lootpeds:server:getloot', function(entity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    TriggerClientEvent('mh-lootpeds:client:deleteped', -1, entity)
    
    if not isAEventEnable then
        -- Cash Chance
        if Config.UseCash and math.random(1,100) < Config.CashChance then
            Player.Functions.AddMoney(Config.CashType, Config.CashReward)
        end
            
        -- Basic Item
        local item = Config.Items.Basic[math.random(1, #Config.Items.Basic)]
        if item.name then
            Player.Functions.AddItem(item.name, 1, false)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'add')
        end

        -- Ammo Item
        if Config.UseNormalWeaponLoot or Config.UseHeavyWeaponLoot then
            local ammo = Config.Items.Ammo[math.random(1, #Config.Items.Ammo)]
            if ammo.name == "pistol_ammo" or ammo.name == "snp_ammo" or ammo.name == "smg_ammo" or ammo.name == "rifle_ammo" or ammo.name == "shotgun_ammo" then
                Player.Functions.AddItem(ammo.name, 1, false)
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[ammo.name], 'add')
            end
        end

        -- Normal Weapon Item
        if Config.UseNormalWeaponLoot then
            local normalWeapon = Config.Items.NormalWeapons[math.random(1, #Config.Items.NormalWeapons)]
            if math.random(1, 100) <= 15 then -- chance to get this item
                if normalWeapon.name then
                    Player.Functions.AddItem(normalWeapon.name, 1, false, nil)
                    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[normalWeapon.name], 'add')
                end
            end
        end

        -- Heavy Weapon Item
        if Config.UseHeavyWeaponLoot then
            local heavyWeapon = Config.Items.HeavyWeapons[math.random(1, #Config.Items.HeavyWeapons)]
            if math.random(1, 100) <= 2 then -- chance to get this item
                if heavyWeapon.name then
                    Player.Functions.AddItem(heavyWeapon.name, 1, false, nil)
                    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[heavyWeapon.name], 'add')
                end
            end
        end
    else
        -- Ammo Item
        local ammo = Config.Items.Ammo[math.random(1, #Config.Items.Ammo)]
        if ammo.name == "pistol_ammo" or ammo.name == "snp_ammo" or ammo.name == "smg_ammo" or ammo.name == "rifle_ammo" or ammo.name == "shotgun_ammo" then
            Player.Functions.AddItem(ammo.name, 1, false)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[ammo.name], 'add', 1)
        end

        -- Normal Weapon Item
        local normalWeapon = Config.Items.NormalWeapons[math.random(1, #Config.Items.NormalWeapons)]
        if math.random(1, 100) <= 15 then -- chance to get this item
            if normalWeapon.name then
                Player.Functions.AddItem(normalWeapon.name, 1, false, nil)
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[normalWeapon.name], 'add', 1)
            end
        end

        -- Heavy Weapon Item
        local heavyWeapon = Config.Items.HeavyWeapons[math.random(1, #Config.Items.HeavyWeapons)]
        if math.random(1, 100) <= 2 then -- chance to get this item
            if heavyWeapon.name then
                Player.Functions.AddItem(heavyWeapon.name, 1, false, nil)
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[heavyWeapon.name], 'add', 1)
            end
        end

    end
end)

-- Reset On Resource Start 
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        if SystemIsEnable then
            TriggerClientEvent('mh-lootpeds:client:enable', -1)
        else
            TriggerClientEvent('mh-lootpeds:client:disable', -1)
        end
    end
end)

-- Reset On Resource Stop 
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        SystemIsEnable = false
        TriggerClientEvent('mh-lootpeds:client:disable', -1)
    end
end)

-- START LOOTING COMMAND 
QBCore.Commands.Add(Config.Commands.toggle, Lang:t('command.start_stop', {state = Lang:t('command.on_or_off')}), {}, false, function(source, args)
    if tostring(args[1]) == 'On' then
        SystemIsEnable = true
        TriggerClientEvent('mh-lootpeds:client:enable', -1)
    end
    if tostring(args[1]) == 'Off' then
        SystemIsEnable = false
        TriggerClientEvent('mh-lootpeds:client:disable', -1)
    end
end, 'admin')