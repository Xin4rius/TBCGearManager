local _, TGM = ...
if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
TGM.L = TGM.L or {}
local L = TGM.L

L["ADDON_NAME"] = "TBCGearManager"
L["EQUIPMENT_MANAGER"] = "Gestor de equipamiento"
L["NEW_SET"] = "Nuevo"
L["SAVE"] = "Guardar"
L["VALIDATE"] = "Validar"
L["EQUIP"] = "Equipar"
L["DELETE"] = "Eliminar"
L["MODIFY"] = "Modificar"
L["UPDATE"] = "Actualizar"
L["CANCEL"] = "Cancelar"
L["ENTER_NAME"] = "Nombre del conjunto:"
L["CONFIRM_DELETE"] = "¿Seguro que quieres borrar el conjunto '%s'?"
L["CONFIRM_SAVE"] = "¿Seguro que quieres sobrescribir el conjunto '%s' con tu equipamiento actual?"
L["SET_SAVED"] = "Conjunto '%s' guardado."
L["SET_DELETED"] = "Conjunto eliminado."
L["SET_EQUIPPED"] = "Conjunto equipado."
L["COMBAT_WARNING"] = "¡No puedes cambiar la armadura en combate!"
L["HELP_TEXT"] = "Selecciona un conjunto para equiparlo, modificarlo o eliminarlo. Doble clic para equipar rápido."
L["IMPORTED_SETS"] = "Se han importado %d conjuntos de la API de WoW."
