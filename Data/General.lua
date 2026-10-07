local _, AS = ...

-- Shown for every class under "All Classes".
-- Text in <angle brackets> is a placeholder: replace it before creating the
-- macro (shift-click an item or spell while the macro text box has focus).
AS:AddMacros(AS.SHARED, AS.SHARED_CATEGORY, {
    {
        name = "Trinkets",
        desc = "Uses both trinket slots at once. Add it to any cooldown macro or press it on its own.",
        src = "Retail",
        body = [=[
#showtooltip
/use 13
/use 14]=],
    },
    {
        name = "2H to 1H+Shield",
        desc = "Toggles between a two-hander and a one-hander plus shield. Works for warriors, paladins and shamans. Fill in your item names.",
        body = [=[
#showtooltip
/equip [equipped:Shields] <Two-Hand Weapon>
/equipslot [noequipped:Shields] 16 <One-Hand Weapon>
/equipslot [noequipped:Shields] 17 <Shield>]=],
    },
    {
        name = "Mount",
        desc = "Mounts up, or dismounts if you are already mounted.",
        body = [=[
#showtooltip
/dismount [mounted]
/stopmacro [mounted]
/use <Mount Name>]=],
    },
    {
        name = "Heal Potion",
        desc = "First press uses your healthstone and the next press your healing potion. The sequence resets when you leave combat. Fill in the exact item names you carry.",
        body = [=[
#showtooltip
/castsequence reset=combat <Healthstone>, <Healing Potion>]=],
    },
    {
        name = "Bandage Self",
        desc = "Bandages yourself without changing your target.",
        body = [=[
#showtooltip
/use [@player] <Bandage>]=],
    },
    {
        name = "Eat & Drink",
        desc = "Eats and drinks with a single press out of combat.",
        body = [=[
#showtooltip
/use [nocombat] <Food>
/use [nocombat] <Drink>]=],
    },
    {
        name = "Focus",
        desc = "Sets your mouseover (or current target) as focus. Shift-click to clear focus.",
        src = "Retail",
        body = [=[
/clearfocus [mod:shift]
/stopmacro [mod:shift]
/focus [@mouseover,exists,nodead][]]=],
    },
    {
        name = "Skull Target",
        desc = "Puts a skull raid marker on your mouseover or target.",
        src = "Retail",
        body = [=[
/run SetRaidTarget(UnitExists("mouseover") and "mouseover" or "target", 8)]=],
    },
    {
        name = "Attack Nearest",
        desc = "Targets the nearest enemy if you have no hostile target, then starts auto-attack.",
        body = [=[
/targetenemy [noharm][dead]
/startattack]=],
    },
    {
        name = "Assist Mouseover",
        desc = "Targets whatever your mouseover (or your target) is attacking.",
        body = [=[
/assist [@mouseover,help,nodead][]]=],
    },
    {
        name = "Sell Greys",
        desc = "Sells every grey (poor quality) item in your bags. Open a vendor first.",
        body = [=[
/run local C=C_Container for b=0,4 do for s=1,C.GetContainerNumSlots(b) do local l=C.GetContainerItemLink(b,s) if l and select(3,GetItemInfo(l))==0 then C.UseContainerItem(b,s) end end end]=],
    },
    {
        name = "Reload UI",
        desc = "Reloads the interface.",
        body = [=[
/reload]=],
    },
})
