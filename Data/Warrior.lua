local _, AS = ...

AS:AddMacros("WARRIOR", "General", {
    {
        name = "Charge/Intercept",
        desc = "One button gap closer. Out of combat it moves to Battle Stance and charges. In combat it moves to Berserker Stance and intercepts.",
        body = [=[
#showtooltip
/cast [nocombat,stance:1] Charge; [combat,stance:3] Intercept; [nocombat] Battle Stance; Berserker Stance]=],
    },
    {
        name = "Charge+VR",
        desc = "Wowhead's key saver: Charge, plus Victory Rush whenever it is available.",
        src = "Retail",
        body = [=[
#showtooltip
/cast Charge
/cast Victory Rush]=],
    },
    {
        name = "Interrupt",
        desc = "Uses Shield Bash when you wear a shield in Battle or Defensive Stance. Otherwise it moves to Berserker Stance for Pummel.",
        body = [=[
#showtooltip
/cast [equipped:Shields,nostance:3] Shield Bash; [nostance:3] Berserker Stance; Pummel]=],
    },
    {
        name = "Pummel Focus",
        desc = "Pummels your focus target, or your current target if you have no hostile focus.",
        src = "Retail",
        body = [=[
#showtooltip Pummel
/cast [@focus,harm,nodead][] Pummel]=],
    },
    {
        name = "Execute MO",
        desc = "Executes your mouseover target, or your current target.",
        src = "Retail",
        body = [=[
#showtooltip Execute
/cast [@mouseover,harm,nodead][] Execute]=],
    },
    {
        name = "Stances",
        desc = "Wowhead's one-button stance swap: Battle Stance, or Defensive Stance with Shift, or Berserker Stance with Ctrl.",
        src = "Retail",
        body = [=[
#showtooltip
/cast [mod:shift] !Defensive Stance; [mod:ctrl] !Berserker Stance; !Battle Stance]=],
    },
    {
        name = "Berserker Rage",
        desc = "Switches to Berserker Stance if needed, then uses Berserker Rage to break or prevent fear.",
        body = [=[
#showtooltip Berserker Rage
/cast [nostance:3] Berserker Stance; Berserker Rage]=],
    },
    {
        name = "Off Mode",
        desc = "Moves to Battle Stance and equips your two-hander.",
        body = [=[
#showtooltip Battle Stance
/cast [nostance:1] Battle Stance
/equip <Two-Hand Weapon>]=],
    },
    {
        name = "Def Mode",
        desc = "Moves to Defensive Stance and equips your one-hander and shield.",
        body = [=[
#showtooltip Defensive Stance
/cast [nostance:2] Defensive Stance
/equipslot 16 <One-Hand Weapon>
/equipslot 17 <Shield>]=],
    },
    {
        name = "Hamstring",
        desc = "Hamstrings your mouseover or target, and starts auto-attack.",
        body = [=[
#showtooltip Hamstring
/startattack
/cast [@mouseover,harm,nodead][] Hamstring]=],
    },
})

AS:AddMacros("WARRIOR", "Arms", {
    {
        name = "Overpower",
        desc = "Switches to Battle Stance and uses Overpower. Press it twice when you are in another stance.",
        body = [=[
#showtooltip Overpower
/cast [nostance:1] Battle Stance; Overpower]=],
    },
    {
        name = "MS + HS",
        desc = "Mortal Strike, and queues Heroic Strike as a rage dump. Use it only when you have spare rage.",
        body = [=[
#showtooltip Mortal Strike
/startattack
/cast Heroic Strike
/cast Mortal Strike]=],
    },
    {
        name = "Arms Burst",
        desc = "Adapted from Wowhead's Colossus Smash cooldown macro: trinkets, racials and Sweeping Strikes, then Mortal Strike.",
        src = "Retail",
        body = [=[
#showtooltip Mortal Strike
/use 13
/use 14
/cast Blood Fury
/cast Berserking
/cast Sweeping Strikes
/cast Mortal Strike]=],
    },
    {
        name = "TC / WW",
        desc = "Adapted from Wowhead: Whirlwind in Berserker Stance, Thunder Clap otherwise.",
        src = "Retail",
        body = [=[
#showtooltip
/cast [stance:3] Whirlwind; Thunder Clap]=],
    },
})

AS:AddMacros("WARRIOR", "Fury", {
    {
        name = "Fury Burst",
        desc = "Adapted from Wowhead's Recklessness macro: Death Wish, Recklessness, racials and both trinkets.",
        src = "Retail",
        body = [=[
#showtooltip Recklessness
/cast Death Wish
/cast Recklessness
/cast Blood Fury
/cast Berserking
/use 13
/use 14]=],
    },
    {
        name = "BT + HS",
        desc = "Bloodthirst, and queues Heroic Strike as a rage dump for high-rage moments.",
        body = [=[
#showtooltip Bloodthirst
/startattack
/cast Heroic Strike
/cast Bloodthirst]=],
    },
    {
        name = "Whirlwind",
        desc = "Switches to Berserker Stance if needed and uses Whirlwind.",
        body = [=[
#showtooltip Whirlwind
/cast [nostance:3] Berserker Stance; Whirlwind]=],
    },
    {
        name = "Cleave + BT",
        desc = "Queues Cleave and uses Bloodthirst. Good for sustained AoE.",
        body = [=[
#showtooltip Cleave
/startattack
/cast Cleave
/cast Bloodthirst]=],
    },
})

AS:AddMacros("WARRIOR", "Protection", {
    {
        name = "Taunt MO",
        desc = "Switches to Defensive Stance if needed, then taunts your mouseover or target.",
        body = [=[
#showtooltip Taunt
/cast [nostance:2] Defensive Stance; [@mouseover,harm,nodead][] Taunt]=],
    },
    {
        name = "Sunder",
        desc = "Starts auto-attack and sunders. Spam it for threat.",
        body = [=[
#showtooltip Sunder Armor
/startattack
/cast Sunder Armor]=],
    },
    {
        name = "Revenge/Sunder",
        desc = "Uses Revenge when it is available, otherwise Sunder Armor.",
        body = [=[
#showtooltip
/startattack
/cast Revenge
/cast Sunder Armor]=],
    },
    {
        name = "Prot Opener",
        desc = "Adapted from Wowhead's protection opener: trinket, Bloodrage, then Shield Block.",
        src = "Retail",
        body = [=[
#showtooltip Shield Block
/use 13
/cast Bloodrage
/cast Shield Block]=],
    },
    {
        name = "Oh No!",
        desc = "Emergency button: Last Stand, then Shield Wall in Defensive Stance.",
        body = [=[
#showtooltip Last Stand
/cast Last Stand
/cast [stance:2] Shield Wall]=],
    },
    {
        name = "Mocking Blow",
        desc = "Switches to Battle Stance and uses Mocking Blow when a mob escapes your taunt.",
        body = [=[
#showtooltip Mocking Blow
/cast [nostance:1] Battle Stance; Mocking Blow]=],
    },
    {
        name = "Shield Slam",
        desc = "Shield Slam that also queues Heroic Strike when you have rage to spare.",
        body = [=[
#showtooltip Shield Slam
/startattack
/cast Heroic Strike
/cast Shield Slam]=],
    },
})
