-- TV Script Server Side
local videoState = {
    isPlaying = false,
    isPaused = false,
    currentUrl = nil,
    startedAt = 0,
    lastPlayedBy = nil
}

-- Play video command
RegisterServerEvent('tv:playVideo')
AddEventHandler('tv:playVideo', function(url)
    local source = source
    
    -- Validate URL
    if not url or url == "" then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"TV Server", "Invalid URL provided"}
        })
        return
    end
    
    -- Update state
    videoState.isPlaying = true
    videoState.isPaused = false
    videoState.currentUrl = url
    videoState.startedAt = os.time()
    videoState.lastPlayedBy = GetPlayerName(source)
    
    -- Broadcast to all clients
    TriggerClientEvent('tv:onVideoPlay', -1, url)
    
    print(("^2[TV SCRIPT]^7 %s is now playing: %s"):format(GetPlayerName(source), url))
end)

-- Pause video command
RegisterServerEvent('tv:pauseVideo')
AddEventHandler('tv:pauseVideo', function()
    local source = source
    
    if not videoState.isPlaying then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"TV Server", "No video is currently playing"}
        })
        return
    end
    
    videoState.isPaused = true
    TriggerClientEvent('tv:onVideoPause', -1)
    
    print(("^3[TV SCRIPT]^7 Video paused by %s"):format(GetPlayerName(source)))
end)

-- Resume video command
RegisterServerEvent('tv:resumeVideo')
AddEventHandler('tv:resumeVideo', function()
    local source = source
    
    if not videoState.isPlaying or not videoState.isPaused then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"TV Server", "No paused video to resume"}
        })
        return
    end
    
    videoState.isPaused = false
    TriggerClientEvent('tv:onVideoResume', -1)
    
    print(("^2[TV SCRIPT]^7 Video resumed by %s"):format(GetPlayerName(source)))
end)

-- Stop video command
RegisterServerEvent('tv:stopVideo')
AddEventHandler('tv:stopVideo', function()
    local source = source
    
    if not videoState.isPlaying then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"TV Server", "No video is currently playing"}
        })
        return
    end
    
    videoState.isPlaying = false
    videoState.isPaused = false
    videoState.currentUrl = nil
    videoState.startedAt = 0
    
    TriggerClientEvent('tv:onVideoStop', -1)
    
    print(("^1[TV SCRIPT]^7 Video stopped by %s"):format(GetPlayerName(source)))
end)

-- Get TV status
RegisterServerEvent('tv:requestStatus')
AddEventHandler('tv:requestStatus', function()
    local source = source
    TriggerClientEvent('tv:statusResponse', source, videoState)
end)

-- Console command for admins
RegisterCommand('tvinfo', function(source, args, rawCommand)
    if videoState.isPlaying then
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"TV Info", "Status: Playing | URL: " .. videoState.currentUrl .. " | Paused: " .. tostring(videoState.isPaused) .. " | Started by: " .. videoState.lastPlayedBy}
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 0},
            multiline = true,
            args = {"TV Info", "Status: Idle - No video playing"}
        })
    end
end, false)

print("^2[TV SCRIPT]^7 Server side loaded successfully!")
