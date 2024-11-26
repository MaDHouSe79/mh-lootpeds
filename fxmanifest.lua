fx_version 'cerulean'
game 'gta5'

author 'MaDHouSe'
description 'MH-lootpeds - loot dead corp system'
version '1.0.0'

lua54 'yes'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua', -- change en to your language
	'config.lua',
}

client_scripts {
	'client/main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/update.lua',
}

dependencies {
    'qb-core',
	'mh-core'
}