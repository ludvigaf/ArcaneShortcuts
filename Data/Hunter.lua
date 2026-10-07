local _, AS = ...

AS:AddMacros("HUNTER", "General", {
    {
        name = "Pet Attack",
        desc = "Hunter's Mark plus pet attack in one button.",
        body = [=[
#showtooltip Hunter's Mark
/petattack
/cast Hunter's Mark]=],
    },
    {
        name = "Pet Recall",
        optional = { "Dash", "Dive" },
        desc = "From Wowhead: sets your pet to passive, calls it back and uses Dash.",
        src = "Retail",
        body = [=[
/petpassive
/petfollow
/cast Dash
/cast Dive]=],
    },
    {
        name = "Pet Life",
        desc = "Revives a dead pet, calls a missing pet, or heals the active one.",
        body = [=[
#showtooltip
/cast [@pet,dead] Revive Pet; [nopet] Call Pet; Mend Pet]=],
    },
    {
        name = "Feign Death",
        desc = "Stops attacking, calls your pet back and feigns death. Drops combat cleanly.",
        body = [=[
#showtooltip Feign Death
/stopattack
/petfollow
/cast Feign Death]=],
    },
    {
        name = "Aspects",
        desc = "Aspect of the Hawk in combat and Cheetah out of combat. Shift for Pack.",
        body = [=[
#showtooltip
/cast [mod:shift] Aspect of the Pack; [combat] Aspect of the Hawk; Aspect of the Cheetah]=],
    },
    {
        name = "Misdirection",
        desc = "From Wowhead: Misdirection on your focus, mouseover friend, or your pet.",
        src = "Retail",
        body = [=[
#showtooltip Misdirection
/cast [@focus,help,nodead][@mouseover,help,nodead][@pet,exists,nodead] Misdirection]=],
    },
    {
        name = "Tranq MO",
        desc = "From Wowhead: Tranquilizing Shot on your mouseover or target.",
        src = "Retail",
        body = [=[
#showtooltip Tranquilizing Shot
/cast [@mouseover,harm,nodead][] Tranquilizing Shot]=],
    },
    {
        name = "Flare",
        desc = "From Wowhead: Flare at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Flare
/cast [@cursor] Flare]=],
    },
    {
        name = "Melee/Ranged",
        desc = "Raptor Strike and Mongoose Bite in melee range, Auto Shot at range.",
        body = [=[
#showtooltip
/startattack
/cast Mongoose Bite
/cast Raptor Strike]=],
    },
    {
        name = "Scatter Focus",
        desc = "Scatter Shot on your focus or mouseover. A classic peel tool.",
        body = [=[
#showtooltip Scatter Shot
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Scatter Shot]=],
    },
    {
        name = "Pet Taunt",
        desc = "From Wowhead's pet control macros: your pet growls at your mouseover or focus.",
        src = "Retail",
        body = [=[
#showtooltip Growl
/cast [@mouseover,harm,nodead][@focus,harm,nodead][] Growl]=],
    },
})

AS:AddMacros("HUNTER", "Beast Mastery", {
    {
        name = "BM Burst",
        desc = "Bestial Wrath, Rapid Fire, racials and trinkets on one button.",
        body = [=[
#showtooltip Bestial Wrath
/petattack
/cast Bestial Wrath
/cast Rapid Fire
/cast Blood Fury
/cast Berserking
/use 13
/use 14]=],
    },
    {
        name = "Kill Command",
        desc = "From Wowhead: sends your pet in and uses Kill Command.",
        src = "Retail",
        body = [=[
#showtooltip Kill Command
/petattack
/cast Kill Command]=],
    },
    {
        name = "Pet Basics",
        optional = { "Claw", "Bite" },
        desc = "From Wowhead's basic attack macros: your pet uses Claw or Bite on its target. Bind it next to your shots.",
        src = "Retail",
        body = [=[
/cast [@pettarget] Claw
/cast [@pettarget] Bite]=],
    },
    {
        name = "Intimidation",
        desc = "Sends your pet in and stuns with Intimidation.",
        src = "Retail",
        body = [=[
#showtooltip Intimidation
/petattack
/cast Intimidation]=],
    },
    {
        name = "Steady Pet",
        optional = { "Claw", "Bite" },
        desc = "Adapted from Wowhead's Cobra Shot macro: Steady Shot that also keeps your pet's basic attack rolling.",
        src = "Retail",
        body = [=[
#showtooltip Steady Shot
/cast Steady Shot
/cast [@pettarget] Claw
/cast [@pettarget] Bite]=],
    },
})

