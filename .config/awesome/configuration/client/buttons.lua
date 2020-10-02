local gears = require('gears')

local awful = require('awful')
local modkey = require('configuration.keys.mod').mod_key

return gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise()
                 mymainmenu:hide() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

