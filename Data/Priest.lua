local _, AS = ...

AS:AddMacros("PRIEST", "General", {
    {
        name = "Flash Heal MO",
        desc = "From Wowhead: Flash Heal on your mouseover, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Flash Heal
/cast [@mouseover,help,nodead][] Flash Heal]=],
    },
    {
        name = "Shield MO",
        desc = "Power Word: Shield on your mouseover, your target, or yourself.",
        body = [=[
#showtooltip Power Word: Shield
/cast [@mouseover,help,nodead][help,nodead][@player] Power Word: Shield]=],
    },
    {
        name = "Renew MO",
        desc = "Renew on your mouseover, your target, or yourself.",
        body = [=[
#showtooltip Renew
/cast [@mouseover,help,nodead][help,nodead][@player] Renew]=],
    },
    {
        name = "Dispel MO",
        desc = "Dispel Magic: removes debuffs from a friendly mouseover or strips buffs from a hostile one.",
        body = [=[
#showtooltip Dispel Magic
/cast [@mouseover,exists,nodead][] Dispel Magic]=],
    },
    {
        name = "Fade",
        desc = "Stops casting and fades to drop threat.",
        body = [=[
#showtooltip Fade
/stopcasting
/cast Fade]=],
    },
    {
        name = "Fortitude",
        desc = "Power Word: Fortitude on your mouseover or target. Shift for Prayer of Fortitude.",
        body = [=[
#showtooltip
/cast [mod:shift] Prayer of Fortitude; [@mouseover,help,nodead][] Power Word: Fortitude]=],
    },
    {
        name = "Shackle Focus",
        desc = "Shackle Undead on your focus or mouseover.",
        body = [=[
#showtooltip Shackle Undead
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Shackle Undead]=],
    },
    {
        name = "Fear Ward MO",
        desc = "Fear Ward on your mouseover, your target, or yourself.",
        body = [=[
#showtooltip Fear Ward
/cast [@mouseover,help,nodead][help,nodead][@player] Fear Ward]=],
    },
    {
        name = "Levitate",
        desc = "Levitate on yourself, or on a friendly mouseover.",
        body = [=[
#showtooltip Levitate
/cast [@mouseover,help,nodead][@player] Levitate]=],
    },
    {
        name = "Divine Grace MO",
        desc = "Divine Grace on your mouseover or target: an instant emergency heal for a friend below 50% health that also removes Weakened Soul. It can't target yourself.",
        body = [=[
#showtooltip Divine Grace
/cast [@mouseover,help,nodead][help,nodead] Divine Grace]=],
    },
    {
        name = "Contingency MO",
        desc = "Gnome priests: Contingency Plan on your mouseover, your target, or yourself. If they drop below 35% health within 30 seconds, they get a shield and a heal.",
        body = [=[
#showtooltip Contingency Plan
/cast [@mouseover,help,nodead][help,nodead][@player] Contingency Plan]=],
    },
})

AS:AddMacros("PRIEST", "Discipline", {
    {
        name = "Power Infusion",
        desc = "From Wowhead: Power Infusion on your mouseover, your target, or yourself.",
        src = "Retail",
        body = [=[
#showtooltip Power Infusion
/cast [@mouseover,help,nodead][help,nodead][@player] Power Infusion]=],
    },
    {
        name = "PI Named",
        desc = "From Wowhead: Power Infusion on a named player such as your top DPS, falling back to yourself. Fill in their name.",
        src = "Retail",
        body = [=[
#showtooltip Power Infusion
/cast [@<Player Name>,help,nodead][@player] Power Infusion]=],
    },
    {
        name = "Inner Focus",
        desc = "Inner Focus followed by a free Greater Heal on your mouseover.",
        body = [=[
#showtooltip Inner Focus
/cast Inner Focus
/cast [@mouseover,help,nodead][] Greater Heal]=],
    },
    {
        name = "Smite MO",
        desc = "From Wowhead: Smite your mouseover enemy, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Smite
/cast [@mouseover,harm,nodead][] Smite]=],
    },
    {
        name = "Penance MO",
        desc = "Penance on your mouseover, or your target: heals a friend or damages an enemy.",
        body = [=[
#showtooltip Penance
/cast [@mouseover,exists,nodead][] Penance]=],
    },
})

AS:AddMacros("PRIEST", "Holy", {
    {
        name = "Greater Heal MO",
        desc = "Greater Heal on your mouseover, or your target.",
        body = [=[
#showtooltip Greater Heal
/cast [@mouseover,help,nodead][] Greater Heal]=],
    },
    {
        name = "Heal MO",
        desc = "Heal on your mouseover, or your target. Mana-efficient filler.",
        body = [=[
#showtooltip Heal
/cast [@mouseover,help,nodead][] Heal]=],
    },
    {
        name = "IF PoH",
        desc = "Inner Focus followed by a free Prayer of Healing.",
        body = [=[
#showtooltip Prayer of Healing
/cast Inner Focus
/cast Prayer of Healing]=],
    },
    {
        name = "Mending MO",
        desc = "Prayer of Mending on your mouseover, or your target.",
        body = [=[
#showtooltip Prayer of Mending
/cast [@mouseover,help,nodead][] Prayer of Mending]=],
    },
})

AS:AddMacros("PRIEST", "Shadow", {
    {
        name = "Shadowform",
        desc = "Enters Shadowform without ever cancelling it.",
        src = "Retail",
        body = [=[
#showtooltip Shadowform
/cast !Shadowform]=],
    },
    {
        name = "SW:P MO",
        desc = "Shadow Word: Pain on your mouseover or target. Spread dots without changing target.",
        body = [=[
#showtooltip Shadow Word: Pain
/cast [@mouseover,harm,nodead][] Shadow Word: Pain]=],
    },
    {
        name = "Mind Blast",
        desc = "Mind Blast on your mouseover or target.",
        body = [=[
#showtooltip Mind Blast
/cast [@mouseover,harm,nodead][] Mind Blast]=],
    },
    {
        name = "Silence Focus",
        desc = "Silence your focus, mouseover, or target.",
        body = [=[
#showtooltip Silence
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Silence]=],
    },
    {
        name = "SW:D MO",
        desc = "Shadow Word: Death on your mouseover, or your target. Use it to finish off low-health enemies: if the target survives, you take 30% of your maximum health.",
        body = [=[
#showtooltip Shadow Word: Death
/cast [@mouseover,harm,nodead][] Shadow Word: Death]=],
    },
})
