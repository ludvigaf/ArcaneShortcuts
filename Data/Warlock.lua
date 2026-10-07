local _, AS = ...

AS:AddMacros("WARLOCK", "General", {
    {
        name = "Soulstone MO",
        desc = "Adapted from Wowhead: uses your soulstone on a friendly mouseover, your target, or yourself. Fill in your soulstone's name.",
        src = "Retail",
        body = [=[
#showtooltip <Soulstone>
/use [@mouseover,help,nodead][help,nodead][@player] <Soulstone>]=],
    },
    {
        name = "Healthstone",
        desc = "Adapted from Wowhead: uses your healthstone. Fill in its name, for example Major Healthstone.",
        src = "Retail",
        body = [=[
#showtooltip <Healthstone>
/use <Healthstone>]=],
    },
    {
        name = "Pet Attack",
        desc = "Sends your demon in and applies Curse of Agony.",
        body = [=[
#showtooltip Curse of Agony
/petattack
/cast Curse of Agony]=],
    },
    {
        name = "Fear MO",
        desc = "Fear on your mouseover or focus without changing target.",
        body = [=[
#showtooltip Fear
/cast [@mouseover,harm,nodead][@focus,harm,nodead][] Fear]=],
    },
    {
        name = "Banish MO",
        desc = "Banish on your mouseover or focus.",
        body = [=[
#showtooltip Banish
/cast [@mouseover,harm,nodead][@focus,harm,nodead][] Banish]=],
    },
    {
        name = "Spell Lock",
        desc = "Your Felhunter interrupts your focus or target.",
        body = [=[
#showtooltip Spell Lock
/cast [@focus,harm,nodead][] Spell Lock]=],
    },
    {
        name = "Devour MO",
        desc = "Your Felhunter's Devour Magic on a friendly mouseover, or yourself.",
        body = [=[
#showtooltip Devour Magic
/cast [@mouseover,help,nodead][@player] Devour Magic]=],
    },
    {
        name = "Seduce Focus",
        desc = "Your Succubus seduces your focus or mouseover.",
        body = [=[
#showtooltip Seduction
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Seduction]=],
    },
    {
        name = "Corruption MO",
        desc = "Corruption on your mouseover or target. Spread dots without changing target.",
        body = [=[
#showtooltip Corruption
/cast [@mouseover,harm,nodead][] Corruption]=],
    },
    {
        name = "Life Tap",
        desc = "Life Tap that also clears the error spam if you are at full mana.",
        body = [=[
#showtooltip Life Tap
/cast Life Tap
/run UIErrorsFrame:Clear()]=],
    },
})

AS:AddMacros("WARLOCK", "Affliction", {
    {
        name = "Agony MO",
        desc = "Curse of Agony on your mouseover or target.",
        body = [=[
#showtooltip Curse of Agony
/cast [@mouseover,harm,nodead][] Curse of Agony]=],
    },
    {
        name = "UA MO",
        desc = "Unstable Affliction on your mouseover or target.",
        body = [=[
#showtooltip Unstable Affliction
/cast [@mouseover,harm,nodead][] Unstable Affliction]=],
    },
    {
        name = "Amplified CoA",
        desc = "Amplify Curse, then Curse of Agony.",
        body = [=[
#showtooltip Amplify Curse
/cast Amplify Curse
/cast Curse of Agony]=],
    },
    {
        name = "Siphon MO",
        desc = "Siphon Life on your mouseover or target.",
        body = [=[
#showtooltip Siphon Life
/cast [@mouseover,harm,nodead][] Siphon Life]=],
    },
})

AS:AddMacros("WARLOCK", "Demonology", {
    {
        name = "Fel Summon",
        desc = "Fel Domination, then a summon. Felhunter by default, Voidwalker with Shift, Succubus with Ctrl, Felguard with Alt.",
        body = [=[
#showtooltip
/cast Fel Domination
/cast [mod:shift] Summon Voidwalker; [mod:ctrl] Summon Succubus; [mod:alt] Summon Felguard; Summon Felhunter]=],
    },
    {
        name = "Sacrifice",
        desc = "Your Voidwalker's Sacrifice shield.",
        body = [=[
#showtooltip Sacrifice
/cast Sacrifice]=],
    },
    {
        name = "Demo Burst",
        desc = "Sends your demon in, uses trinkets and racials, then casts Shadow Bolt.",
        body = [=[
#showtooltip Shadow Bolt
/petattack
/use 13
/use 14
/cast Blood Fury
/cast Shadow Bolt]=],
    },
    {
        name = "Shadowfury",
        desc = "From Wowhead: Shadowfury at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Shadowfury
/cast [@cursor] Shadowfury]=],
    },
})

AS:AddMacros("WARLOCK", "Destruction", {
    {
        name = "Immolate MO",
        desc = "From Wowhead: Immolate on your mouseover or target.",
        src = "Retail",
        body = [=[
#showtooltip Immolate
/cast [@mouseover,harm,nodead][] Immolate]=],
    },
    {
        name = "Rain of Fire",
        desc = "From Wowhead: Rain of Fire at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Rain of Fire
/cast [@cursor] Rain of Fire]=],
    },
    {
        name = "Shadowfury",
        desc = "From Wowhead: Shadowfury at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Shadowfury
/cast [@cursor] Shadowfury]=],
    },
    {
        name = "Infernal",
        desc = "From Wowhead: Inferno (Summon Infernal) at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Inferno
/cast [@cursor] Inferno]=],
    },
    {
        name = "Shadowburn",
        desc = "Stops casting and finishes the target with Shadowburn.",
        body = [=[
#showtooltip Shadowburn
/stopcasting
/cast Shadowburn]=],
    },
    {
        name = "Conflagrate",
        desc = "Conflagrate when it is ready, otherwise Immolate.",
        body = [=[
#showtooltip
/cast Conflagrate
/cast Immolate]=],
    },
})
