--[[ ===================================================== ]]--
--[[          QBCore Loot Peds System by MaDHouSe          ]]--
--[[ ===================================================== ]]--

local script = GetCurrentResourceName()

local function checkVersion(err, responseText, headers)
    curVersion = LoadResourceFile(script, "version")
    if responseText == nil then
        print(script.." check for updates failed...")
    else
        if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            print(script.." is outdated, latest version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!")
        elseif tonumber(curVersion) > tonumber(responseText) then
            print(script.." latest version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!")
        else
            print(script.." is up to date. (^2"..curVersion.."^7)")
        end
    end
end

CreateThread( function()
    PerformHttpRequest("https://raw.githubusercontent.com/MaDHouSe79/"..script.."/master/version", checkVersion, "GET")
end)
