RegisterNetEvent('howsn_stormram:server:setState')
AddEventHandler('howsn_stormram:server:setState', function(doorId, state)
    TriggerEvent('ox_doorlock:setState', doorId, state)
end)
