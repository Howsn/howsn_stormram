RegisterNetEvent('qbx_stormram:server:setState')
AddEventHandler('qbx_stormram:server:setState', function(doorId, state)
    TriggerEvent('ox_doorlock:setState', doorId, state)
end)
