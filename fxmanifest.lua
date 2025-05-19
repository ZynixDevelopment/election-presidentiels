fx_version 'cerulean'
game 'gta5'

author 'ZynixDevelopment'
description 'Système d\'élection présidentielle avec blip, menu candidat et vote pour FiveM ESX'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua'
}

server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

dependency 'es_extended'
dependency 'esx_menu_default'
