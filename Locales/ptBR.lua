local _, TGM = ...
if GetLocale() ~= "ptBR" and GetLocale() ~= "ptPT" then return end
TGM.L = TGM.L or {}
local L = TGM.L

L["ADDON_NAME"] = "TBCGearManager"
L["EQUIPMENT_MANAGER"] = "Gerenciador de Equipamentos"
L["NEW_SET"] = "Novo"
L["SAVE"] = "Salvar"
L["VALIDATE"] = "Validar"
L["EQUIP"] = "Equipar"
L["DELETE"] = "Excluir"
L["MODIFY"] = "Modificar"
L["UPDATE"] = "Atualizar"
L["CANCEL"] = "Cancelar"
L["ENTER_NAME"] = "Nome do Conjunto:"
L["CONFIRM_DELETE"] = "Tem certeza de que deseja excluir o conjunto '%s'?"
L["CONFIRM_SAVE"] = "Tem certeza de que deseja sobrescrever o conjunto '%s' com seu equipamento atual?"
L["SET_SAVED"] = "Conjunto '%s' salvo."
L["SET_DELETED"] = "Conjunto excluído."
L["SET_EQUIPPED"] = "Conjunto equipado."
L["COMBAT_WARNING"] = "Você não pode trocar de armadura em combate!"
L["HELP_TEXT"] = "Selecione um conjunto para equipar, modificar ou excluir. Clique duplo para equipar rápido."
L["IMPORTED_SETS"] = "Importado %d conjuntos da API do WoW."
