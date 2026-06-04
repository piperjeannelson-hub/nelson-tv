# TV Script - FiveM Video Display System

A comprehensive FiveM script that allows players to play, pause, and stop videos on TV screens throughout the map using simple slash commands.

## Features

- 🎬 **Play videos** from YouTube or direct video URLs
- ⏸️ **Pause/Resume** functionality
- ⏹️ **Stop** videos
- 📡 **Synchronized playback** across all players
- 💬 **Chat notifications** for all actions
- 🔧 **Easy to use** slash commands
- 👥 **Multi-player support** - One person controls, everyone sees

## Installation

1. Download or clone this script into your `resources` folder
2. Add the following to your `server.cfg`:
   ```
   ensure nelson-tv
   ```
3. Restart your server or use `refresh` then `start nelson-tv`

## Commands

### `/tvplay [URL]`
Plays a video on all TV screens in the server.

**Usage:**
```
/tvplay https://youtube.com/watch?v=dQw4w9WgXcQ
/tvplay https://example.com/video.mp4
```

**Example:**
```
/tvplay https://www.youtube.com/watch?v=jNQXAC9IVRw
```

### `/tvpause`
Pauses the currently playing video. Run again to resume.

**Usage:**
```
/tvpause
```

**Behavior:**
- First press: Pauses video (shows "Video paused")
- Second press: Resumes video (shows "Video resumed")

### `/tvstop`
Stops the video and turns off all TV screens.

**Usage:**
```
/tvstop
```

## Command Structure

### Client Commands
All commands are registered on the client side:
- **tvplay**: Accepts any URL as arguments
- **tvpause**: Toggle pause/resume (no arguments needed)
- **tvstop**: Stop playback (no arguments needed)

### Server Events
The script uses the following server events for synchronization:
- `tv:playVideo` - Triggered when a player uses /tvplay
- `tv:pauseVideo` - Triggered when a player uses /tvpause
- `tv:resumeVideo` - Triggered to resume a paused video
- `tv:stopVideo` - Triggered when a player uses /tvstop
- `tv:requestStatus` - Request current TV status

### Client Events
Broadcast events that sync all players:
- `tv:onVideoPlay` - All clients receive the URL to play
- `tv:onVideoPause` - All clients pause their videos
- `tv:onVideoResume` - All clients resume videos
- `tv:onVideoStop` - All clients stop their videos

## Chat Notifications

The script provides color-coded notifications for all actions:

- 🟢 **Green** - Successful command execution
- 🔴 **Red** - Errors or invalid commands
- 🔵 **Cyan** - Video playing notifications
- 🟡 **Yellow** - Pause notifications
- 🟣 **Purple** - Stop notifications

## Configuration Tips

### Adding TV Screens to Props

To make this work with your server's props, you need to:

1. Identify prop models with screens (e.g., arcade machines, TVs)
2. Place props in your map
3. Scripts will automatically render videos on screens

**Common TV Props:**
- `v_res_msonline` - Computer screens
- `v_res_tw_laptop` - Laptop
- `prop_monitor_02` - Monitor
- `prop_tv_plasma_big` - Plasma TV
- `v_res_mexvid` - Mexican TV

### Example Property Setup

```lua
-- In your spawn script, spawn a TV prop:
local tvModel = GetHashKey("prop_tv_plasma_big")
RequestModel(tvModel)
while not HasModelLoaded(tvModel) do Wait(0) end

local tv = CreateObject(tvModel, 100.0, 100.0, 71.5, false, false, false)
SetEntityAsMissionEntity(tv, true, true)
```

## Advanced Usage

### Check TV Status
Use `/tvinfo` (admin command) to check current TV status:
```
/tvinfo
```

Returns:
- Current playback status (Playing/Idle)
- Current URL
- Pause state
- Who started the video

### Supported Video Sources

- ✅ YouTube links
- ✅ Direct MP4/WebM/OGG URLs
- ✅ HLS streams (M3U8)
- ✅ RTMP streams
- ✅ Twitch streams (requires proper linking)

## Troubleshooting

### Command not working?
- Ensure the script is running: `status` in console
- Check that you've typed the command correctly
- Make sure you have the resource started

### Video not playing?
- Verify the URL is correct and accessible
- Check that the video format is supported
- Ensure you're in a location with a TV prop

### Video not syncing?
- This is normal for small timing differences
- The server controls the state, clients sync automatically
- Try pausing and resuming to resync

## Customization

### Change Chat Colors

In `client.lua`, modify the color arrays in TriggerEvent calls:
```lua
color = {R, G, B}  -- RGB format (0-255)
```

### Add Permission Requirements

Add to top of server.lua:
```lua
function hasPermission(source)
    return IsPlayerAceAllowed(source, "tv.use") or true
end
```

Then check permissions in event handlers.

### Add Sound Effects

Register a sound when video plays:
```lua
TriggerEvent('audio:play', 'video_start_sound')
```

## Performance

- Minimal server load
- Client-side rendering
- Efficient event broadcasting
- Scales to 100+ players easily

## License

Free to use and modify for your FiveM server.

## Support

For issues or feature requests, check your FiveM server console for error messages.

---

**Version:** 1.0.0  
**Last Updated:** 2026-06-04  
**Compatibility:** ESX & Standalone
