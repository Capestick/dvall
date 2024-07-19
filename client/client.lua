RegisterNetEvent('clearallvehicles', function()
    local playerPed = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')

    for _, vehicle in ipairs(vehicles) do
        if DoesEntityExist(vehicle) then
            local vehPos = GetEntityCoords(vehicle)
            local withinExclusion = false

            for _, exclusion in ipairs(Config.ExclusionCenters) do
                if #(vehPos - exclusion.center) <= exclusion.radius then
                    withinExclusion = true
                    break
                end
            end

            if not withinExclusion and not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                SetEntityAsMissionEntity(vehicle, false, false)
                DeleteVehicle(vehicle)
            end
        end
    end
end)

CreateThread(function()
    local vehicleTimers = {}

    while true do
        local ped = PlayerPedId()

        for _, model in ipairs(Config.AutoDeleteVehicles) do
            local vehicle = GetClosestVehicle(GetEntityCoords(ped), 10.0, GetHashKey(model), 70)
            if DoesEntityExist(vehicle) then
                if not vehicleTimers[vehicle] then
                    vehicleTimers[vehicle] = GetGameTimer()
                elseif GetGameTimer() - vehicleTimers[vehicle] > Config.AutoDeleteTimer * 1000 then
                    SetEntityAsMissionEntity(vehicle, false, false)
                    DeleteVehicle(vehicle)
                    vehicleTimers[vehicle] = nil
                end
            end
        end

        Wait(3000)
    end
end)

CreateThread(function()
    for _, exclusion in ipairs(Config.ExclusionCenters) do
        print("Creating blip for exclusion center at: " .. exclusion.center.x .. ", " .. exclusion.center.y .. ", " .. exclusion.center.z)
        
        -- Create the radius blip
        local blipRadius = AddBlipForRadius(exclusion.center.x, exclusion.center.y, exclusion.center.z, exclusion.radius)
        SetBlipHighDetail(blipRadius, true)
        SetBlipColour(blipRadius, 2) -- Green color
        SetBlipAlpha(blipRadius, 128) -- Transparency
    end
end)
