local function canUseStormram(action)
    local ClosestDoor = exports.ox_doorlock:getClosestDoor()
    
    if not ClosestDoor then
        return false -- No door found
    end
    
    if action == 'useStormram' then
        return ClosestDoor.state == 1 -- Can use storm ram only if the door is locked (state 1)
    elseif action == 'closeDoor' then
        return ClosestDoor.state == 0 -- Can close the door only if it is unlocked (state 0)
    end
    
    return false -- Default case if action is unknown
end

CreateThread(function()
    exports.ox_target:addGlobalObject({
        {
            name = 'useStormram',
            label = 'Use stormram',
            icon = 'fas fa-user-lock',
            canInteract = function() 
                local ClosestDoor = exports.ox_doorlock:getClosestDoor()
                return ClosestDoor and canUseStormram('useStormram') and ClosestDoor.distance <= 2
            end,
            event = 'qbx_stormram:client:useStormram',
            items = 'police_stormram',
            anyItem = true,
            distance = 1
        },
        {
            name = 'closeDoor',
            label = 'Lock door',
            icon = 'fas fa-user-lock',
            canInteract = function() 
                local ClosestDoor = exports.ox_doorlock:getClosestDoor()
                return ClosestDoor and canUseStormram('closeDoor') and ClosestDoor.distance <= 2
            end,
            event = 'qbx_stormram:client:useStormram',
            items = 'police_stormram',
            anyItem = true,
            distance = 1
        }
    })
end)

RegisterNetEvent('qbx_stormram:client:useStormram', function(source)
    local PlayerData = exports.qbx_core:GetPlayerData()
    local ClosestDoor = exports.ox_doorlock:getClosestDoor()

    if PlayerData.job.name ~= 'police' then 
        return exports.qbx_core:Notify('You cannot do this!', 'error')  
    end

    if ClosestDoor.distance > 2 then 
        return exports.qbx_core:Notify('There are no doors near you!', 'error') 
    end
    
    local coords = ClosestDoor.coords
    local entity = ClosestDoor.entity
    local playerPed = PlayerPedId()

    TaskTurnPedToFaceCoord(playerPed, coords.x, coords.y, coords.z, 2000)
    Wait(500)

    if ClosestDoor.state == 0 then 
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            label = 'Locking door...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
            },
            anim = {
                scenario = 'PROP_HUMAN_PARKING_METER',
            },
        })

        then    
            TriggerEvent('ox_doorlock:setState', ClosestDoor.id, 1) 
        else 
            exports.qbx_core:Notify('Avbrutt!', 'error') 
        end
    else
        if lib.progressCircle({
            duration = 4000,
            position = 'bottom',
            label = 'Using stormram...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
            },
            anim = {
                dict = 'missheistfbi3b_ig7',
                clip = 'lift_fibagent_loop'
            },
        })

        then 
            local randomChance = math.random(1, 100)

            if randomChance <= 50 then
                TriggerEvent('ox_doorlock:setState', ClosestDoor.id, 0)
                exports.qbx_core:Notify('You opened the door!', 'error')
            else
                exports.qbx_core:Notify('You couldnt do it!', 'error')
            end
        else 
            exports.qbx_core:Notify('Cancelled!', 'error') 
        end    
    end
end)