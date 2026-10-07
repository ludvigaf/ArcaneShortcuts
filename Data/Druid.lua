local _, AS = ...

AS:AddMacros("DRUID", "General", {
    {
        name = "Travel",
        desc = "One-button travel form: Aquatic Form in water, Travel Form outdoors, Cat Form indoors. It never shifts you back out by accident.",
        body = [=[
#showtooltip
/dismount [mounted]
/cast [swimming] !Aquatic Form; [outdoors] !Travel Form; !Cat Form]=],
    },
    {
        name = "Travel+Flight",
        desc = "Travel macro for zones where you can fly: Flight Form if flyable, otherwise Aquatic, Travel or Cat Form.",
        body = [=[
#showtooltip
/cast [swimming] !Aquatic Form; [flyable,outdoors,nocombat] !Flight Form; [outdoors] !Travel Form; !Cat Form]=],
    },
    {
        name = "Innervate",
        desc = "From Wowhead: Innervate on your mouseover healer, your target, or yourself.",
        src = "Retail",
        body = [=[
#showtooltip Innervate
/cast [@mouseover,help,nodead][help,nodead][@player] Innervate]=],
    },
    {
        name = "Regrowth Out",
        desc = "From Wowhead's feral Regrowth macro: leaves your form and casts Regrowth on your mouseover or yourself.",
        src = "Retail",
        body = [=[
#showtooltip Regrowth
/cancelform [form]
/cast [@mouseover,help,nodead][@player] Regrowth]=],
    },
    {
        name = "Bear Escape",
        desc = "From Wowhead: stops casting and shifts into bear for an emergency.",
        src = "Retail",
        body = [=[
#showtooltip
/stopcasting
/cast !Dire Bear Form]=],
    },
    {
        name = "Rebirth MO",
        desc = "Rebirth on your mouseover, or your target.",
        body = [=[
#showtooltip Rebirth
/cast [@mouseover,help,dead][help,dead] Rebirth]=],
    },
    {
        name = "Decurse MO",
        desc = "Remove Curse on your mouseover or target. Shift for Abolish Poison.",
        body = [=[
#showtooltip
/cast [mod:shift,@mouseover,help,nodead][mod:shift] Abolish Poison; [@mouseover,help,nodead][] Remove Curse]=],
    },
    {
        name = "Roots MO",
        desc = "Entangling Roots on your mouseover or focus.",
        body = [=[
#showtooltip Entangling Roots
/cast [@mouseover,harm,nodead][@focus,harm,nodead][] Entangling Roots]=],
    },
    {
        name = "Hibernate",
        desc = "Hibernate your focus or mouseover.",
        body = [=[
#showtooltip Hibernate
/cast [@focus,harm,nodead][@mouseover,harm,nodead][] Hibernate]=],
    },
    {
        name = "Mark",
        desc = "Mark of the Wild on your mouseover or target. Shift for Gift of the Wild.",
        body = [=[
#showtooltip
/cast [mod:shift] Gift of the Wild; [@mouseover,help,nodead][] Mark of the Wild]=],
    },
})

AS:AddMacros("DRUID", "Balance", {
    {
        name = "Moonkin",
        desc = "Enters Moonkin Form and never cancels it when pressed twice.",
        body = [=[
#showtooltip Moonkin Form
/cast !Moonkin Form]=],
    },
    {
        name = "Moonfire MO",
        desc = "Moonfire on your mouseover or target.",
        body = [=[
#showtooltip Moonfire
/cast [@mouseover,harm,nodead][] Moonfire]=],
    },
    {
        name = "Swarm MO",
        desc = "Insect Swarm on your mouseover or target.",
        body = [=[
#showtooltip Insect Swarm
/cast [@mouseover,harm,nodead][] Insect Swarm]=],
    },
    {
        name = "Hurricane",
        desc = "Adapted from Wowhead's cursor macros: Hurricane at your cursor.",
        src = "Retail",
        body = [=[
#showtooltip Hurricane
/cast [@cursor] Hurricane]=],
    },
    {
        name = "Boomy Burst",
        desc = "Adapted from Wowhead's Celestial Alignment macro: trinkets and racial, then Starfire.",
        src = "Retail",
        body = [=[
#showtooltip Starfire
/use 13
/use 14
/cast Berserking
/cast Starfire]=],
    },
    {
        name = "Treants",
        desc = "Adapted from Wowhead: Force of Nature with trinkets.",
        src = "Retail",
        body = [=[
#showtooltip Force of Nature
/use 13
/cast Force of Nature]=],
    },
})

