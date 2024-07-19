-- Configuration file for vehicle deletion intervals (in milliseconds)
Config = {}

-- Intervals for auto-deleting vehicles (in milliseconds)
Config.DeleteInterval = 10800000 -- 3 hours in milliseconds
Config.CountdownMinutes = 5 -- Countdown time before deletion

-- Countdown time for the dvauto command (in minutes)
Config.DvAutoCountdownMinutes = 5 -- Countdown time for dvauto command

-- Discord Webhook URL
Config.DiscordWebhook = "DISCORD_WEBHOOK_HERE"

-- Vehicles with auto-delete timer (in seconds)
Config.AutoDeleteTimer = 10 -- Time in seconds for auto-deletion

-- List of vehicles to auto-delete
Config.AutoDeleteVehicles = {
    "CHANGEHERE",
    -- Add more vehicles here
}

-- Exclusion centers for vehicle deletion
Config.ExclusionCenters = {
    {center = vector3(215.0, -810.0, 30.0), radius = 20.0}, -- Example center and radius
    -- Add more exclusion centers here
}
