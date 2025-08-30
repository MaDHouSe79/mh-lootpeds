local Translations = {
    system = {
        ['enable'] = "Looting System Enable",
        ['disable'] = "Looting System Disable",
        ['start'] = "Start",
        ['stop'] = "Stop",
    },
    target = {
        ['label'] = "Loot this ped",
    },
    command = {
        ["start_stop"] = "%{state} Ped Looting",
        ["on_or_off"] = "On/Off",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})