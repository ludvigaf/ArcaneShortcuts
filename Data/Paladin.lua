local _, AS = ...

AS:AddMacros("PALADIN", "General", {
    {
        name = "Bubble",
        desc = "From Wowhead: stops casting and refreshes Divine Shield. Press it again to cancel the shield.",
        src = "Retail",
        body = [=[
#showtooltip Divine Shield
/stopcasting
/cancelaura Divine Shield
/cast Divine Shield]=],
    },
    {
        name = "Bubble Hearth",
        desc = "The classic escape: Divine Shield, then Hearthstone.",
        body = [=[
#showtooltip Hearthstone
/cast Divine Shield
/use Hearthstone]=],
    },
    {
        name = "Lay on Hands",
        desc = "From Wowhead: Lay on Hands on your mouseover, or on your target's target if you have no friendly mouseover.",
        src = "Retail",
        body = [=[
#showtooltip Lay on Hands
/stopcasting
/cast [@mouseover,help,nodead][@targettarget,help,nodead][] Lay on Hands]=],
    },
    {
        name = "Freedom MO",
        desc = "From Wowhead: Blessing of Freedom on your mouseover, your target, or yourself.",
        src = "Retail",
        body = [=[
#showtooltip Blessing of Freedom
/cast [@mouseover,help,nodead][help,nodead][@player] Blessing of Freedom]=],
    },
    {
        name = "Protection MO",
        desc = "Blessing of Protection on your mouseover, your target, or yourself.",
        body = [=[
#showtooltip Blessing of Protection
/cast [@mouseover,help,nodead][help,nodead][@player] Blessing of Protection]=],
    },
    {
        name = "Sacrifice MO",
        desc = "From Wowhead: Blessing of Sacrifice on your mouseover or friendly target.",
        src = "Retail",
        body = [=[
#showtooltip Blessing of Sacrifice
/cast [@mouseover,help,nodead][help,nodead] Blessing of Sacrifice]=],
    },
    {
        name = "HoJ Focus",
        desc = "Adapted from Wowhead's Rebuke focus macro: Hammer of Justice on your focus, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Hammer of Justice
/cast [@focus,harm,nodead][] Hammer of Justice]=],
    },
    {
        name = "Cleanse MO",
        desc = "Cleanses your mouseover, your target, or yourself.",
        body = [=[
#showtooltip Cleanse
/cast [@mouseover,help,nodead][help,nodead][@player] Cleanse]=],
    },
    {
        name = "Blessing",
        desc = "Blessing of Might on your mouseover or target. Shift for Blessing of Wisdom, Ctrl for Blessing of Kings.",
        body = [=[
#showtooltip
/cast [mod:shift,@mouseover,help,nodead][mod:shift] Blessing of Wisdom; [mod:ctrl,@mouseover,help,nodead][mod:ctrl] Blessing of Kings; [@mouseover,help,nodead][] Blessing of Might]=],
    },
    {
        name = "Holy Strike",
        desc = "Holy Strike with auto-attack. Forever's core strike for Holy and Retribution paladins.",
        body = [=[
#showtooltip Holy Strike
/startattack
/cast Holy Strike]=],
    },
    {
        name = "Voice of Truth",
        desc = "Immunity to Silence and Interrupt effects for 6 seconds. Press it just before a cast you can't afford to lose.",
        body = [=[
#showtooltip Voice of Truth
/cast Voice of Truth]=],
    },
})

