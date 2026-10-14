local _, AS = ...

local FRAME_W, FRAME_H = 880, 540
local ROW_H = 40
local CLASS_ICONS = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"
local STATUS_TEXT = {
    ok      = "|cff40ff40Ready|r: you know every spell in this macro.",
    partial = "|cffffcc00Partly available|r: not in your spellbook or bags yet:",
    edit    = "|cffff6060Needs editing|r: replace these placeholders:",
}
local STATUS_DOT = { ok = { 0.25, 1, 0.25 }, partial = { 1, 0.8, 0 }, edit = { 1, 0.35, 0.35 } }

local frame, state = nil, { class = nil, category = nil, macro = nil }
local UpdateList, UpdateCategoryCounts

local function ClassColor(class)
    local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
    return c and c.colorStr or "ffffffff"
end

local function LocalizedClass(class)
    return (LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[class]) or class:sub(1, 1) .. class:sub(2):lower()
end

-- Pseudo-class for the "My Macros" overview of the player's own macros.
local OWN = "OWN"
local OWN_LIMIT = { Account = MAX_ACCOUNT_MACROS or 120, Character = MAX_CHARACTER_MACROS or 18 }

local function MacrosFor(cat)
    if cat.class == OWN then return AS:GetOwnMacros(cat.name == "Character") end
    return AS:GetMacros(cat.class, cat.name)
end

-- Own macros are rebuilt on every refresh, so compare them by slot.
local function SameMacro(a, b)
    if a == b then return true end
    return a and b and a.own and b.own and a.own.perCharacter == b.own.perCharacter and a.own.index == b.own.index or false
end

