local addonName, AS = ...
_G.ArcaneShortcuts = AS

AS.MAX_BODY = 255
AS.MAX_NAME = 16

-- Class order and the categories shown for each class. "General" holds the
-- class-wide macros; every class also gets the shared "All Classes" list.
AS.CLASS_ORDER = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
AS.CATEGORIES = {
    WARRIOR = { "General", "Arms", "Fury", "Protection" },
    PALADIN = { "General", "Holy", "Protection", "Retribution" },
    HUNTER  = { "General", "Beast Mastery", "Marksmanship", "Survival" },
    ROGUE   = { "General", "Assassination", "Combat", "Subtlety" },
    PRIEST  = { "General", "Discipline", "Holy", "Shadow" },
    SHAMAN  = { "General", "Elemental", "Enhancement", "Restoration" },
    MAGE    = { "General", "Arcane", "Fire", "Frost" },
    WARLOCK = { "General", "Affliction", "Demonology", "Destruction" },
    DRUID   = { "General", "Balance", "Feral (Cat)", "Feral (Bear)", "Restoration" },
}
AS.SHARED = "ALL"
AS.SHARED_CATEGORY = "All Classes"

AS.SOURCES = {
    Classic = { label = "Classic", color = "ffd100" },
    Retail  = { label = "Wowhead (adapted)", color = "66bbff" },
}

AS.macros = {}

