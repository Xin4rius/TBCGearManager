local _, TGM = ...
local L = TGM.L

-- Colors
local COLOR_BG = {0.1, 0.1, 0.1, 0.9}
local COLOR_BORDER = {0.3, 0.3, 0.3, 1}

-- Main Panel
local TGMFrame = CreateFrame("Frame", "TBCGearManagerFrame", CharacterFrame)
TGMFrame:SetSize(220, 380)
TGMFrame:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT", -32, -12)
TGMFrame:SetFrameStrata("DIALOG")
TGMFrame:SetToplevel(true)

if TGMFrame.SetBackdrop then
    TGMFrame:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
    TGMFrame:SetBackdropColor(unpack(COLOR_BG))
    TGMFrame:SetBackdropBorderColor(unpack(COLOR_BORDER))
else
    Mixin(TGMFrame, BackdropTemplateMixin)
    TGMFrame:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
    TGMFrame:SetBackdropColor(unpack(COLOR_BG))
    TGMFrame:SetBackdropBorderColor(unpack(COLOR_BORDER))
end
TGMFrame:Hide()

local title = TGMFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
title:SetPoint("TOP", 0, -12)
title:SetText(L["ADDON_NAME"])

local closeBtn = CreateFrame("Button", nil, TGMFrame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -2, -2)

local toggleBtn = CreateFrame("Button", "TBCGearManagerToggleButton", PaperDollFrame, "UIPanelButtonTemplate")
toggleBtn:SetSize(90, 22)
toggleBtn:SetPoint("TOPRIGHT", PaperDollFrame, "TOPRIGHT", -40, -40)
toggleBtn:SetText("Gear Sets")
toggleBtn:SetScript("OnClick", function()
    if TGMFrame:IsShown() then TGMFrame:Hide() else TGMFrame:Show(); TGM:UpdateUI() end
end)

local helpText = TGMFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
helpText:SetPoint("TOP", 0, -32)
helpText:SetWidth(200)
helpText:SetText(L["HELP_TEXT"])
helpText:SetJustifyH("CENTER")

-- NEW SET BUTTON
local newSetBtn = CreateFrame("Button", nil, TGMFrame, "UIPanelButtonTemplate")
newSetBtn:SetSize(180, 22)
newSetBtn:SetPoint("TOP", 0, -65)
newSetBtn:SetText(L["NEW_SET"])

-- STATE
TGM.SelectedSetID = nil
TGM.SelectedSetName = nil
TGM.SelectedSetIcon = nil

-- BOTTOM BUTTONS
local bottomPanel = CreateFrame("Frame", nil, TGMFrame)
bottomPanel:SetSize(200, 50)
bottomPanel:SetPoint("BOTTOM", 0, 10)

local equipBtn = CreateFrame("Button", nil, bottomPanel, "UIPanelButtonTemplate")
equipBtn:SetSize(95, 22)
equipBtn:SetPoint("TOPLEFT", 0, 0)
equipBtn:SetText(L["EQUIP"])
equipBtn:SetScript("OnClick", function() if TGM.SelectedSetID then TGM:EquipSet(TGM.SelectedSetID) end end)

local saveBtn = CreateFrame("Button", nil, bottomPanel, "UIPanelButtonTemplate")
saveBtn:SetSize(95, 22)
saveBtn:SetPoint("TOPRIGHT", 0, 0)
saveBtn:SetText(L["SAVE"])
saveBtn:SetScript("OnClick", function()
    if TGM.SelectedSetName then
        StaticPopup_Show("TBCGM_CONFIRM_SAVE", TGM.SelectedSetName)
    end
end)

local modifyBtn = CreateFrame("Button", nil, bottomPanel, "UIPanelButtonTemplate")
modifyBtn:SetSize(95, 22)
modifyBtn:SetPoint("BOTTOMLEFT", 0, 0)
modifyBtn:SetText(L["MODIFY"])

local deleteBtn = CreateFrame("Button", nil, bottomPanel, "UIPanelButtonTemplate")
deleteBtn:SetSize(95, 22)
deleteBtn:SetPoint("BOTTOMRIGHT", 0, 0)
deleteBtn:SetText(L["DELETE"])
deleteBtn:SetScript("OnClick", function() if TGM.SelectedSetID then StaticPopup_Show("TBCGM_CONFIRM_DELETE", TGM.SelectedSetName) end end)