AS:AddMacros("PALADIN", "Holy", {
    {
        name = "Holy Shock MO",
        desc = "From Wowhead: Holy Shock heals a friendly mouseover or damages a hostile one.",
        src = "Retail",
        body = [=[
#showtooltip Holy Shock
/cast [@mouseover,exists,nodead][] Holy Shock]=],
    },
    {
        name = "Flash of Light",
        desc = "Flash of Light on your mouseover, or your target.",
        body = [=[
#showtooltip Flash of Light
/cast [@mouseover,help,nodead][] Flash of Light]=],
    },
    {
        name = "Holy Light",
        desc = "Holy Light on your mouseover, or your target.",
        body = [=[
#showtooltip Holy Light
/cast [@mouseover,help,nodead][] Holy Light]=],
    },
    {
        name = "Favor HL",
        desc = "Divine Favor followed by a guaranteed critical Holy Light on your mouseover.",
        body = [=[
#showtooltip Divine Favor
/cast Divine Favor
/cast [@mouseover,help,nodead][] Holy Light]=],
    },
    {
        name = "Healer Judge",
        desc = "From Wowhead: starts attacking and judges your target to keep your seal debuff active while healing.",
        src = "Retail",
        body = [=[
#showtooltip Judgement
/startattack
/cast Judgement]=],
    },
    {
        name = "Oath of Light",
        desc = "Swears Oath of Light (Holy talent) on your mouseover, your target, or yourself. It boosts your Holy Light, Flash of Light and Holy Shock on them for 5 minutes.",
        body = [=[
#showtooltip Oath of Light
/cast [@mouseover,help,nodead][help,nodead][@player] Oath of Light]=],
    },
    {
        name = "Light's Vigil MO",
        desc = "Light's Vigil on your mouseover or target. Your next Holy Shock on them has no cooldown and also heals their party.",
        body = [=[
#showtooltip Light's Vigil
/cast [@mouseover,help,nodead][] Light's Vigil]=],
    },
})

AS:AddMacros("PALADIN", "Protection", {
    {
        name = "Holy Shield",
        desc = "Holy Shield that also starts auto-attack.",
        body = [=[
#showtooltip Holy Shield
/startattack
/cast Holy Shield]=],
    },
    {
        name = "Fury Check",
        desc = "Turns on Righteous Fury without ever cancelling it.",
        body = [=[
#showtooltip Righteous Fury
/cast !Righteous Fury]=],
    },
    {
        name = "Fury Taunt",
        desc = "Forever's paladin taunt: Judgement with Seal of Fury active taunts your mouseover or target for 3 seconds (10 yards). Judgement no longer consumes the Seal. Shift puts up Seal of Fury first.",
        body = [=[
#showtooltip Judgement
/startattack [@mouseover,harm,nodead][]
/cast [mod:shift] Seal of Fury; [@mouseover,harm,nodead][] Judgement]=],
    },
    {
        name = "Consecrate",
        desc = "Consecration with trinkets. Use it for AoE threat.",
        body = [=[
#showtooltip Consecration
/use 13
/use 14
/cast Consecration]=],
    },
    {
        name = "Hammer Righteous",
        desc = "Hammer of the Righteous with auto-attack. Hits your target and up to 3 nearby enemies.",
        body = [=[
#showtooltip Hammer of the Righteous
/startattack
/cast Hammer of the Righteous]=],
    },
})

AS:AddMacros("PALADIN", "Retribution", {
    {
        name = "Ret Burst",
        desc = "Both trinkets, then Swift Judgement (Retribution talent), an extra Judgement that does not share a cooldown with your normal one.",
        body = [=[
#showtooltip Swift Judgement
/use 13
/use 14
/cast Swift Judgement]=],
    },
    {
        name = "Seal & Judge",
        desc = "Puts up Seal of Command, and the next press judges it. Resets after 10 seconds.",
        body = [=[
#showtooltip
/startattack
/castsequence reset=10 Seal of Command, Judgement]=],
    },
    {
        name = "Hammer of Wrath",
        desc = "Hammer of Wrath on your mouseover or target. Usable on targets below 20% health.",
        body = [=[
#showtooltip Hammer of Wrath
/cast [@mouseover,harm,nodead][] Hammer of Wrath]=],
    },
    {
        name = "Repentance MO",
        desc = "Repentance on your mouseover or focus, so you can crowd control without changing target.",
        body = [=[
#showtooltip Repentance
/cast [@mouseover,harm,nodead][@focus,harm,nodead][] Repentance]=],
    },
})
