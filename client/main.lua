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

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('mh-lootpeds:server:onjoin')
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

-- TAKE LOOT
RegisterNetEvent("mh-lootpeds:client:takeloot", function(entity)
    TriggerServerEvent('mh-lootpeds:server:getloot', PedToNet(entity))
    PedHasLooted(entity)
end)

-- TARGET SYSTEM
exports['qb-target']:AddTargetModel(Config.PedModels, {
    options = {{
        type = "client",
        event = "mh-lootpeds:client:takeloot",
        icon = 'fas fa-skull-crossbones',
        label = Lang:t('target.label'),
        targeticon = 'fas fa-skull-crossbones',
        action = function(entity)
            if IsPedAPlayer(entity) then return false end
            if IsPadAlreadyLooted(entity) then return false end
            TriggerEvent('mh-lootpeds:client:takeloot', entity)
        end,
        canInteract = function(entity, distance, data)
            if IsPedAPlayer(entity) then return false end
            if not IsPedAPlayer(entity) and not IsEntityDead(entity) then return false end
            if IsPadAlreadyLooted(entity) then return false end
            return true
        end
    }},
    distance = 2.5
})
