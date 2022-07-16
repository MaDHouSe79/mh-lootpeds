--[[ ===================================================== ]]--
--[[          QBCore Loot Peds System by MaDHouSe          ]]--
--[[ ===================================================== ]]--

local QBCore = exports['qb-core']:GetCoreObject()
local lootedPeds = {}

local function IsPadAlreadyLooted(entity)
    local looted = false
    for k, v in pairs(lootedPeds) do
        if v.ped == entity then
            looted = true
        end
    end
    return looted
end

local function PedHasLooted(entity)
    if IsPadAlreadyLooted(entity) then return end
    lootedPeds[#lootedPeds + 1] = {ped = entity}
end

local function DeleteAllPeds()
    ClearAreaOfPeds(GetEntityCoords(PlayerPedId()), 99999099.0, 1)
    ClearAreaOfVehicles(GetEntityCoords(PlayerPedId()), 99999099.0, false, false, false, false, false)
end

-- ON PLAYER LOAD
PlayerData = {}
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('qb-lootpeds:server:onjoin')
end)

-- ENABLE LOOT SYSTEM
local IsEnable = Config.EnableOnStart
RegisterNetEvent("qb-lootpeds:client:enable", function()
    IsEnable = true
    QBCore.Functions.Notify(Lang:t('system.enable'), "success")
end)

-- DISABLE LOOT SYSTEM
RegisterNetEvent("qb-lootpeds:client:disable", function()
    IsEnable = false
    QBCore.Functions.Notify(Lang:t('system.disable'), "success")
    DeleteAllPeds()
end)

-- Delete Dead Ped
RegisterNetEvent("qb-lootpeds:client:deleteped", function(entity)
    local closedPed = QBCore.Functions.GetClosestPed(GetEntityCoords(PlayerPedId()))
    if DoesEntityExist(closedPed) and not IsPedAPlayer(closedPed) then
        DeletePed(closedPed)
        DeleteEntity(closedPed)
    end
    if DoesEntityExist(entity) and not IsPedAPlayer(entity) then
        DeletePed(entity)
        DeleteEntity(entity)
    end
end)

-- TAKE LOOT
RegisterNetEvent("qb-lootpeds:client:takeloot", function(entity)
    TriggerServerEvent('qb-lootpeds:server:getloot', entity)
    PedHasLooted(entity)
end)

-- TARGET SYSTEM
if Config.UseTarget then 
    exports['qb-target']:AddTargetModel(Config.PedModels, {
        options = {
            {
                type = "client",
                event = "qb-lootpeds:client:takeloot",
                icon = 'fas fa-skull-crossbones',
                label = Lang:t('target.label'),
                targeticon = 'fas fa-skull-crossbones',
                action = function(entity)
                    if not IsEnable then return false end 
                    if IsPedAPlayer(entity) then return false end
                    if IsPadAlreadyLooted(entity) then return false end
                    TriggerEvent('qb-lootpeds:client:takeloot', entity)
                end,
                canInteract = function(entity, distance, data)
                    if not IsEnable then return false end 
                    if IsPedAPlayer(entity) then return false end
                    if not IsPedAPlayer(entity) and not IsEntityDead(entity) then return false end
                    if IsPadAlreadyLooted(entity) then return false end
                    return true
                end
            }
        },
        distance = 2.5,
    })
end
