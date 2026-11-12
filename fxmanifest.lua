fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dps-fixes'
author 'Del Perro Sands'
description 'DPS small fixes in one place: unstick + Esc guard, Krystal Casino sign, routing bucket fix, weather bridge. New small fixes go here too.'
version '1.0.0'

client_scripts {
    'client/unfocus.lua',
    'client/krystal.lua',
    'client/weather.lua',
}

server_scripts {
    'server/bucket.lua',
    'server/weather.lua',
}
