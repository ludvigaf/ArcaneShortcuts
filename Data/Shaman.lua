local _, AS = ...

AS:AddMacros("SHAMAN", "General", {
    {
        name = "Interrupt",
        desc = "Rank 1 Earth Shock on your focus or target: a cheap interrupt that costs almost no mana.",
        body = [=[
#showtooltip Earth Shock
/cast [@focus,harm,nodead][] Earth Shock(Rank 1)]=],
    },
    {
        name = "Purge MO",
        desc = "Purge your mouseover or target.",
        body = [=[
#showtooltip Purge
/cast [@mouseover,harm,nodead][] Purge]=],
    },
    {
        name = "Ghost Wolf",
        desc = "Enters Ghost Wolf and never cancels it when pressed twice.",
        body = [=[
#showtooltip Ghost Wolf
/cast !Ghost Wolf]=],
    },
    {
        name = "Self Heal",
        desc = "Adapted from Wowhead's self-cast Healing Surge macro: Lesser Healing Wave on yourself.",
        src = "Retail",
        body = [=[
#showtooltip Lesser Healing Wave
/cast [@player] Lesser Healing Wave]=],
    },
    {
        name = "Cure MO",
        desc = "Cure Poison on your mouseover or target. Shift for Cure Disease.",
        body = [=[
#showtooltip
/cast [mod:shift,@mouseover,help,nodead][mod:shift] Cure Disease; [@mouseover,help,nodead][] Cure Poison]=],
    },
    {
        name = "Totems",
        desc = "Drops one totem per press: Strength of Earth, Searing, Mana Spring, Windfury. Resets after combat or 20 seconds.",
        body = [=[
#showtooltip
/castsequence reset=combat/20 Strength of Earth Totem, Searing Totem, Mana Spring Totem, Windfury Totem]=],
    },
    {
        name = "Grounding",
        desc = "Grounding Totem that stops your current cast first.",
        body = [=[
#showtooltip Grounding Totem
/stopcasting
/cast Grounding Totem]=],
    },
    {
        name = "Shield Toggle",
        desc = "Lightning Shield normally, Water Shield with Shift.",
        body = [=[
#showtooltip
/cast [mod:shift] Water Shield; Lightning Shield]=],
    },
    {
        name = "Totemic Recall",
        desc = "Recalls your totems and gives back some of their mana. Use it after a fight.",
        body = [=[
#showtooltip Totemic Recall
/cast Totemic Recall]=],
    },
    {
        name = "Totem Bars",
        desc = "Places the totems set on your Totem Bar in one cast: Call of the Elements by default, Call of the Ancestors with Shift, Call of the Spirits with Ctrl.",
        body = [=[
#showtooltip
/cast [mod:shift] Call of the Ancestors; [mod:ctrl] Call of the Spirits; Call of the Elements]=],
    },
    {
        name = "Totemic Call",
        desc = "Moves your active totems to where you are standing (30 second cooldown), so you can reposition without dropping them again.",
        body = [=[
#showtooltip Totemic Call
/cast Totemic Call]=],
    },
    {
        name = "Fire Nova",
        desc = "Fire Nova: instant fire damage to enemies within 10 yards of your active Fire totem. No longer a totem of its own on Forever.",
        body = [=[
#showtooltip Fire Nova
/cast Fire Nova]=],
    },
})

AS:AddMacros("SHAMAN", "Elemental", {
    {
        name = "Ele Burst",
        desc = "Adapted from Wowhead's Ascendance opener: Lightning Mastery (Forever's renamed Elemental Mastery: faster Lightning Bolt and no Chain Lightning cooldown for 15 seconds), trinket and racial, then Chain Lightning.",
        src = "Retail",
        body = [=[
#showtooltip Lightning Mastery
/use 13
/cast Berserking
/cast Blood Fury
/cast Lightning Mastery
/cast Chain Lightning]=],
    },
    {
        name = "NS Bolt",
        desc = "Adapted from Wowhead: Nature's Swiftness followed by an instant Lightning Bolt.",
        src = "Retail",
        body = [=[
#showtooltip Nature's Swiftness
/cast Nature's Swiftness
/cast Lightning Bolt]=],
    },
    {
        name = "Flame Shock MO",
        desc = "Flame Shock on your mouseover or target.",
        body = [=[
#showtooltip Flame Shock
/cast [@mouseover,harm,nodead][] Flame Shock]=],
    },
})

AS:AddMacros("SHAMAN", "Enhancement", {
    {
        name = "Stormstrike",
        desc = "Stormstrike that also starts auto-attack.",
        body = [=[
#showtooltip Stormstrike
/startattack
/cast Stormstrike]=],
    },
    {
        name = "Enh Burst",
        desc = "Rage of the Farseer (30% attack speed for 25 seconds), racials and trinkets, then Stormstrike.",
        body = [=[
#showtooltip Rage of the Farseer
/cast Rage of the Farseer
/cast Blood Fury
/cast Berserking
/use 13
/use 14
/startattack
/cast Stormstrike]=],
    },
    {
        name = "Weapon Buffs",
        desc = "Casts Windfury Weapon, then Flametongue Weapon on the next press. Rebuff both weapons with one key.",
        body = [=[
#showtooltip
/castsequence reset=30 Windfury Weapon, Flametongue Weapon]=],
    },
    {
        name = "Shock",
        desc = "Earth Shock normally, Frost Shock with Shift.",
        body = [=[
#showtooltip
/startattack
/cast [mod:shift] Frost Shock; Earth Shock]=],
    },
})

AS:AddMacros("SHAMAN", "Restoration", {
    {
        name = "NS Heal",
        desc = "Nature's Swiftness, then an instant Healing Wave on your mouseover or target.",
        body = [=[
#showtooltip Nature's Swiftness
/cast Nature's Swiftness
/cast [@mouseover,help,nodead][] Healing Wave]=],
    },
    {
        name = "Chain Heal MO",
        desc = "From Wowhead's mouseover macros: Chain Heal on your mouseover, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Chain Heal
/cast [@mouseover,help,nodead][] Chain Heal]=],
    },
    {
        name = "Wave MO",
        desc = "Healing Wave on your mouseover, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Healing Wave
/cast [@mouseover,help,nodead][] Healing Wave]=],
    },
    {
        name = "LHW MO",
        desc = "Lesser Healing Wave on your mouseover, or your target.",
        body = [=[
#showtooltip Lesser Healing Wave
/cast [@mouseover,help,nodead][] Lesser Healing Wave]=],
    },
    {
        name = "Heal / Bolt",
        desc = "From Wowhead's help/harm template: Healing Wave on a friendly mouseover, Lightning Bolt on an enemy.",
        src = "Retail",
        body = [=[
#showtooltip
/cast [@mouseover,help,nodead] Healing Wave; [@mouseover,harm,nodead][harm] Lightning Bolt; Healing Wave]=],
    },
    {
        name = "Mana Tide",
        desc = "Mana Tide Totem with your trinkets.",
        body = [=[
#showtooltip Mana Tide Totem
/use 13
/use 14
/cast Mana Tide Totem]=],
    },
    {
        name = "Riptide MO",
        desc = "Riptide on your mouseover, or your target, or yourself.",
        body = [=[
#showtooltip Riptide
/cast [@mouseover,help,nodead][help,nodead][@player] Riptide]=],
    },
})
