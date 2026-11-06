local _, AS = ...

AS:AddMacros("ROGUE", "General", {
    {
        name = "Sap + Pocket",
        desc = "Pick Pocket and Sap in one press. Pick Pocket is off the global cooldown, so both go off.",
        src = "Retail",
        body = [=[
#showtooltip Sap
/cast Pick Pocket
/cast Sap]=],
    },
    {
        name = "Opener",
        desc = "Cheap Shot from stealth, Sinister Strike otherwise.",
        body = [=[
#showtooltip
/startattack [nostealth]
/cast [stealth] Cheap Shot; Sinister Strike]=],
    },
    {
        name = "Kick Focus",
        desc = "From Wowhead: Kick your focus, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Kick
/cast [@focus,harm,nodead][] Kick]=],
    },
    {
        name = "Kidney MO",
        desc = "From Wowhead: Kidney Shot your mouseover, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Kidney Shot
/cast [@mouseover,harm,nodead][] Kidney Shot]=],
    },
    {
        name = "Blind MO",
        desc = "From Wowhead: Blind your mouseover, or your focus or target.",
        src = "Retail",
        body = [=[
#showtooltip Blind
/cast [@mouseover,harm,nodead][@focus,harm,nodead][] Blind]=],
    },
    {
        name = "Distract",
        desc = "From Wowhead: Distract at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Distract
/cast [@cursor] Distract]=],
    },
    {
        name = "Stealth",
        desc = "Enters Stealth and never cancels it when pressed twice.",
        body = [=[
#showtooltip Stealth
/cast !Stealth]=],
    },
    {
        name = "Vanish",
        desc = "Stops attacking before vanishing, so you don't break stealth right away.",
        body = [=[
#showtooltip Vanish
/stopattack
/cast Vanish]=],
    },
    {
        name = "Poison MH",
        desc = "Applies a poison to your main hand and confirms the replace prompt.",
        body = [=[
#showtooltip <Main Hand Poison>
/use <Main Hand Poison>
/use 16
/click StaticPopup1Button1]=],
    },
    {
        name = "Poison OH",
        desc = "Applies a poison to your off-hand and confirms the replace prompt.",
        body = [=[
#showtooltip <Off-Hand Poison>
/use <Off-Hand Poison>
/use 17
/click StaticPopup1Button1]=],
    },
    {
        name = "Gouge Focus",
        desc = "Gouge your focus or mouseover.",
        body = [=[
#showtooltip Gouge
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Gouge]=],
    },
    {
        name = "Shank",
        desc = "Shank with auto-attack: a cheap off-hand strike that gives 25 Energy and cannot miss. Assassination rogues with Venom also boost their poisons with it.",
        body = [=[
#showtooltip Shank
/startattack
/cast Shank]=],
    },
    {
        name = "Redirect",
        desc = "Takes your combo points off the current target and stores them for 15 seconds. The next non-player enemy you hit gets them.",
        body = [=[
#showtooltip Redirect
/cast Redirect]=],
    },
})

AS:AddMacros("ROGUE", "Assassination", {
    {
        name = "Assa Burst",
        desc = "Adapted from Wowhead's Deathmark opener: trinket and Cold Blood, then Eviscerate.",
        src = "Retail",
        body = [=[
#showtooltip Cold Blood
/use 13
/cast Cold Blood
/cast Eviscerate]=],
    },
    {
        name = "Ambush/Muti",
        desc = "Ambush or Garrote from stealth (Shift for Garrote), Mutilate otherwise.",
        body = [=[
#showtooltip
/cast [stealth,mod:shift] Garrote; [stealth] Ambush; Mutilate]=],
    },
    {
        name = "Ambush/Stab",
        desc = "Ambush from stealth, Backstab otherwise. For dagger leveling without Mutilate.",
        body = [=[
#showtooltip
/startattack [nostealth]
/cast [stealth] Ambush; Backstab]=],
    },
})

AS:AddMacros("ROGUE", "Combat", {
    {
        name = "Combat Burst",
        desc = "Blade Flurry, Adrenaline Rush, racials and trinkets.",
        body = [=[
#showtooltip Adrenaline Rush
/cast Blade Flurry
/cast Adrenaline Rush
/cast Blood Fury
/cast Berserking
/use 13
/use 14]=],
    },
    {
        name = "Riposte/SS",
        desc = "Riposte when you have parried, Sinister Strike otherwise.",
        body = [=[
#showtooltip
/startattack
/cast Riposte
/cast Sinister Strike]=],
    },
    {
        name = "Sprint Escape",
        desc = "Uses your PvP trinket to break crowd control, then Sprint. Fill in your trinket's name.",
        body = [=[
#showtooltip Sprint
/use <PvP Trinket>
/cast Sprint]=],
    },
})

AS:AddMacros("ROGUE", "Subtlety", {
    {
        name = "Shadowstrike",
        desc = "Adapted from Wowhead's Shadowstrike/Backstab macro: Ambush in stealth, Hemorrhage outside.",
        src = "Retail",
        body = [=[
#showtooltip
/startattack [nostealth]
/cast [stealth] Ambush; Hemorrhage]=],
    },
    {
        name = "Premed Opener",
        desc = "Premeditation, then Cheap Shot from stealth.",
        body = [=[
#showtooltip Cheap Shot
/cast Premeditation
/cast Cheap Shot]=],
    },
    {
        name = "Sap Enemy",
        desc = "From Wowhead's PvP section: targets the nearest enemy player and saps them.",
        src = "Retail",
        body = [=[
#showtooltip Sap
/cleartarget
/targetenemyplayer
/cast Sap]=],
    },
    {
        name = "Prep Vanish",
        desc = "Preparation, then Vanish again.",
        body = [=[
#showtooltip Preparation
/stopattack
/cast Preparation
/cast Vanish]=],
    },
    {
        name = "Death Mark",
        desc = "Death Mark (Subtlety talent) on your mouseover or target: a finishing move that stores damage and releases it after 6 seconds. Garrote and Rupture store at twice the rate.",
        body = [=[
#showtooltip Death Mark
/cast [@mouseover,harm,nodead][] Death Mark]=],
    },
    {
        name = "Ghostly Ambush",
        desc = "Ghostly Strike, then Ambush on the next press. Ghostly Strike lets your next Ambush or Garrote within 7 seconds skip the Stealth requirement.",
        body = [=[
#showtooltip
/startattack
/castsequence reset=7 Ghostly Strike, Ambush]=],
    },
})