AS:AddMacros("DRUID", "Feral (Cat)", {
    {
        name = "Prowl",
        desc = "Enters Cat Form and Prowl in one button, and never cancels Prowl.",
        body = [=[
#showtooltip Prowl
/cast [noform:3] !Cat Form; !Prowl]=],
    },
    {
        name = "Ravage/Shred",
        desc = "Ravage from stealth, Shred otherwise. Shift for Pounce from stealth.",
        body = [=[
#showtooltip
/startattack [nostealth]
/cast [stealth,mod:shift] Pounce; [stealth] Ravage; Shred]=],
    },
    {
        name = "Claw",
        desc = "Claw that also starts auto-attack. Use it when you can't get behind the target.",
        body = [=[
#showtooltip Claw
/startattack
/cast Claw]=],
    },
    {
        name = "Powershift",
        desc = "Leaves your form and goes straight back into Cat Form, for a fresh energy refill with Furor or Wolfshead Helm.",
        body = [=[
#showtooltip Cat Form
/cancelform [form]
/cast Cat Form]=],
    },
    {
        name = "Cat Burst",
        desc = "Adapted from Wowhead's Berserk/Tiger's Fury opener: Tiger's Fury, racial and trinkets.",
        src = "Retail",
        body = [=[
#showtooltip Tiger's Fury
/cast Tiger's Fury
/cast Berserking
/use 13
/use 14]=],
    },
    {
        name = "Faerie Fire",
        desc = "Faerie Fire (Feral) on your mouseover or target, castable in form.",
        body = [=[
#showtooltip Faerie Fire (Feral)
/cast [@mouseover,harm,nodead][] Faerie Fire (Feral)]=],
    },
})

AS:AddMacros("DRUID", "Feral (Bear)", {
    {
        name = "Bear Form",
        desc = "Enters Dire Bear Form from any form, and never shifts you out.",
        body = [=[
#showtooltip Dire Bear Form
/cast !Dire Bear Form]=],
    },
    {
        name = "Maul",
        desc = "Queues Maul and starts auto-attack. Spam it as your rage dump.",
        body = [=[
#showtooltip Maul
/startattack
/cast Maul]=],
    },
    {
        name = "Growl MO",
        desc = "Growl on your mouseover or target.",
        body = [=[
#showtooltip Growl
/cast [@mouseover,harm,nodead][] Growl]=],
    },
    {
        name = "Bash Focus",
        desc = "Bash your focus or target to interrupt a cast.",
        body = [=[
#showtooltip Bash
/cast [@focus,harm,nodead][] Bash]=],
    },
    {
        name = "Bear Opener",
        desc = "Adapted from Wowhead's guardian opener: trinket, Enrage, then Feral Charge.",
        src = "Retail",
        body = [=[
#showtooltip Feral Charge
/use 13
/cast Enrage
/cast Feral Charge]=],
    },
    {
        name = "Bear Panic",
        desc = "Frenzied Regeneration with your trinket. Use it as an emergency defensive.",
        body = [=[
#showtooltip Frenzied Regeneration
/use 13
/cast Frenzied Regeneration]=],
    },
    {
        name = "Swipe+Maul",
        desc = "Swipe for AoE threat, and queues Maul on your next swing.",
        body = [=[
#showtooltip Swipe
/startattack
/cast Maul
/cast Swipe]=],
    },
})

AS:AddMacros("DRUID", "Restoration", {
    {
        name = "Rejuv MO",
        desc = "From Wowhead: Rejuvenation on your mouseover, or your target.",
        src = "Retail",
        body = [=[
#showtooltip Rejuvenation
/cast [@mouseover,help,nodead][] Rejuvenation]=],
    },
    {
        name = "Lifebloom MO",
        desc = "Lifebloom on your mouseover, or your target.",
        body = [=[
#showtooltip Lifebloom
/cast [@mouseover,help,nodead][] Lifebloom]=],
    },
    {
        name = "Regrowth MO",
        desc = "Regrowth on your mouseover, or your target.",
        body = [=[
#showtooltip Regrowth
/cast [@mouseover,help,nodead][] Regrowth]=],
    },
    {
        name = "HT MO",
        desc = "Healing Touch on your mouseover, or your target.",
        body = [=[
#showtooltip Healing Touch
/cast [@mouseover,help,nodead][] Healing Touch]=],
    },
    {
        name = "Swiftmend MO",
        desc = "Swiftmend on your mouseover, or your target.",
        body = [=[
#showtooltip Swiftmend
/cast [@mouseover,help,nodead][] Swiftmend]=],
    },
    {
        name = "NS Touch",
        desc = "Adapted from Wowhead's Nature's Swiftness/Convoke combo: Nature's Swiftness, then an instant Healing Touch.",
        src = "Retail",
        body = [=[
#showtooltip Nature's Swiftness
/cast Nature's Swiftness
/cast [@mouseover,help,nodead][] Healing Touch]=],
    },
    {
        name = "Self Innervate",
        desc = "From Wowhead: Innervate on yourself.",
        src = "Retail",
        body = [=[
#showtooltip Innervate
/cast [@player] Innervate]=],
    },
    {
        name = "Tree",
        desc = "Enters Tree of Life form without ever cancelling it.",
        body = [=[
#showtooltip Tree of Life
/cast !Tree of Life]=],
    },
})
