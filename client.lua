local mairiePos = vector3(-545.0, -203.0, 38.2) -- Change selon ta map
local blip = nil

-- Création du blip à la mairie
Citizen.CreateThread(function()
    blip = AddBlipForCoord(mairiePos)
    SetBlipSprite(blip, 419)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Élections Présidentielles")
    EndTextCommandSetBlipName(blip)
end)

-- Menu principal à la mairie
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyPos = GetEntityCoords(PlayerPedId())
        if #(plyPos - mairiePos) < 2.0 then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu des élections.")
            if IsControlJustReleased(0, 38) then -- Touche E
                OpenElectionMenu()
            end
        end
    end
end)

function OpenElectionMenu()
    ESX.UI.Menu.CloseAll()
    local elements = {
        {label = "S'enregistrer comme candidat", value = 'register'},
        {label = "Voter", value = 'vote'}
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'election_menu', {
        title    = 'Élection présidentielle',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'register' then
            TriggerServerEvent('election:registerCandidate')
            menu.close()
        elseif data.current.value == 'vote' then
            TriggerServerEvent('election:getCandidates')
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

-- Afficher le menu de vote
RegisterNetEvent('election:receiveCandidates')
AddEventHandler('election:receiveCandidates', function(candidates, electionActive)
    if not electionActive or #candidates < 1 then
        ESX.ShowNotification("Aucune élection ou aucun candidat.")
        return
    end
    local elements = {}
    for i=1, #candidates do
        table.insert(elements, {label = candidates[i], value = candidates[i]})
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'election_vote', {
        title    = 'Vote Président',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        TriggerServerEvent('election:vote', data.current.value)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('election:notify')
AddEventHandler('election:notify', function(msg)
    ESX.ShowNotification(msg)
end)
RegisterNetEvent('election:notifyAll')
AddEventHandler('election:notifyAll', function(msg)
    ESX.ShowNotification(msg)
end)
RegisterNetEvent('election:start')
AddEventHandler('election:start', function()
    ESX.ShowNotification("L'élection présidentielle a commencé !")
end)
RegisterNetEvent('election:end')
AddEventHandler('election:end', function()
    ESX.ShowNotification("L'élection présidentielle est terminée.")
end)
