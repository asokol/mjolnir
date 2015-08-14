local application = require "mjolnir.application"
local window = require "mjolnir.window"
local screen = require "mjolnir.screen"
local fnutils = require "mjolnir.fnutils"
local hotkey = require "mjolnir.hotkey"
local alert = require "mjolnir.alert"
local grid = require "mjolnir.bg.grid"
local appfinder = require "mjolnir.cmsj.appfinder"
local hints = require "mjolnir.th.hints"


grid.GRIDWIDTH = 4
grid.GRIDHEIGHT = 4
grid.MARGINX = 0
grid.MARGINY = 10

local hyper = {"cmd", "alt", "ctrl"}


local gridset = function(x, y, w, h)
    return function()
        cur_window = window.focusedwindow()
        grid.set(
            cur_window,
            {x=x, y=y, w=w, h=h},
            cur_window:screen()
        )
    end
end


hotkey.bind(hyper, 'c', mjolnir.openconsole)
hotkey.bind(hyper, 'r', mjolnir.reload)

-- window positions
-- left
hotkey.bind(hyper, 'a', gridset(0, 0, 2, 4))
hotkey.bind(hyper, 'q', gridset(0, 0, 2, 2))
-- center
hotkey.bind(hyper, 's', gridset(1, 0, 2, 4))
-- right
hotkey.bind(hyper, 'd', gridset(2, 0, 2, 4))
hotkey.bind(hyper, 'e', gridset(2, 0, 2, 2))
-- maximaze
hotkey.bind(hyper, 'z', gridset(0, 0, 4, 4))

-- application launching
hotkey.bind(hyper, 'h', hints.windowHints)
hotkey.bind(hyper, 'j', function() application.launchorfocus("Sublime Text") end)
hotkey.bind(hyper, 'k', function() application.launchorfocus("Terminal") end)
hotkey.bind(hyper, 'l', function() application.launchorfocus("Google Chrome") end)
hotkey.bind(hyper, ';', function() application.launchorfocus("Evernote") end)


-- send windows to different screens
hotkey.bind( hyper, 'n', function() move_to_next(window.focusedwindow()) end)

function move_to_next(w)
    current_screen = w:screen()
    next_screen = current_screen:previous()

    w:settopleft(
        {x=next_screen:frame()["x"], y=next_screen:frame()["y"]}
    )
end

alert.show("Mjolnir config loaded")
