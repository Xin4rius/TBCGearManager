local _, TGM = ...
if GetLocale() ~= "zhTW" and GetLocale() ~= "zhCN" then return end
TGM.L = TGM.L or {}
local L = TGM.L

L["ADDON_NAME"] = "TBCGearManager"
L["EQUIPMENT_MANAGER"] = "裝備管理員"
L["NEW_SET"] = "新套裝"
L["SAVE"] = "儲存"
L["VALIDATE"] = "確認"
L["EQUIP"] = "裝備"
L["DELETE"] = "刪除"
L["MODIFY"] = "修改"
L["UPDATE"] = "更新"
L["CANCEL"] = "取消"
L["ENTER_NAME"] = "輸入套裝名稱:"
L["CONFIRM_DELETE"] = "確定要刪除套裝「%s」嗎？"
L["CONFIRM_SAVE"] = "確定要使用目前裝備覆寫套裝「%s」嗎？"
L["SET_SAVED"] = "裝備套裝「%s」已儲存。"
L["SET_DELETED"] = "裝備套裝已刪除。"
L["SET_EQUIPPED"] = "裝備套裝已裝備。"
L["COMBAT_WARNING"] = "戰鬥中無法更換非武器裝備！"
L["HELP_TEXT"] = "選擇套裝以裝備、修改或刪除。按兩下可快速裝備。"
L["IMPORTED_SETS"] = "已從 WoW API 匯入 %d 個套裝。"
