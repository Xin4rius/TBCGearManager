local addonName, TGM = ...
_G.TBCGearManager = TGM

TGM.L = TGM.L or {}
local L = TGM.L

local function Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ccff[TBCGearManager]|r " .. msg)
end

function TGM:GetSets()
    local sets = {}
    if C_EquipmentSet and C_EquipmentSet.GetEquipmentSetIDs then
        local setIDs = C_EquipmentSet.GetEquipmentSetIDs()
        for _, setID in ipairs(setIDs) do
            local name, iconFileID, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(setID)
            table.insert(sets, {
                id = setID,
                name = name,
                icon = iconFileID,
                isEquipped = isEquipped
            })
        end
    elseif GetNumEquipmentSets then
        for i = 1, GetNumEquipmentSets() do
            local name, icon, setID, isEquipped = GetEquipmentSetInfo(i)
            table.insert(sets, {
                id = setID or name,
                name = name,
                icon = icon,
                isEquipped = isEquipped
            })
        end
    end
    table.sort(sets, function(a, b) return a.name < b.name end)
    return sets
end

function TGM:GetSetID(name)
    local sets = self:GetSets()
    for _, s in ipairs(sets) do
        if s.name == name then return s.id end
    end
    return nil
end

function TGM:SaveSet(name, icon)
    icon = icon or 134400
    local existingID = self:GetSetID(name)
    
    if C_EquipmentSet and C_EquipmentSet.SaveEquipmentSet then
        if existingID then
            C_EquipmentSet.SaveEquipmentSet(existingID, icon)
        else
            C_EquipmentSet.CreateEquipmentSet(name, icon)
        end
    elseif SaveEquipmentSet then
        SaveEquipmentSet(name, icon)
    end
    
    Print(string.format(L["SET_SAVED"] or "Set %s saved.", name))
    if C_Timer then C_Timer.After(0.2, function() if TGM.UpdateUI then TGM:UpdateUI() end end) end
end

function TGM:ModifySet(id, newName, newIcon)
    if C_EquipmentSet and C_EquipmentSet.ModifyEquipmentSet then
        C_EquipmentSet.ModifyEquipmentSet(id, newName, newIcon)
    else
        local sets = self:GetSets()
        local oldName = id
        for _, s in ipairs(sets) do if s.id == id then oldName = s.name break end end
        if oldName ~= newName and DeleteEquipmentSet then
            DeleteEquipmentSet(id)
        end
        if SaveEquipmentSet then
            SaveEquipmentSet(newName, newIcon)
        end
    end
    if C_Timer then C_Timer.After(0.2, function() if TGM.UpdateUI then TGM:UpdateUI() end end) end
end

function TGM:DeleteSet(id)
    if C_EquipmentSet and C_EquipmentSet.DeleteEquipmentSet then
        C_EquipmentSet.DeleteEquipmentSet(id)
    elseif DeleteEquipmentSet then
        DeleteEquipmentSet(id)
    end
    Print(L["SET_DELETED"] or "Set deleted.")
    if C_Timer then C_Timer.After(0.2, function() if TGM.UpdateUI then TGM:UpdateUI() end end) end
end

function TGM:EquipSet(id)
    if InCombatLockdown() then
        Print(L["COMBAT_WARNING"] or "Cannot switch gear in combat.")
    end
    if C_EquipmentSet and C_EquipmentSet.UseEquipmentSet then
        C_EquipmentSet.UseEquipmentSet(id)
    elseif UseEquipmentSet then
        UseEquipmentSet(id)
    end
    Print(L["SET_EQUIPPED"] or "Set equipped.")
    if TGM.UpdateUI then TGM:UpdateUI() end
end

function TGM:PickupSet(id)
    if C_EquipmentSet and C_EquipmentSet.PickupEquipmentSet then
        C_EquipmentSet.PickupEquipmentSet(id)
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("EQUIPMENT_SETS_CHANGED")
f:SetScript("OnEvent", function(self, event)
    if event == "EQUIPMENT_SETS_CHANGED" then
        if TGM.UpdateUI then TGM:UpdateUI() end
    end
end)

local loadFrame = CreateFrame("Frame")
loadFrame:RegisterEvent("ADDON_LOADED")
loadFrame:SetScript("OnEvent", function(self, event, arg1)
    if arg1 == addonName then
        if _G.TBCGearManagerDB then
            _G.TBCGearManagerDB.sets = nil
        end
    end
end)

SLASH_TBCGEARMANAGER1 = "/tgm"
SlashCmdList["TBCGEARMANAGER"] = function(msg)
    if TBCGearManagerFrame and TBCGearManagerFrame:IsShown() then
        TBCGearManagerFrame:Hide()
    elseif TBCGearManagerFrame then
        TBCGearManagerFrame:Show()
        if TGM.UpdateUI then TGM:UpdateUI() end
    end
end
