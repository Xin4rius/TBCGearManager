# TBCGearManager

**TBCGearManager** is a professional, lightweight World of Warcraft addon designed specifically for modern TBC Anniversary / Classic clients. It faithfully reproduces the beloved **Wrath of the Lich King (WotLK)** built-in Equipment Manager interface while fully utilizing the native, modern `C_EquipmentSet` WoW API under the hood.

![TBCGearManager UI](PLACEHOLDER_ADD_YOUR_IMAGE_LINK_HERE.png)

## ✨ Features

* **Native API Integration:** No clunky item-by-item queues or database bloat. The addon directly interfaces with WoW's native `C_EquipmentSet` engine, allowing for instantaneous, locked-slot-free "one-shot" gear equipping.
* **WotLK-Styled UI:** Seamlessly integrates a toggleable equipment grid pane right next to your `CharacterFrame` (Paper Doll).
* **Drag-and-Drop Action Bars:** Simply click and drag any gear set icon from the manager grid directly onto your action bars for quick access. 
* **Native Macro Support:** Fully supports standard `/equipset SetName` commands in your personalized macros.
* **Advanced Icon Picker:** Includes a high-performance scrolling icon picker dialog loaded with thousands of official macro and item icons for customizing your sets.
* **Complete Localization:** Professionally translated and supported right out of the box for 8 languages: 
  * English (`enUS`), French (`frFR`), German (`deDE`), Spanish (`esES`), Russian (`ruRU`), Korean (`koKR`), Traditional Chinese (`zhTW`), and Portuguese (`ptBR`).

## 📥 Installation

1. Download the latest release from the repository.
2. Extract the folder into your World of Warcraft addons directory:
   `<WoW Directory>/_anniversary_/Interface/AddOns/`
3. Ensure the folder is named exactly `TBCGearManager`.
4. Launch World of Warcraft and make sure the addon is enabled in your AddOn list!

## 🚀 Usage

* **Open the Manager:** Open your Character window (`C` key by default) and click the new **"Gear Sets"** button in the top right corner.
* **Create a Set:** Click **"New Set"**, type a name, choose your favorite icon from the scrolling grid, and click **"Validate"**. Your current equipment is instantly saved!
* **Equip a Set:** Either **Double-Click** the set in the grid, or select it and click **"Equip"** at the bottom of the pane.
* **Update/Modify:** Select an existing set and click **"Save"** to overwrite it with your currently worn gear, or click **"Modify"** to change its name and icon.
* **Delete:** Select an existing set and click **"Delete"**. 

## 🛠️ Slash Commands

You can also interact with the manager through the chat using the `/tgm` command:
* `/tgm` - Toggles the visibility of the TBCGearManager pane.
* `/tgm import` - *(Advanced)* Safely imports and recovers any pre-existing gear sets you might have created through the hidden native WoW API via other addons.

## 🤝 Contributions

Contributions are welcome! If you have suggestions, bug reports, or want to add a new feature, feel free to open an issue or submit a pull request. I am open to collaboration to improve and expand this addon.

---

*Authored by Xin4rius.*