StaticPopupDialogs["TBCGM_CONFIRM_DELETE"] = {
    text = L["CONFIRM_DELETE"],
    button1 = L["DELETE"],
    button2 = L["CANCEL"],
    OnAccept = function()
        if TGM.SelectedSetID then
            TGM:DeleteSet(TGM.SelectedSetID)
            TGM.SelectedSetID = nil
            TGM:UpdateUI()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["TBCGM_CONFIRM_SAVE"] = {
    text = L["CONFIRM_SAVE"] or "Are you sure you want to overwrite set '%s'?",
    button1 = L["SAVE"],
    button2 = L["CANCEL"],
    OnAccept = function()
        if TGM.SelectedSetName then
            TGM:SaveSet(TGM.SelectedSetName, TGM.SelectedSetIcon)
            TGM:UpdateUI()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- GRID OF SETS
local setGrid = CreateFrame("ScrollFrame", "TBCGearManagerScrollFrame", TGMFrame, "UIPanelScrollFrameTemplate")
setGrid:SetPoint("TOPLEFT", 10, -95)
setGrid:SetPoint("BOTTOMRIGHT", -30, 65)

local setChild = CreateFrame("Frame", nil, setGrid)
setChild:SetSize(180, 10)
setGrid:SetScrollChild(setChild)

local setRows = {}
local function GetSetButton(index)
    if setRows[index] then return setRows[index] end
    
    local btn = CreateFrame("Button", "TGMSetBtn"..index, setChild)
    btn:SetSize(40, 40)
    
    local tex = btn:CreateTexture(nil, "BACKGROUND")
    tex:SetAllPoints()
    btn.icon = tex
    
    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(1, 1, 1, 0.2)
    
    local sel = btn:CreateTexture(nil, "OVERLAY")
    sel:SetAllPoints()
    sel:SetColorTexture(1, 1, 0, 0.4)
    sel:Hide()
    btn.sel = sel
    
    local nameText = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    nameText:SetPoint("BOTTOM", 0, -10)
    nameText:SetWidth(45)
    nameText:SetHeight(10)
    btn.nameText = nameText
    
    btn:RegisterForDrag("LeftButton")
    btn:SetScript("OnDragStart", function(self)
        if self.setID then TGM:PickupSet(self.setID) end
    end)
    
    btn:RegisterForClicks("LeftButtonUp")
    btn:SetScript("OnClick", function(self)
        TGM.SelectedSetID = self.setID
        TGM.SelectedSetName = self.setName
        TGM.SelectedSetIcon = self.iconID
        TGM:UpdateUI()
    end)
    btn:SetScript("OnDoubleClick", function(self)
        if self.setID then TGM:EquipSet(self.setID) end
    end)
    
    setRows[index] = btn
    return btn
end

-- Refresh UI
function TGM:UpdateUI()
    for _, row in ipairs(setRows) do row:Hide() end
    
    local sets = TGM:GetSets()
    local cols = 4
    local spacing = 5
    local btnSize = 40
    
    setChild:SetHeight(math.ceil(#sets / cols) * (btnSize + 15))
    
    for i, set in ipairs(sets) do
        local btn = GetSetButton(i)
        local row = math.floor((i-1)/cols)
        local col = (i-1)%cols
        btn:SetPoint("TOPLEFT", col*(btnSize+spacing), -row*(btnSize+15))
        
        btn.setName = set.name
        btn.setID = set.id
        btn.iconID = set.icon or 134400
        btn.icon:SetTexture(btn.iconID)
        btn.nameText:SetText(set.name)
        
        if TGM.SelectedSetID == set.id then
            btn.sel:Show()
        else
            btn.sel:Hide()
        end
        btn:Show()
    end
    
    local hasSel = (TGM.SelectedSetID ~= nil)
    equipBtn:SetEnabled(hasSel)
    saveBtn:SetEnabled(hasSel)
    modifyBtn:SetEnabled(hasSel)
    deleteBtn:SetEnabled(hasSel)
end

-- ICON PICKER DIALOG (FauxScrollFrame for massive icon list)
local picker = CreateFrame("Frame", "TGMIconPickerFrame", TGMFrame)
picker:SetSize(280, 360)
picker:SetPoint("TOPLEFT", TGMFrame, "TOPRIGHT", 5, 0)
picker:SetFrameLevel(TGMFrame:GetFrameLevel() + 5)
if picker.SetBackdrop then
    picker:SetBackdrop({ bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize=32, edgeSize=32, insets={left=10, right=10, top=10, bottom=10} })
else
    Mixin(picker, BackdropTemplateMixin)
    picker:SetBackdrop({ bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize=32, edgeSize=32, insets={left=10, right=10, top=10, bottom=10} })
end
picker:Hide()

local nameLabel = picker:CreateFontString(nil, "OVERLAY", "GameFontNormal")
nameLabel:SetPoint("TOPLEFT", 20, -20)
nameLabel:SetText(L["ENTER_NAME"])

local nameEdit = CreateFrame("EditBox", nil, picker, "InputBoxTemplate")
nameEdit:SetSize(230, 20)
nameEdit:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 5, -5)
nameEdit:SetAutoFocus(false)

local iconScroll = CreateFrame("ScrollFrame", "TGMIconScrollFrame", picker, "FauxScrollFrameTemplate")
iconScroll:SetPoint("TOPLEFT", nameEdit, "BOTTOMLEFT", -5, -15)
iconScroll:SetPoint("BOTTOMRIGHT", -35, 45)

local isModifying = false
local allIcons = {}
local selectedIcon = 134400

local function BuildIconList()
    allIcons = {}
    if GetMacroIcons then local i = GetMacroIcons(); if i then for _,v in pairs(i) do table.insert(allIcons, v) end end end
    if GetMacroItemIcons then local i = GetMacroItemIcons(); if i then for _,v in pairs(i) do table.insert(allIcons, v) end end end
    if GetLooseMacroIcons then local i = GetLooseMacroIcons(); if i then for _,v in pairs(i) do table.insert(allIcons, v) end end end
    if #allIcons == 0 then for i=134400, 134800 do table.insert(allIcons, i) end end
end

local NUM_COLS = 5
local NUM_ROWS = 6
local ICON_SIZE = 40
local iconGridBtns = {}

for r = 1, NUM_ROWS do
    for c = 1, NUM_COLS do
        local btn = CreateFrame("Button", nil, picker)
        btn:SetSize(ICON_SIZE, ICON_SIZE)
        btn:SetPoint("TOPLEFT", iconScroll, "TOPLEFT", (c-1)*(ICON_SIZE+2), -(r-1)*(ICON_SIZE+2))
        
        btn.icon = btn:CreateTexture(nil, "BACKGROUND")
        btn.icon:SetAllPoints()
        
        local hl = btn:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.3)
        
        local sel = btn:CreateTexture(nil, "OVERLAY")
        sel:SetAllPoints()
        sel:SetColorTexture(1, 1, 0, 0.5)
        sel:Hide()
        btn.sel = sel
        
        btn:SetScript("OnClick", function()
            selectedIcon = btn.texID
            TGM:UpdateIconPicker()
        end)
        
        table.insert(iconGridBtns, btn)
    end
end

function TGM:UpdateIconPicker()
    if #allIcons == 0 then BuildIconList() end
    local totalRows = math.ceil(#allIcons / NUM_COLS)
    FauxScrollFrame_Update(iconScroll, totalRows, NUM_ROWS, ICON_SIZE+2)
    local offset = FauxScrollFrame_GetOffset(iconScroll)
    
    local idx = offset * NUM_COLS + 1
    for i = 1, NUM_ROWS * NUM_COLS do
        local btn = iconGridBtns[i]
        local texID = allIcons[idx]
        if texID then
            btn.icon:SetTexture(texID)
            btn.texID = texID
            btn:Show()
            if selectedIcon == texID then btn.sel:Show() else btn.sel:Hide() end
            idx = idx + 1
        else
            btn:Hide()
        end
    end
end

iconScroll:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, ICON_SIZE+2, function() TGM:UpdateIconPicker() end)
end)

local savePickerBtn = CreateFrame("Button", nil, picker, "UIPanelButtonTemplate")
savePickerBtn:SetSize(90, 22)
savePickerBtn:SetPoint("BOTTOMLEFT", picker, "BOTTOM", 2, 15)
savePickerBtn:SetText(L["VALIDATE"] or "Validate")
savePickerBtn:SetScript("OnClick", function()
    local name = nameEdit:GetText()
    if name and name ~= "" then
        if isModifying and TGM.SelectedSetID then
            TGM:ModifySet(TGM.SelectedSetID, name, selectedIcon)
        else
            TGM:SaveSet(name, selectedIcon)
        end
        picker:Hide()
    end
end)

local cancelPickerBtn = CreateFrame("Button", nil, picker, "UIPanelButtonTemplate")
cancelPickerBtn:SetSize(90, 22)
cancelPickerBtn:SetPoint("BOTTOMRIGHT", picker, "BOTTOM", -2, 15)
cancelPickerBtn:SetText(L["CANCEL"])
cancelPickerBtn:SetScript("OnClick", function() picker:Hide() end)

newSetBtn:SetScript("OnClick", function()
    isModifying = false
    nameEdit:SetText("")
    selectedIcon = 134400
    picker:Show()
    nameEdit:SetFocus()
    TGM:UpdateIconPicker()
end)

modifyBtn:SetScript("OnClick", function()
    if TGM.SelectedSetID then
        isModifying = true
        nameEdit:SetText(TGM.SelectedSetName)
        selectedIcon = TGM.SelectedSetIcon
        picker:Show()
        nameEdit:SetFocus()
        TGM:UpdateIconPicker()
    end
end)

CharacterFrame:HookScript("OnHide", function()
    if TGMFrame then TGMFrame:Hide() end
end)