AS:AddMacros("HUNTER", "Marksmanship", {
    {
        name = "MM Burst",
        desc = "Adapted from Wowhead's Trueshot macro: Rapid Fire, Trueshot Aura, racials and trinkets.",
        src = "Retail",
        body = [=[
#showtooltip Rapid Fire
/cast Rapid Fire
/cast !Trueshot Aura
/cast Blood Fury
/cast Berserking
/use 13
/use 14]=],
    },
    {
        name = "Aimed Shot",
        desc = "Aimed Shot that sends your pet in and keeps Auto Shot running.",
        body = [=[
#showtooltip Aimed Shot
/petattack
/cast !Auto Shot
/cast Aimed Shot]=],
    },
    {
        name = "Steady Shot",
        desc = "Steady Shot that starts Auto Shot if it is not already running.",
        body = [=[
#showtooltip Steady Shot
/cast !Auto Shot
/cast Steady Shot]=],
    },
    {
        name = "Multi-Shot MO",
        desc = "From Wowhead: Multi-Shot on your mouseover or target, and your pet assists.",
        src = "Retail",
        body = [=[
#showtooltip Multi-Shot
/cast [@mouseover,harm,nodead][] Multi-Shot
/petattack]=],
    },
    {
        name = "Volley",
        desc = "From Wowhead: Volley at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Volley
/cast [@cursor] Volley]=],
    },
    {
        name = "Arcane MO",
        desc = "From Wowhead: Arcane Shot on your mouseover or target.",
        src = "Retail",
        body = [=[
#showtooltip Arcane Shot
/petattack
/cast [@mouseover,harm,nodead][] Arcane Shot]=],
    },
})

AS:AddMacros("HUNTER", "Survival", {
    {
        name = "Deterrence",
        desc = "From Wowhead's Turtle macro: casts Deterrence, or cancels it when it is already active.",
        src = "Retail",
        body = [=[
#showtooltip Deterrence
/cancelaura Deterrence
/cast Deterrence]=],
    },
    {
        name = "Disengage",
        desc = "From Wowhead: stops casting, then disengages.",
        src = "Retail",
        body = [=[
#showtooltip Disengage
/stopcasting
/cast Disengage]=],
    },
    {
        name = "Raptor Strike",
        desc = "From Wowhead: starts auto-attack and uses Raptor Strike on a hostile target.",
        src = "Retail",
        body = [=[
#showtooltip Raptor Strike
/startattack
/cast [harm] Raptor Strike]=],
    },
    {
        name = "Wyvern Focus",
        desc = "Wyvern Sting on your focus or mouseover. Crowd control a second target.",
        body = [=[
#showtooltip Wyvern Sting
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Wyvern Sting]=],
    },
    {
        name = "Counter/Bite",
        desc = "Counterattack after a parry, otherwise Mongoose Bite or Raptor Strike.",
        body = [=[
#showtooltip
/startattack
/cast Counterattack
/cast Mongoose Bite
/cast Raptor Strike]=],
    },
    {
        name = "Freezing Trap",
        desc = "From Wowhead: Freezing Trap at your cursor if your client supports it, otherwise at your feet.",
        src = "Retail",
        body = [=[
#showtooltip Freezing Trap
/cast [@cursor] Freezing Trap]=],
    },
})
