--[[ ===================================================== ]] --
--[[          QBCore Loot Peds System by MaDHouSe          ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
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

local function TakeLoot(entity)
    TriggerServerEvent('mh-lootpeds:server:getloot', PedToNet(entity))
    PedHasLooted(entity)
end

local function LoadTarget()
    if Config.Target == "qb-target" then
        exports['qb-target']:AddTargetModel(Config.PedModels, {
            options = {{
                type = "client",
                icon = 'fas fa-skull-crossbones',
                label = Lang:t('target.label'),
                targeticon = 'fas fa-skull-crossbones',
                action = function(entity) TakeLoot(entity) end,
                canInteract = function(entity, distance, data)
                    if IsPedAPlayer(entity) then return false end
                    if not IsEntityDead(entity) then return false end
                    if IsPadAlreadyLooted(entity) then return false end
                    return true
                end
            }},
            distance = 2.5
        })
    elseif Config.Target == "ox_target" then
        exports.ox_target:addModel(Config.PedModels, {
            {
                icon = 'fas fa-skull-crossbones',
                label = Lang:t('target.label'),
                onSelect = function(data) TakeLoot(data.entity) end,
                canInteract = function(entity, distance, coords, name)
                    if IsPedAPlayer(entity) then return false end
                    if not IsEntityDead(entity) then return false end
                    if IsPadAlreadyLooted(entity) then return false end
                    return true
                end,
                distance = 2.5
            }
        })
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then 
        PlayerData = {}
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then 
        TriggerServerEvent('mh-lootpeds:server:onjoin')
        PlayerData = QBCore.Functions.GetPlayerData()
        LoadTarget()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('mh-lootpeds:server:onjoin')
    PlayerData = QBCore.Functions.GetPlayerData()
    LoadTarget()
end)

-- Delete Dead Ped
RegisterNetEvent("mh-lootpeds:client:deleteped", function(entity)
    if Config.DeletePedsWhenLooted then
        local tmpEntity = NetToPed(entity)
        local closedPed = QBCore.Functions.GetClosestPed(GetEntityCoords(PlayerPedId()))
        if DoesEntityExist(tmpEntity) and not IsPedAPlayer(tmpEntity) then
            DeletePed(tmpEntity)
            DeleteEntity(tmpEntity)
        end
    end
end)