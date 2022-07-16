fx_version 'cerulean'
game 'gta5'

author 'MaDHouSe'
description 'MaDHouSe Loot System, made for QBCore'
version '1.0'


lua54 'yes'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/nl.lua', -- change en to your language
	'config.lua',
}

client_scripts {
	'client/main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
}

dependencies {
    'qb-core',
	'qb-target',
}