-- Data files call this: AS:AddMacros("WARRIOR", "Arms", { {name=, desc=, src=, body=}, ... })
function AS:AddMacros(class, category, list)
    self.macros[class] = self.macros[class] or {}
    local bucket = self.macros[class][category] or {}
    self.macros[class][category] = bucket
    for _, m in ipairs(list) do
        m.class, m.category = class, category
        m.body = (m.body or ""):gsub("^%s+", ""):gsub("%s+$", "")
        m.src = m.src or "Classic"
        bucket[#bucket + 1] = m
    end
end

function AS:GetMacros(class, category)
    return self.macros[class] and self.macros[class][category] or {}
end

---------------------------------------------------------------------------
-- API shims (Forever runs a modern Classic client, but stay defensive)
---------------------------------------------------------------------------
local function SpellName(name)
    if C_Spell and C_Spell.GetSpellInfo then
        local info = C_Spell.GetSpellInfo(name)
        return info and info.name
    end
    return GetSpellInfo and (GetSpellInfo(name))
end

local function ItemCount(name)
    if C_Item and C_Item.GetItemCount then return C_Item.GetItemCount(name) or 0 end
    return GetItemCount and GetItemCount(name) or 0
end

local function PetKnows(name)
    if not HasPetSpells or not HasPetSpells() then return false end
    local n = HasPetSpells()
    for i = 1, n or 0 do
        local spell = GetSpellBookItemName and GetSpellBookItemName(i, BOOKTYPE_PET or "pet")
        if spell and spell:lower() == name:lower() then return true end
    end
    return false
end

---------------------------------------------------------------------------
-- Macro analysis: find the spells/items a body references and whether the
-- player has them, plus any <placeholders> still left to fill in.
---------------------------------------------------------------------------
local CAST_CMDS = { cast = "spell", castsequence = "spell", castrandom = "spell", use = "use", userandom = "use" }

-- Racials sit in cooldown macros for whoever has them; a missing one is
-- expected, not a reason to flag the macro.
local OPTIONAL = { ["blood fury"] = true, ["berserking"] = true, ["ancestral call"] = true }

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function addRefs(text, kind, out)
    text = text:gsub("%[[^%]]*%]", ";")              -- drop [conditionals]
    for clause in text:gmatch("[^;]+") do
        local spells = clause:gsub("reset=%S+", "")
        for raw in spells:gmatch("[^,]+") do
            local ref = trim(raw):gsub("^!", ""):gsub("%(Rank %d+%)$", ""):gsub("%(%)$", "")
            ref = trim(ref)
            if ref ~= "" and not ref:find("^%d+$") and not ref:find("^item:") and not ref:find("[<>]") then
                out[#out + 1] = { name = ref, kind = kind }
            end
        end
    end
end

-- optional: extra spell names (from the macro's data entry) that may be missing,
-- e.g. pet abilities only some pets have.
function AS:Analyze(body, optional)
    local refs, missing, placeholders = {}, {}, {}
    local skip = {}
    for _, name in ipairs(optional or {}) do skip[name:lower()] = true end
    for ph in body:gmatch("<[^<>\n]+>") do placeholders[#placeholders + 1] = ph end
    for line in body:gmatch("[^\n]+") do
        local cmd, rest = line:match("^%s*/(%a+)%s*(.*)$")
        if cmd and CAST_CMDS[cmd:lower()] then
            addRefs(rest, CAST_CMDS[cmd:lower()], refs)
        end
    end
    local seen = {}
    for _, r in ipairs(refs) do
        local key = r.name:lower()
        if not seen[key] and not OPTIONAL[key] and not skip[key] then
            seen[key] = true
            local ok = SpellName(r.name) ~= nil or PetKnows(r.name)
            if not ok and r.kind == "use" then ok = ItemCount(r.name) > 0 end
            if not ok then missing[#missing + 1] = r.name end
        end
    end
    local status = (#placeholders > 0 and "edit") or (#missing > 0 and "partial") or "ok"
    return status, missing, placeholders
end

---------------------------------------------------------------------------
-- Tooltips and icons
---------------------------------------------------------------------------
local function FirstCastSpell(body)
    for line in body:gmatch("[^\n]+") do
        local cmd, rest = line:match("^%s*/(%a+)%s*(.*)$")
        if cmd and CAST_CMDS[cmd:lower()] == "spell" then
            local refs = {}
            addRefs(rest, "spell", refs)
            if refs[1] then return refs[1].name end
        end
    end
end

-- A bare #showtooltip shows whatever the first usable line does. In a
-- stance + gear macro that is the weapon once you're already in the stance,
-- so name the spell explicitly whenever the macro also equips items.
function AS:ResolveTooltip(body)
    if not body:find("\n%s*/equip") and not body:find("^%s*/equip") then return body end
    local spell = FirstCastSpell(body)
    if not spell then return body end
    local out, n = body:gsub("^(%s*#show%a*)%s*\n", "%1 " .. spell .. "\n", 1)
    if n == 0 then out = body:gsub("\n(%s*#show%a*)%s*\n", "\n%1 " .. spell .. "\n", 1) end
    return out
end

local QUESTION_MARK = 134400   -- the macro UI's "dynamic icon" choice
AS.DYNAMIC_ICON = QUESTION_MARK

local function SpellIcon(name)
    if C_Spell and C_Spell.GetSpellTexture then return C_Spell.GetSpellTexture(name) end
    return GetSpellTexture and GetSpellTexture(name)
end

local function ItemIcon(name)
    if C_Item and C_Item.GetItemIconByID then
        local ok, icon = pcall(C_Item.GetItemIconByID, name)
        if ok and icon then return icon end
    end
    return GetItemInfo and select(10, GetItemInfo(name))
end

-- Every icon the macro could use: the dynamic question mark first, then the
-- icon of each spell or item it references that the game can resolve.
function AS:IconCandidates(body)
    local list, seen = { { icon = QUESTION_MARK, label = "Dynamic (follows #showtooltip)" } }, { [QUESTION_MARK] = true }
    local function add(icon, label)
        if icon and not seen[icon] then
            seen[icon] = true
            list[#list + 1] = { icon = icon, label = label }
        end
    end
    local shown = body:match("^%s*#show%a*[ \t]+([^\n]+)") or body:match("\n%s*#show%a*[ \t]+([^\n]+)")
    if shown then
        local refs = {}
        addRefs(shown, "use", refs)
        for _, r in ipairs(refs) do add(SpellIcon(r.name) or ItemIcon(r.name), r.name) end
    end
    for line in body:gmatch("[^\n]+") do
        local cmd, rest = line:match("^%s*/(%a+)%s*(.*)$")
        if cmd and CAST_CMDS[cmd:lower()] then
            local refs = {}
            addRefs(rest, CAST_CMDS[cmd:lower()], refs)
            for _, r in ipairs(refs) do
                add(SpellIcon(r.name) or (r.kind == "use" and ItemIcon(r.name)), r.name)
            end
        end
    end
    return list
end

-- Default icon choice: a macro that names its tooltip spell gets that spell's
-- icon; a bare #showtooltip stays dynamic so the button keeps changing with
-- its conditionals; a macro without #showtooltip gets its first spell's icon.
function AS:DefaultIconIndex(body, candidates)
    body = self:ResolveTooltip(body)
    local hasShow = body:find("^%s*#show") or body:find("\n%s*#show")
    local named = body:match("^%s*#show%a*[ \t]+%S") or body:match("\n%s*#show%a*[ \t]+%S")
    if hasShow and not named then return 1 end
    return candidates[2] and 2 or 1
end

---------------------------------------------------------------------------
-- Creating macros
---------------------------------------------------------------------------
local function Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cff8f6cffArcane Shortcuts:|r " .. msg)
end
AS.Print = Print

-- Returns the macro index on success, or nil plus an error message.
function AS:CreateOrUpdate(name, body, perCharacter, icon)
    if InCombatLockdown() then return nil, "Macros can't be created in combat." end
    name = trim(name or "")
    if name == "" then return nil, "The macro needs a name." end
    if #name > self.MAX_NAME then name = name:sub(1, self.MAX_NAME) end
    if #body > self.MAX_BODY then return nil, ("The macro is %d characters; the limit is %d."):format(#body, self.MAX_BODY) end
    if body:find("<[^<>\n]+>") then return nil, "Replace the <placeholders> in the macro text first." end
    body = self:ResolveTooltip(body)
    if #body > self.MAX_BODY then return nil, ("The macro is %d characters; the limit is %d."):format(#body, self.MAX_BODY) end

    icon = icon or QUESTION_MARK
    local existing = GetMacroIndexByName(name)
    if existing and existing > 0 then
        local index = EditMacro(existing, name, icon, body)
        return index or existing, nil, true
    end

    local numAccount, numChar = GetNumMacros()
    if perCharacter then
        if numChar >= (MAX_CHARACTER_MACROS or 18) then return nil, "Your character macro slots are full." end
    elseif numAccount >= (MAX_ACCOUNT_MACROS or 120) then
        return nil, "Your account-wide macro slots are full."
    end
    local index = CreateMacro(name, icon, body, perCharacter and true or nil)
    if not index then return nil, "The game refused to create the macro." end
    return index
end

---------------------------------------------------------------------------
-- Saved variables, slash commands
---------------------------------------------------------------------------
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, _, name)
    if name ~= addonName then return end
    self:UnregisterEvent("ADDON_LOADED")
    ArcaneShortcutsDB = ArcaneShortcutsDB or {}
    AS.db = ArcaneShortcutsDB
    if AS.db.minimapAngle == nil then AS.db.minimapAngle = 200 end
    if AS.OnLoad then AS:OnLoad() end
end)

SLASH_ARCANESHORTCUTS1 = "/as"
SLASH_ARCANESHORTCUTS2 = "/arcaneshortcuts"
SlashCmdList.ARCANESHORTCUTS = function(msg)
    msg = trim((msg or ""):lower())
    if msg == "minimap" then
        AS.db.hideMinimap = not AS.db.hideMinimap
        if AS.UpdateMinimapButton then AS:UpdateMinimapButton() end
        Print("Minimap button " .. (AS.db.hideMinimap and "hidden." or "shown."))
        return
    end
    AS:Toggle()
end
