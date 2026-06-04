-- TV Script Client Side
local isPlayingVideo = false
local currentVideoUrl = nil
local isPaused = false

-- Register commands
RegisterCommand('tvplay', function(source, args, rawCommand)
    if #args == 0 then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"TV", "Usage: /tvplay [YouTube/URL]"}
        })
        return
    end
    
    local videoUrl = table.concat(args, " ")
    TriggerServerEvent('tv:playVideo', videoUrl)
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"TV", "Playing video..."}
    })
end, false)

RegisterCommand('tvpause', function(source, args, rawCommand)
    if not isPlayingVideo then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"TV", "No video is currently playing"}
        })
        return
    end
    
    if isPaused then
        isPaused = false
        TriggerServerEvent('tv:resumeVideo')
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"TV", "Video resumed"}
        })
    else
        isPaused = true
        TriggerServerEvent('tv:pauseVideo')
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"TV", "Video paused"}
        })
    end
end, false)

RegisterCommand('tvstop', function(source, args, rawCommand)
    if not isPlayingVideo then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"TV", "No video is currently playing"}
        })
        return
    end
    
    isPlayingVideo = false
    isPaused = false
    currentVideoUrl = nil
    TriggerServerEvent('tv:stopVideo')
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"TV", "Video stopped"}
    })
end, false)

-- Server events
RegisterNetEvent('tv:onVideoPlay')
AddEventHandler('tv:onVideoPlay', function(url)
    isPlayingVideo = true
    isPaused = false
    currentVideoUrl = url
    TriggerEvent('chat:addMessage', {
        color = {0, 200, 255},
        multiline = true,
        args = {"TV System", "Video is now playing on all screens"}
    })
end)

RegisterNetEvent('tv:onVideoPause')
AddEventHandler('tv:onVideoPause', function()
    isPaused = true
    TriggerEvent('chat:addMessage', {
        color = {255, 200, 0},
        multiline = true,
        args = {"TV System", "Video paused on all screens"}
    })
end)

RegisterNetEvent('tv:onVideoResume')
AddEventHandler('tv:onVideoResume', function()
    isPaused = false
    TriggerEvent('chat:addMessage', {
        color = {0, 200, 255},
        multiline = true,
        args = {"TV System", "Video resumed on all screens"}
    })
end)

RegisterNetEvent('tv:onVideoStop')
AddEventHandler('tv:onVideoStop', function()
    isPlayingVideo = false
    isPaused = false
    currentVideoUrl = nil
    TriggerEvent('chat:addMessage', {
        color = {200, 0, 255},
        multiline = true,
        args = {"TV System", "All screens have been turned off"}
    })
end)

-- Get current TV status
function GetTVStatus()
    return {
        isPlaying = isPlayingVideo,
        isPaused = isPaused,
        videoUrl = currentVideoUrl
    }
end

exports('GetTVStatus', GetTVStatus)
