fx_version 'cerulean'
game 'gta5'

author 'MaDHouSe'
description 'QB-loot is a dead corp loot system'
version '1.0'


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
}

dependencies {
        'qb-core',
        'qb-target',
}
