local _, AS = ...

AS:AddMacros("MAGE", "General", {
    {
        name = "Ice Block",
        desc = "From Wowhead: stops casting and uses Ice Block. Press it again to cancel the block early.",
        src = "Retail",
        body = [=[
#showtooltip Ice Block
/stopcasting
/cancelaura Ice Block
/cast Ice Block]=],
    },
    {
        name = "Blink",
        desc = "From Wowhead: stops your current cast and blinks immediately.",
        src = "Retail",
        body = [=[
#showtooltip Blink
/stopcasting
/cast Blink]=],
    },
    {
        name = "Counterspell",
        desc = "From Wowhead: Counterspell your focus, mouseover, or target.",
        src = "Retail",
        body = [=[
#showtooltip Counterspell
/stopcasting
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Counterspell]=],
    },
    {
        name = "Polymorph",
        desc = "Polymorph your mouseover or focus without losing your current target.",
        body = [=[
#showtooltip Polymorph
/cast [@mouseover,harm,nodead][@focus,harm,nodead][] Polymorph]=],
    },
    {
        name = "Slow Fall",
        desc = "From Wowhead: Slow Fall on a friendly mouseover, or yourself. Press it again to cancel.",
        src = "Retail",
        body = [=[
#showtooltip Slow Fall
/cancelaura Slow Fall
/cast [@mouseover,help,nodead][@player] Slow Fall]=],
    },
    {
        name = "Intellect",
        desc = "Arcane Intellect on your mouseover or target. Shift for Arcane Brilliance.",
        body = [=[
#showtooltip
/cast [mod:shift] Arcane Brilliance; [@mouseover,help,nodead][] Arcane Intellect]=],
    },
    {
        name = "Decurse MO",
        desc = "Remove Lesser Curse on your mouseover, your target, or yourself.",
        body = [=[
#showtooltip Remove Lesser Curse
/cast [@mouseover,help,nodead][help,nodead][@player] Remove Lesser Curse]=],
    },
    {
        name = "Port",
        desc = "Teleports to a city, or opens a portal with Shift. Fill in the city name.",
        body = [=[
#showtooltip
/cast [mod:shift] Portal: <City>; Teleport: <City>]=],
    },
    {
        name = "Conjure",
        desc = "Conjures water, then food on the next press.",
        body = [=[
#showtooltip
/castsequence reset=60 Conjure Water, Conjure Food]=],
    },
    {
        name = "Nova Blink",
        desc = "Frost Nova, then Blink away on the next press.",
        body = [=[
#showtooltip
/castsequence reset=8 Frost Nova, Blink]=],
    },
})

AS:AddMacros("MAGE", "Arcane", {
    {
        name = "Arcane Burst",
        desc = "Adapted from Wowhead's cooldown macro: Arcane Power, Presence of Mind, racials and trinkets.",
        src = "Retail",
        body = [=[
#showtooltip Arcane Power
/cast Arcane Power
/cast Presence of Mind
/cast Berserking
/use 13
/use 14]=],
    },
    {
        name = "PoM Pyro",
        desc = "Adapted from Wowhead's Presence of Mind macro: Presence of Mind, then an instant Pyroblast.",
        src = "Retail",
        body = [=[
#showtooltip Presence of Mind
/cast Presence of Mind
/cast Pyroblast]=],
    },
    {
        name = "PoM Blast",
        desc = "From Wowhead: Presence of Mind, then an instant Arcane Blast.",
        src = "Retail",
        body = [=[
#showtooltip Presence of Mind
/cast Presence of Mind
/cast Arcane Blast]=],
    },
    {
        name = "Mana Gem",
        desc = "Uses your mana gem. Fill in your gem's name.",
        body = [=[
#showtooltip
/use <Mana Gem>]=],
    },
    {
        name = "Arcane Wrath MO",
        desc = "Arcane Wrath on your mouseover or target. Its damage grows with your maximum mana.",
        body = [=[
#showtooltip Arcane Wrath
/cast [@mouseover,harm,nodead][] Arcane Wrath]=],
    },
})

AS:AddMacros("MAGE", "Fire", {
    {
        name = "Combustion",
        desc = "From Wowhead: trinkets and racials, then Combustion.",
        src = "Retail",
        body = [=[
#showtooltip Combustion
/use 13
/use 14
/cast Blood Fury
/cast Berserking
/cast Combustion]=],
    },
    {
        name = "Flamestrike",
        desc = "From Wowhead: Flamestrike at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Flamestrike
/cast [@cursor] Flamestrike]=],
    },
    {
        name = "Fire Blast",
        desc = "Stops your current cast and fires an instant Fire Blast. Good for finishing low targets. Shares its 8 second cooldown with Ice Lance.",
        body = [=[
#showtooltip Fire Blast
/stopcasting
/cast Fire Blast]=],
    },
    {
        name = "Scorch MO",
        desc = "Scorch on your mouseover or target, to keep the debuff up on a second target.",
        body = [=[
#showtooltip Scorch
/cast [@mouseover,harm,nodead][] Scorch]=],
    },
    {
        name = "Blast Wave",
        desc = "Stops casting and uses Blast Wave for quick damage and a 50% slow around you.",
        body = [=[
#showtooltip Blast Wave
/stopcasting
/cast Blast Wave]=],
    },
    {
        name = "Frostfire MO",
        desc = "Frostfire Bolt on your mouseover or target. It slows the target and is checked against the lower of its Frost and Fire resistances.",
        body = [=[
#showtooltip Frostfire Bolt
/cast [@mouseover,harm,nodead][] Frostfire Bolt]=],
    },
})

AS:AddMacros("MAGE", "Frost", {
    {
        name = "Blizzard",
        desc = "From Wowhead: Blizzard at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Blizzard
/cast [@cursor] Blizzard]=],
    },
    {
        name = "Frost Burst",
        desc = "Ice Barrier (a shield that also gives 15% Frost damage for 1 minute, plus 5% while it holds), racial and trinkets on one button.",
        body = [=[
#showtooltip Ice Barrier
/cast Ice Barrier
/cast Berserking
/use 13
/use 14]=],
    },
    {
        name = "Snare Bolt",
        desc = "Rank 1 Frostbolt: a cheap, fast snare for kiting.",
        body = [=[
#showtooltip Frostbolt
/cast Frostbolt(Rank 1)]=],
    },
    {
        name = "Cold Snap",
        desc = "Cancels Ice Block and uses Cold Snap, so Ice Block is ready again right away.",
        body = [=[
#showtooltip Cold Snap
/cancelaura Ice Block
/cast Cold Snap]=],
    },
    {
        name = "Ice Lance MO",
        desc = "Ice Lance on your mouseover or target. Deals 300% more damage to frozen targets. Shares its 8 second cooldown with Fire Blast.",
        body = [=[
#showtooltip Ice Lance
/cast [@mouseover,harm,nodead][] Ice Lance]=],
    },
    {
        name = "Nova Lance",
        desc = "Frost Nova, then Ice Lance on the next press for the frozen damage bonus.",
        body = [=[
#showtooltip
/castsequence reset=6 Frost Nova, Ice Lance]=],
    },
})