local function CategoriesFor(class)
    if class == OWN then
        return { { class = OWN, name = "Account" }, { class = OWN, name = "Character" } }
    end
    local list = {}
    for _, c in ipairs(AS.CATEGORIES[class]) do list[#list + 1] = { class = class, name = c } end
    list[#list + 1] = { class = AS.SHARED, name = AS.SHARED_CATEGORY }
    return list
end

local function CreatePanel(parent)
    local f = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 14,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    f:SetBackdropColor(0, 0, 0, 0.55)
    f:SetBackdropBorderColor(0.45, 0.45, 0.5, 1)
    return f
end

---------------------------------------------------------------------------
-- Detail panel
---------------------------------------------------------------------------
local function UpdateDetailStatus()
    local d = frame.detail
    local body = d.body:GetText() or ""
    local len = #body
    d.count:SetText(("%d / %d"):format(len, AS.MAX_BODY))
    d.count:SetTextColor(len > AS.MAX_BODY and 1 or 0.6, len > AS.MAX_BODY and 0.2 or 0.6, len > AS.MAX_BODY and 0.2 or 0.6)

    local status, missing, placeholders = AS:Analyze(body, state.macro and state.macro.optional)
    local text = STATUS_TEXT[status]
    if status == "partial" then
        text = text .. "\n|cffbbbbbb" .. table.concat(missing, ", ") .. "|r"
    elseif status == "edit" then
        text = text .. "\n|cffbbbbbb" .. table.concat(placeholders, ", ") .. "|r"
    end
    d.status:SetText(text)
    local blocked = status == "edit" or len > AS.MAX_BODY
    d.createChar:SetEnabled(not blocked)
    d.createAcct:SetEnabled(not blocked)
    d.save:SetEnabled(len <= AS.MAX_BODY)

    -- Keep a hand-picked icon while it still applies; otherwise use the default.
    local own = state.macro and state.macro.own
    local candidates = AS:IconCandidates(own and body or AS:ResolveTooltip(body))
    if own and own.icon then
        local found
        for _, c in ipairs(candidates) do if c.icon == own.icon then found = true end end
        if not found then table.insert(candidates, 2, { icon = own.icon, label = "Current icon" }) end
    end
    state.candidates = candidates
    local index
    if state.iconManual then
        for i, c in ipairs(candidates) do if c.icon == state.icon then index = i end end
    end
    if not index then
        state.iconManual = false
        index = AS:DefaultIconIndex(body, candidates)
    end
    state.iconIndex, state.icon = index, candidates[index].icon
    d.icon.tex:SetTexture(state.icon)
end

local function CycleIcon(step)
    local list = state.candidates
    if not list or #list < 2 then return end
    state.iconIndex = (state.iconIndex - 1 + step) % #list + 1
    state.icon, state.iconManual = list[state.iconIndex].icon, true
    frame.detail.icon.tex:SetTexture(state.icon)
end

-- What a row shows: the icon the macro will get, or for a dynamic macro the
-- first spell it casts, so the list isn't a wall of question marks.
local function PreviewIcon(body)
    local candidates = AS:IconCandidates(AS:ResolveTooltip(body))
    local index = AS:DefaultIconIndex(body, candidates)
    if index == 1 and candidates[2] then index = 2 end
    return candidates[index].icon
end

local function ShowMacro(m)
    state.macro = m
    local d = frame.detail
    if not m then d:Hide() return end
    d:Show()
    d.title:SetText(m.name)
    local own = m.own
    if own then
        local slot = own.index - (own.perCharacter and OWN_LIMIT.Account or 0)
        d.source:SetText(("|cffffd100%s macro|r  -  slot %d of %d"):format(m.category, slot, OWN_LIMIT[m.category]))
        d.desc:SetText(own.perCharacter and "Only this character has this macro. Drag it from the list onto an action bar."
            or "Every character on your account shares this macro. Drag it from the list onto an action bar.")
    else
        local src = AS.SOURCES[m.src] or AS.SOURCES.Classic
        d.source:SetText(("|cff%s%s|r  -  %s"):format(src.color, src.label, m.category))
        d.desc:SetText(m.desc or "")
    end
    d.createChar:SetShown(not own)
    d.createAcct:SetShown(not own)
    d.save:SetShown(own and true or false)
    d.delete:SetShown(own and true or false)
    d.nameBox:SetText(m.name)
    state.iconManual = own and true or false
    state.icon = own and own.icon
    d.body:SetText(m.body)
    d.body:SetCursorPosition(0)
    UpdateDetailStatus()
end

local function DoCreate(perCharacter)
    local d = frame.detail
    local index, err, updated = AS:CreateOrUpdate(d.nameBox:GetText(), d.body:GetText() or "", perCharacter, state.icon)
    if not index then
        AS.Print("|cffff6060" .. err .. "|r")
        return
    end
    local name = d.nameBox:GetText()
    AS.Print(("%s macro |cffffd100%s|r. It's on your cursor now: drop it on an action bar."):format(updated and "Updated" or "Created", name))
    ClearCursor()
    PickupMacro(index)
    if MacroFrame and MacroFrame:IsShown() and MacroFrame_Update then MacroFrame_Update() end
end

-- Own macros are addressed by slot, and slots shift when anything else edits
-- macros. Make sure the slot still holds the macro the panel was opened on.
local function OwnStillThere(own)
    if GetMacroInfo(own.index) == own.name then return true end
    AS.Print("|cffff6060That macro changed outside Arcane Shortcuts. Select it again.|r")
    UpdateList()
end

-- After a save or delete: refresh the list and select the macro in `index`,
-- or the first macro in the category if that slot is gone.
local function RefreshOwn(index)
    UpdateCategoryCounts()
    local macros = MacrosFor(state.category)
    local pick = macros[1]
    for _, m in ipairs(macros) do if m.own.index == index then pick = m end end
    ShowMacro(pick)
    UpdateList()
    if MacroFrame and MacroFrame:IsShown() and MacroFrame_Update then MacroFrame_Update() end
end

local function DoSave()
    local own = state.macro and state.macro.own
    if not own or not OwnStillThere(own) then return end
    local d = frame.detail
    local index, err = AS:SaveMacro(own.index, d.nameBox:GetText(), d.body:GetText() or "", state.icon)
    if not index then
        AS.Print("|cffff6060" .. err .. "|r")
        return
    end
    AS.Print(("Saved macro |cffffd100%s|r."):format(d.nameBox:GetText()))
    RefreshOwn(index)
end

StaticPopupDialogs.ARCANESHORTCUTS_DELETE = {
    text = "Delete the macro \"%s\"? This can't be undone.",
    button1 = YES or "Yes",
    button2 = NO or "No",
    OnAccept = function(_, own)
        if not OwnStillThere(own) then return end
        local ok, err = AS:RemoveMacro(own.index)
        if not ok then
            AS.Print("|cffff6060" .. err .. "|r")
            return
        end
        AS.Print(("Deleted macro |cffffd100%s|r."):format(own.name))
        RefreshOwn(own.index)
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function DoDelete()
    local own = state.macro and state.macro.own
    if not own then return end
    local popup = StaticPopup_Show("ARCANESHORTCUTS_DELETE", own.name)
    if popup then popup.data = own end
end

local function BuildDetail()
    local d = CreatePanel(frame)
    frame.detail = d
    d:SetPoint("TOPLEFT", frame, "TOPLEFT", 506, -100)
    d:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)

    -- Macro icon: left-click cycles forward through the candidates, right-click back.
    d.icon = CreateFrame("Button", nil, d)
    d.icon:SetSize(36, 36)
    d.icon:SetPoint("TOPLEFT", 12, -12)
    d.icon.tex = d.icon:CreateTexture(nil, "ARTWORK")
    d.icon.tex:SetAllPoints()
    d.icon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    d.icon:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    local function IconTooltip(self)
        local c = state.candidates and state.candidates[state.iconIndex]
        if not c then return end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Macro icon")
        GameTooltip:AddLine(c.label, 1, 1, 1)
        if c.icon == AS.DYNAMIC_ICON then
            GameTooltip:AddLine("The action button shows the spell #showtooltip picks.", 0.7, 0.7, 0.7, true)
        end
        if #state.candidates > 1 then
            GameTooltip:AddLine(("%d of %d. Left-click: next. Right-click: previous."):format(state.iconIndex, #state.candidates), 0.5, 0.8, 1, true)
        end
        GameTooltip:Show()
    end
    d.icon:SetScript("OnClick", function(self, button)
        CycleIcon(button == "RightButton" and -1 or 1)
        IconTooltip(self)
    end)
    d.icon:SetScript("OnEnter", IconTooltip)
    d.icon:SetScript("OnLeave", GameTooltip_Hide)

    d.title = d:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    d.title:SetPoint("TOPLEFT", d.icon, "TOPRIGHT", 10, -2)
    d.title:SetPoint("RIGHT", -12, 0)
    d.title:SetJustifyH("LEFT")

    d.source = d:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    d.source:SetPoint("TOPLEFT", d.title, "BOTTOMLEFT", 0, -4)

    d.desc = d:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    d.desc:SetPoint("TOPLEFT", d.icon, "BOTTOMLEFT", 0, -8)
    d.desc:SetPoint("RIGHT", -12, 0)
    d.desc:SetJustifyH("LEFT")
    d.desc:SetJustifyV("TOP")
    d.desc:SetHeight(48)

    local nameLabel = d:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    nameLabel:SetPoint("TOPLEFT", d.desc, "BOTTOMLEFT", 0, -8)
    nameLabel:SetText("Macro name")
    d.nameBox = CreateFrame("EditBox", nil, d, "InputBoxTemplate")
    d.nameBox:SetSize(160, 20)
    d.nameBox:SetPoint("LEFT", nameLabel, "RIGHT", 12, 0)
    d.nameBox:SetAutoFocus(false)
    d.nameBox:SetMaxLetters(AS.MAX_NAME)
    d.nameBox:SetScript("OnEscapePressed", d.nameBox.ClearFocus)
    d.nameBox:SetScript("OnEnterPressed", d.nameBox.ClearFocus)

    local bodyBg = CreatePanel(d)
    bodyBg:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", -4, -10)
    bodyBg:SetPoint("RIGHT", d, "RIGHT", -10, 0)
    bodyBg:SetHeight(150)
    bodyBg:SetBackdropColor(0, 0, 0, 0.8)

    local scroll = CreateFrame("ScrollFrame", nil, bodyBg, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 8, -8)
    scroll:SetPoint("BOTTOMRIGHT", -28, 8)
    d.body = CreateFrame("EditBox", nil, scroll)
    d.body:SetMultiLine(true)
    d.body:SetAutoFocus(false)
    d.body:SetFontObject(ChatFontNormal)
    d.body:SetWidth(300)
    d.body:SetScript("OnEscapePressed", d.body.ClearFocus)
    d.body:SetScript("OnTextChanged", function() UpdateDetailStatus() end)
    d.body:SetScript("OnCursorChanged", function(_, _, y, _, h)
        local top, height = scroll:GetVerticalScroll(), scroll:GetHeight()
        y = -y
        if y < top then scroll:SetVerticalScroll(y)
        elseif y + h > top + height then scroll:SetVerticalScroll(y + h - height) end
    end)
    scroll:SetScrollChild(d.body)
    scroll:SetScript("OnSizeChanged", function(_, w) d.body:SetWidth(w) end)
    bodyBg:EnableMouse(true)
    bodyBg:SetScript("OnMouseDown", function() d.body:SetFocus() end)

    d.count = d:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    d.count:SetPoint("TOPRIGHT", bodyBg, "BOTTOMRIGHT", -4, -3)

    local hint = d:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    hint:SetPoint("TOPLEFT", bodyBg, "BOTTOMLEFT", 4, -3)
    hint:SetText("Edit freely. Shift-click an item or spell to insert its name.")

    d.status = d:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    d.status:SetPoint("TOPLEFT", hint, "BOTTOMLEFT", 0, -8)
    d.status:SetPoint("RIGHT", -12, 0)
    d.status:SetJustifyH("LEFT")
    d.status:SetJustifyV("TOP")
    d.status:SetHeight(42)

    d.createChar = CreateFrame("Button", nil, d, "UIPanelButtonTemplate")
    d.createChar:SetSize(170, 24)
    d.createChar:SetPoint("BOTTOMLEFT", 10, 10)
    d.createChar:SetText("Create (Character)")
    d.createChar:SetScript("OnClick", function() DoCreate(true) end)

    d.createAcct = CreateFrame("Button", nil, d, "UIPanelButtonTemplate")
    d.createAcct:SetSize(170, 24)
    d.createAcct:SetPoint("LEFT", d.createChar, "RIGHT", 8, 0)
    d.createAcct:SetText("Create (Account)")
    d.createAcct:SetScript("OnClick", function() DoCreate(false) end)

    -- Shown instead of the Create buttons for the player's own macros.
    d.save = CreateFrame("Button", nil, d, "UIPanelButtonTemplate")
    d.save:SetSize(170, 24)
    d.save:SetPoint("BOTTOMLEFT", 10, 10)
    d.save:SetText("Save Changes")
    d.save:SetScript("OnClick", DoSave)
    d.save:Hide()

    d.delete = CreateFrame("Button", nil, d, "UIPanelButtonTemplate")
    d.delete:SetSize(170, 24)
    d.delete:SetPoint("LEFT", d.save, "RIGHT", 8, 0)
    d.delete:SetText("Delete")
    d.delete:SetScript("OnClick", DoDelete)
    d.delete:Hide()

    local reset = CreateFrame("Button", nil, d, "UIPanelButtonTemplate")
    reset:SetSize(80, 22)
    reset:SetPoint("BOTTOMRIGHT", d.createAcct, "TOPRIGHT", 0, 6)
    reset:SetText("Reset")
    reset:SetScript("OnClick", function() if state.macro then ShowMacro(state.macro) end end)

    local selectAll = CreateFrame("Button", nil, d, "UIPanelButtonTemplate")
    selectAll:SetSize(90, 22)
    selectAll:SetPoint("RIGHT", reset, "LEFT", -6, 0)
    selectAll:SetText("Select All")
    selectAll:SetScript("OnClick", function() d.body:SetFocus() d.body:HighlightText() end)

    -- Shift-clicking an item or spell inserts its plain name (what /use and /cast
    -- expect) into whichever of our boxes has focus, like Blizzard's macro editor.
    -- Bag clicks only reach ChatEdit_InsertLink while a chat box is open, so also
    -- hook HandleModifiedItemClick; one click can hit several hooks, so dedupe.
    local lastLink, lastTime
    local function InsertLink(link)
        if type(link) ~= "string" or not frame:IsShown() then return end
        local box = (d.body:HasFocus() and d.body) or (d.nameBox:HasFocus() and d.nameBox)
        if not box then return end
        local now = GetTime()
        if link == lastLink and now == lastTime then return end
        lastLink, lastTime = link, now
        local name = link:match("|h%[(.-)%]|h") or link
        box:Insert(name)
        -- Shift is also the split-stack modifier; don't leave that popup behind.
        C_Timer.After(0, function()
            if StackSplitFrame and StackSplitFrame:IsShown() then StackSplitFrame:Hide() end
        end)
    end
    if HandleModifiedItemClick then
        hooksecurefunc("HandleModifiedItemClick", function(link)
            if IsModifiedClick("CHATLINK") then InsertLink(link) end
        end)
    end
    if ChatEdit_InsertLink then hooksecurefunc("ChatEdit_InsertLink", InsertLink) end
    if ChatFrameUtil and ChatFrameUtil.InsertLink then hooksecurefunc(ChatFrameUtil, "InsertLink", InsertLink) end
end

---------------------------------------------------------------------------
-- Macro list
---------------------------------------------------------------------------
function UpdateList()
    local list = frame.list
    local macros = state.category and MacrosFor(state.category) or {}
    for i, m in ipairs(macros) do
        local row = list.rows[i]
        if not row then
            row = CreateFrame("Button", nil, list.content)
            row:SetSize(292, ROW_H)
            row:SetPoint("TOPLEFT", 0, -(i - 1) * ROW_H)
            row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
            row.sel = row:CreateTexture(nil, "BACKGROUND")
            row.sel:SetAllPoints()
            row.sel:SetColorTexture(0.55, 0.42, 1, 0.25)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(30, 30)
            row.icon:SetPoint("LEFT", 4, 0)
            row.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            -- Status dot sits on the icon's bottom-right corner.
            row.dotBorder = row:CreateTexture(nil, "OVERLAY", nil, 1)
            row.dotBorder:SetSize(10, 10)
            row.dotBorder:SetPoint("BOTTOMRIGHT", row.icon, "BOTTOMRIGHT", 2, -2)
            row.dotBorder:SetColorTexture(0, 0, 0, 1)
            row.dot = row:CreateTexture(nil, "OVERLAY", nil, 2)
            row.dot:SetSize(8, 8)
            row.dot:SetPoint("CENTER", row.dotBorder)
            row.dot:SetTexture("Interface\\Buttons\\WHITE8X8")
            row.name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            row.name:SetPoint("TOPLEFT", 42, -5)
            row.name:SetPoint("RIGHT", -6, 0)
            row.name:SetJustifyH("LEFT")
            row.desc = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.desc:SetPoint("TOPLEFT", row.name, "BOTTOMLEFT", 0, -3)
            row.desc:SetPoint("RIGHT", -6, 0)
            row.desc:SetJustifyH("LEFT")
            row.desc:SetWordWrap(false)
            row.desc:SetTextColor(0.7, 0.7, 0.7)
            row:SetScript("OnClick", function(self) ShowMacro(self.macro) UpdateList() end)
            -- Own macros can be dragged straight onto an action bar.
            row:RegisterForDrag("LeftButton")
            row:SetScript("OnDragStart", function(self)
                local own = self.macro and self.macro.own
                if own and not InCombatLockdown() then PickupMacro(own.index) end
            end)
            list.rows[i] = row
        end
        row.macro = m
        local status = AS:Analyze(m.body, m.optional)
        row.dot:SetVertexColor(unpack(STATUS_DOT[status]))
        if m.own then
            local icon = m.own.icon
            row.icon:SetTexture((not icon or icon == AS.DYNAMIC_ICON) and PreviewIcon(m.body) or icon)
            row.name:SetText(m.name)
            -- First line that isn't #showtooltip or similar, as a summary.
            local summary
            for line in m.body:gmatch("[^\n]+") do
                if not summary and not line:find("^%s*#") then summary = line end
            end
            row.desc:SetText(summary or "")
        else
            row.icon:SetTexture(PreviewIcon(m.body))
            local src = AS.SOURCES[m.src] or AS.SOURCES.Classic
            row.name:SetText(("%s  |cff%s%s|r"):format(m.name, src.color, m.src == "Retail" and "Wowhead" or "Classic"))
            row.desc:SetText(m.desc or "")
        end
        row.sel:SetShown(SameMacro(state.macro, m))
        row:Show()
    end
    for i = #macros + 1, #list.rows do list.rows[i]:Hide() end
    list.content:SetHeight(math.max(1, #macros * ROW_H))
    local cat = state.category
    list.empty:SetShown(#macros == 0 and cat and cat.class == OWN or false)
    if cat and cat.class == OWN then
        list.empty:SetText(("You have no %s macros yet.\n\nPick one from a class list and click Create (%s)."):format(cat.name:lower(), cat.name))
    end
end

local function BuildList()
    local p = CreatePanel(frame)
    p:SetPoint("TOPLEFT", frame, "TOPLEFT", 172, -100)
    p:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 172, 12)
    p:SetWidth(328)
    local scroll = CreateFrame("ScrollFrame", nil, p, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 6, -6)
    scroll:SetPoint("BOTTOMRIGHT", -26, 6)
    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(292, 1)
    scroll:SetScrollChild(content)
    local empty = p:CreateFontString(nil, "OVERLAY", "GameFontDisable")
    empty:SetPoint("TOPLEFT", 16, -20)
    empty:SetPoint("RIGHT", -16, 0)
    empty:SetJustifyH("CENTER")
    frame.list = { panel = p, scroll = scroll, content = content, rows = {}, empty = empty }
end

---------------------------------------------------------------------------
-- Categories and class picker
---------------------------------------------------------------------------
local function SelectCategory(cat)
    state.category = cat
    AS.db.lastCategory = cat.name
    for _, b in ipairs(frame.catButtons) do
        b.sel:SetShown(b.cat and b.cat.class == cat.class and b.cat.name == cat.name)
    end
    frame.list.scroll:SetVerticalScroll(0)
    local first = MacrosFor(cat)[1]
    ShowMacro(first)
    UpdateList()
end

function UpdateCategoryCounts()
    for _, b in ipairs(frame.catButtons) do
        if b:IsShown() and b.cat then
            local n = #MacrosFor(b.cat)
            b.count:SetText(b.cat.class == OWN and ("%d/%d"):format(n, OWN_LIMIT[b.cat.name]) or n)
        end
    end
end

local function SelectClass(class)
    state.class = class
    for _, b in ipairs(frame.classButtons) do
        b:SetAlpha(b.class == class and 1 or 0.45)
        b.ring:SetShown(b.class == class)
    end
    if class == OWN then
        frame.classLabel:SetText("Your macros")
    else
        frame.classLabel:SetText(("|c%s%s|r macros"):format(ClassColor(class), LocalizedClass(class)))
    end

    local cats = CategoriesFor(class)
    for i, cat in ipairs(cats) do
        local b = frame.catButtons[i]
        if not b then
            b = CreateFrame("Button", nil, frame.catPanel)
            b:SetSize(140, 26)
            b:SetPoint("TOPLEFT", 6, -6 - (i - 1) * 28)
            b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
            b.sel = b:CreateTexture(nil, "BACKGROUND")
            b.sel:SetAllPoints()
            b.sel:SetColorTexture(0.55, 0.42, 1, 0.3)
            b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            b.text:SetPoint("LEFT", 8, 0)
            b.count = b:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
            b.count:SetPoint("RIGHT", -6, 0)
            b:SetScript("OnClick", function(self) SelectCategory(self.cat) end)
            frame.catButtons[i] = b
        end
        b.cat = cat
        b.text:SetText(cat.name)
        b:Show()
    end
    for i = #cats + 1, #frame.catButtons do frame.catButtons[i]:Hide() end
    UpdateCategoryCounts()

    local want = AS.db.lastCategory
    local pick = cats[1]
    for _, c in ipairs(cats) do if c.name == want then pick = c end end
    SelectCategory(pick)
end

local function BuildClassBar()
    frame.classButtons = {}
    for i, class in ipairs(AS.CLASS_ORDER) do
        local b = CreateFrame("Button", nil, frame)
        b:SetSize(34, 34)
        b:SetPoint("TOPLEFT", frame, "TOPLEFT", 66 + (i - 1) * 40, -30)
        b.class = class
        local tex = b:CreateTexture(nil, "ARTWORK")
        tex:SetAllPoints()
        tex:SetTexture(CLASS_ICONS)
        local c = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[class]
        if c then tex:SetTexCoord(c[1], c[2], c[3], c[4]) end
        b.ring = b:CreateTexture(nil, "OVERLAY")
        b.ring:SetPoint("TOPLEFT", -4, 4)
        b.ring:SetPoint("BOTTOMRIGHT", 4, -4)
        b.ring:SetTexture("Interface\\Buttons\\CheckButtonHilight")
        b.ring:SetBlendMode("ADD")
        b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
        b:SetScript("OnClick", function(self) SelectClass(self.class) end)
        b:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
            GameTooltip:SetText(LocalizedClass(self.class))
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", GameTooltip_Hide)
        frame.classButtons[i] = b
    end

    -- "My Macros": the account and character macros the player already has.
    local own = CreateFrame("Button", nil, frame)
    own:SetSize(34, 34)
    own:SetPoint("TOPLEFT", frame, "TOPLEFT", 14, -30)
    own.class = OWN
    local tex = own:CreateTexture(nil, "ARTWORK")
    tex:SetAllPoints()
    tex:SetTexture("Interface\\Icons\\INV_Misc_Note_01")
    tex:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    own.ring = own:CreateTexture(nil, "OVERLAY")
    own.ring:SetPoint("TOPLEFT", -4, 4)
    own.ring:SetPoint("BOTTOMRIGHT", 4, -4)
    own.ring:SetTexture("Interface\\Buttons\\CheckButtonHilight")
    own.ring:SetBlendMode("ADD")
    own:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    own:SetScript("OnClick", function() SelectClass(OWN) end)
    own:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("My Macros")
        GameTooltip:AddLine("See, edit and delete the account and character macros you already have.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    own:SetScript("OnLeave", GameTooltip_Hide)
    frame.classButtons[#frame.classButtons + 1] = own

    frame.classLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.classLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 14, -74)

    local legend = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    legend:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -16, -40)
    legend:SetJustifyH("RIGHT")
    local function dot(r, g, b) return ("|TInterface\\Buttons\\WHITE8X8:9:9:0:0:8:8:0:8:0:8:%d:%d:%d|t"):format(r, g, b) end
    legend:SetText(("%s ready   %s partly available   %s needs editing\n|cff%sClassic|r = Classic/TBC staple   |cff%sWowhead|r = from Wowhead's retail guides"):format(
        dot(64, 255, 64), dot(255, 204, 0), dot(255, 90, 90), AS.SOURCES.Classic.color, AS.SOURCES.Retail.color))

    frame.catPanel = CreatePanel(frame)
    frame.catPanel:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -100)
    frame.catPanel:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 12, 12)
    frame.catPanel:SetWidth(154)
    frame.catButtons = {}
end

---------------------------------------------------------------------------
-- Main frame
---------------------------------------------------------------------------
local function Build()
    frame = CreateFrame("Frame", "ArcaneShortcutsFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(FRAME_W, FRAME_H)
    frame:SetFrameStrata("HIGH")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local p, _, rp, x, y = self:GetPoint()
        AS.db.point = { p, rp, x, y }
    end)
    local pt = AS.db.point
    if pt then frame:SetPoint(pt[1], UIParent, pt[2], pt[3], pt[4]) else frame:SetPoint("CENTER") end
    tinsert(UISpecialFrames, "ArcaneShortcutsFrame")

    local title = frame.TitleText or frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    if not frame.TitleText then title:SetPoint("TOP", 0, -5) end
    title:SetText("|cff8f6cffArcane|r Shortcuts")

    BuildClassBar()
    BuildList()
    BuildDetail()

    -- Refresh "known spell" dots when the spellbook or bags change, and the
    -- overview when macros change, here or in the game's macro window.
    frame:RegisterEvent("SPELLS_CHANGED")
    frame:RegisterEvent("UPDATE_MACROS")
    pcall(frame.RegisterEvent, frame, "BAG_UPDATE_DELAYED")
    frame:SetScript("OnEvent", function(self, event)
        if not self:IsShown() then return end
        if event == "UPDATE_MACROS" then
            if state.class == OWN then UpdateCategoryCounts() UpdateList() end
            return
        end
        UpdateList()
        if state.macro then UpdateDetailStatus() end
    end)
    frame:SetScript("OnShow", function() UpdateCategoryCounts() UpdateList() end)

    -- Each session opens on the player's own macros.
    SelectClass(OWN)
end

function AS:Toggle()
    if not frame then Build() frame:Show() return end
    frame:SetShown(not frame:IsShown())
end

---------------------------------------------------------------------------
-- Minimap button
---------------------------------------------------------------------------
local mini
local function PositionMini()
    local a = math.rad(AS.db.minimapAngle or 200)
    mini:ClearAllPoints()
    mini:SetPoint("CENTER", Minimap, "CENTER", math.cos(a) * 80, math.sin(a) * 80)
end

function AS:UpdateMinimapButton()
    if not mini then return end
    mini:SetShown(not self.db.hideMinimap)
end

function AS:OnLoad()

    mini = CreateFrame("Button", "ArcaneShortcutsMinimapButton", Minimap)
    mini:SetSize(31, 31)
    mini:SetFrameStrata("MEDIUM")
    mini:SetFrameLevel(8)
    mini:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    local bg = mini:CreateTexture(nil, "BACKGROUND")
    bg:SetSize(20, 20)
    bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
    bg:SetPoint("TOPLEFT", 7, -5)
    local icon = mini:CreateTexture(nil, "ARTWORK")
    icon:SetSize(17, 17)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Book_11")
    icon:SetPoint("TOPLEFT", 7, -6)
    local border = mini:CreateTexture(nil, "OVERLAY")
    border:SetSize(53, 53)
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    border:SetPoint("TOPLEFT")
    mini:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    mini:RegisterForDrag("LeftButton")
    mini:SetScript("OnClick", function() AS:Toggle() end)
    mini:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local s = Minimap:GetEffectiveScale()
            AS.db.minimapAngle = math.deg(math.atan2(cy / s - my, cx / s - mx))
            PositionMini()
        end)
    end)
    mini:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
    mini:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("|cff8f6cffArcane|r Shortcuts")
        GameTooltip:AddLine("Click to browse ready-to-use macros.", 1, 1, 1)
        GameTooltip:AddLine("Drag to move. /as minimap hides this button.", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    mini:SetScript("OnLeave", GameTooltip_Hide)
    PositionMini()
    self:UpdateMinimapButton()
end
