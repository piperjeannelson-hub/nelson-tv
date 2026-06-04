-- TV Script Configuration
-- Customize the behavior of the TV system

Config = {}

-- Enable debug mode (shows extra console messages)
Config.Debug = false

-- Chat colors (RGB format 0-255)
Config.Colors = {
    success = {0, 255, 0},        -- Green
    error = {255, 0, 0},          -- Red
    info = {0, 200, 255},         -- Cyan
    warning = {255, 200, 0},      -- Orange
    stopped = {200, 0, 255},      -- Purple
    paused = {255, 255, 0}        -- Yellow
}

-- Command permissions
Config.Commands = {
    tvplay = {
        enabled = true,
        name = 'tvplay',
        help = 'Play a video on all TV screens'
    },
    tvpause = {
        enabled = true,
        name = 'tvpause',
        help = 'Pause or resume the current video'
    },
    tvstop = {
        enabled = true,
        name = 'tvstop',
        help = 'Stop the video and turn off all screens'
    },
    tvinfo = {
        enabled = true,
        name = 'tvinfo',
        help = 'Check current TV status'
    }
}

-- Supported video formats and sources
Config.AllowedSources = {
    'youtube.com',
    'youtu.be',
    'twitch.tv',
    'mp4',
    'webm',
    'ogg',
    'm3u8',
    'rtmp',
    'hls',
    'http',
    'https'
}

-- Enable URL validation
Config.ValidateURLs = true

-- Automatically stop video after X minutes (0 = disabled)
Config.AutoStopAfter = 0

-- Sync check interval in milliseconds
Config.SyncInterval = 5000

-- Log all TV actions to console
Config.LogActions = true

-- Restrict commands to specific jobs (leave empty for all)
Config.AllowedJobs = {} -- Example: {'manager', 'owner'}

-- Restrict commands to specific players (leave empty for all)
Config.AdminOnly = false

-- Maximum video URL length
Config.MaxURLLength = 500

-- TV screen props (optional - for future expansion)
Config.TVProps = {
    -- Add TV prop models here for automatic detection
    -- 'prop_tv_plasma_big',
    -- 'v_res_msonline',
    -- 'prop_monitor_02'
}

-- Notification settings
Config.Notifications = {
    enabled = true,
    duration = 5000, -- Duration in milliseconds
    position = 'top-right' -- Position on screen
}

-- Event callbacks (for custom implementations)
Config.OnVideoPlay = function(url, player)
    if Config.LogActions then
        print(("Video playing: %s (started by %s)"):format(url, player))
    end
end

Config.OnVideoPause = function(player)
    if Config.LogActions then
        print(("Video paused by %s"):format(player))
    end
end

Config.OnVideoStop = function(player)
    if Config.LogActions then
        print(("Video stopped by %s"):format(player))
    end
end

-- Return the config
return Config
