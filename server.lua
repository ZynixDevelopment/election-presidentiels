ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local electionActive = false
local candidates = {}
local votes = {}
local votedPlayers = {}

-- Démarrer une élection (admin)
RegisterCommand('startelection', function(source, args, rawCommand)
    if electionActive then
        TriggerClientEvent('election:notify', source, 'Une élection est déjà en cours.')
        return
    end
    candidates = {}
    votes = {}
    votedPlayers = {}
    electionActive = true
    TriggerClientEvent('election:start', -1)
    TriggerClientEvent('election:notifyAll', -1, "L'élection présidentielle est ouverte ! Allez à la mairie pour vous présenter ou voter.")
end, true)

-- Terminer l'élection (admin)
RegisterCommand('endelection', function(source, args, rawCommand)
    if not electionActive then
        TriggerClientEvent('election:notify', source, 'Aucune élection en cours.')
        return
    end

    local winner, maxVotes = nil, 0
    for k, v in pairs(votes) do
        if v > maxVotes then
            winner = k
            maxVotes = v
        end
    end
    if winner then
        TriggerClientEvent('election:notifyAll', -1, ('Le nouveau président est : %s avec %d votes !'):format(winner, maxVotes))
    else
        TriggerClientEvent('election:notifyAll', -1, "Aucun vainqueur, pas de votes.")
    end

    electionActive = false
    candidates = {}
    votes = {}
    votedPlayers = {}
    TriggerClientEvent('election:end', -1)
end, true)

-- Inscription comme candidat (menu)
RegisterNetEvent('election:registerCandidate')
AddEventHandler('election:registerCandidate', function()
    local src = source
    if not electionActive then
        TriggerClientEvent('election:notify', src, 'Aucune élection en cours.')
        return
    end

    local xPlayer = ESX.GetPlayerFromId(src)
    local name = xPlayer.getName()

    for i=1,#candidates do
        if candidates[i] == name then
            TriggerClientEvent('election:notify', src, 'Vous êtes déjà candidat !')
            return
        end
    end

    table.insert(candidates, name)
    votes[name] = 0
    TriggerClientEvent('election:notify', src, 'Vous êtes maintenant candidat à la présidence !')
    TriggerClientEvent('election:notifyAll', -1, name.." s\'est porté candidat à la présidence !")
end)

-- Liste des candidats (pour le menu)
RegisterNetEvent('election:getCandidates')
AddEventHandler('election:getCandidates', function()
    local src = source
    TriggerClientEvent('election:receiveCandidates', src, candidates, electionActive)
end)

-- Voter pour un candidat
RegisterNetEvent('election:vote')
AddEventHandler('election:vote', function(candidate)
    local src = source
    if not electionActive then
        TriggerClientEvent('election:notify', src, 'Aucune élection en cours.')
        return
    end
    if votedPlayers[src] then
        TriggerClientEvent('election:notify', src, 'Vous avez déjà voté !')
        return
    end
    if not votes[candidate] then
        TriggerClientEvent('election:notify', src, 'Candidat invalide !')
        return
    end
    votes[candidate] = votes[candidate] + 1
    votedPlayers[src] = true
    TriggerClientEvent('election:notify', src, 'Votre vote a été pris en compte pour : ' .. candidate)
end)
