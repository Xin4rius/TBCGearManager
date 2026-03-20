# TBCGearManager

TBCGearManager brings the Equipment Manager functionality to TBC Anniversary / Classic clients. It uses the native `C_EquipmentSet` WoW API for fast and reliable gear swapping.

![TBCGearManager UI](https://github.com/Xin4rius/TBCGearManager/blob/main/Media/Screenshot/Media1.png)

## Features

* **Native API:** Uses WoW's built-in `C_EquipmentSet` engine for instantaneous gear equipping.
* **WotLK UI:** Integrates a toggleable equipment grid next to the Character Frame.
* **Action Bar Support:** Drag and drop gear set icons directly onto action bars.
* **Macro Support:** Use `/equipset SetName` in standard macros.
* **Localization:** Supports English, French, German, Spanish, Russian, Korean, Traditional Chinese, and Portuguese.

## Installation

1. Download the latest release.
2. Extract the folder into your addons directory: `Interface/AddOns/`
3. Ensure the folder is named `TBCGearManager`.
4. Enable the addon in-game.

## Usage

* **Open UI:** Click the "Gear Sets" button in the top-right of your Character window (`C`).
* **Create Set:** Click "New Set", enter a name, pick an icon, and click "Validate".
* **Equip Set:** Double-click a set in the grid or select it and click "Equip".
* **Modify:** Select a set and click "Save" to update it with current gear, or "Modify" to change name/icon.
* **Delete:** Select a set and click "Delete".

## Slash Commands

* `/tgm` - Toggle the manager window.
* `/tgm import` - Import existing gear sets from the WoW API (useful if you've used other manager addons).

## Contributions

Open to suggestions, bug reports, and pull requests via issues or PRs.
