QBCore = exports['qb-core']:GetCoreObject()

-- Load the configuration
Config = Config or {}
Config.DeleteInterval = Config.DeleteInterval or 10800000 -- Default to 3 hours if not set
Config.CountdownMinutes = Config.CountdownMinutes or 5 -- Default to 5 minutes if not set
Config.DvAutoCountdownMinutes = Config.DvAutoCountdownMinutes or 2 -- Default to 2 minutes if not set
Config.DiscordWebhook = Config.DiscordWebhook or ""
Config.ExclusionCenters = Config.ExclusionCenters or {}

local function sendAutoDVAlert(message, time)
    TriggerClientEvent('QBCore:Notify', -1, message, 'error', 3000)
    Citizen.Wait(time)
end

local function sendToDiscord(title, message)
    if Config.DiscordWebhook == "" then return end
    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({
        username = "Server Logger",
        embeds = {{
            ["title"] = title,
            ["description"] = message,
            ["color"] = 16711680
        }}
    }), { ['Content-Type'] = 'application/json' })
end

local function countdownAlert(minutes)
    for i = minutes, 1, -1 do
        local alertMessage = string.format("🚗 All Vehicles Will Be Cleared in %d Minute%s... 🚗", i, i > 1 and "s" or "")
        sendAutoDVAlert(alertMessage, 60000)
        print(alertMessage)
        sendToDiscord("Vehicle Deletion Countdown", alertMessage)
    end
    for i = 10, 1, -1 do
        local alertMessage = string.format("🚗 All Vehicles Will Be Cleared in %d Second%s... 🚗", i, i > 1 and "s" or "")
        sendAutoDVAlert(alertMessage, 1000)
        print(alertMessage)
        sendToDiscord("Vehicle Deletion Countdown", alertMessage)
    end
end

local function clearAllVehicles()
    local currentTime = os.date("%I:%M:%S %p")
    local message = "All vehicles have been cleared."

    sendAutoDVAlert(message, 0)
    TriggerClientEvent("clearallvehicles", -1)
    print(message)
    sendToDiscord("Vehicle Deletion", message .. " Time: " .. currentTime)
end

RegisterCommand('dvauto', function(source)
    local adminName = GetPlayerName(source)
    local startTime = os.time()
    local startTimeFormatted = os.date("%I:%M:%S %p", startTime)
    local startMessage = string.format("dvauto command has been run by %s at %s.", adminName, startTimeFormatted)
    print(startMessage)
    sendToDiscord("Command Run", startMessage)
    
    countdownAlert(Config.DvAutoCountdownMinutes)
    clearAllVehicles()

    local endTime = os.time()
    local duration = os.difftime(endTime, startTime)
    local durationFormatted = string.format("%d minutes %d seconds", math.floor(duration / 60), duration % 60)
    local finishMessage = string.format("dvauto command by %s finished. Duration: %s.", adminName, durationFormatted)
    print(finishMessage)
    sendToDiscord("Command Finished", finishMessage)
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.DeleteInterval)  -- Wait for the configured interval

        countdownAlert(Config.CountdownMinutes)
        clearAllVehicles()
    end
end)
