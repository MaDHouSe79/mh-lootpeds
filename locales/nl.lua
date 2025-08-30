local Translations = {
    system = {
        ['enable'] = "Looting System Enable",
        ['disable'] = "Looting System Disable",
        ['start'] = "Start",
        ['stop'] = "Stop",
    },
    target = {
        ['label'] = "Plunder deze ped",
    },
    command = {
        ["start_stop"] = "%{state} Ped Plundering",
        ["on_or_off"] = "On/Off",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})