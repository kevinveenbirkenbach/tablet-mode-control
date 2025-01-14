# Tablet Mode Control

This repository provides a solution for detecting tablet mode functionality on Linux devices, particularly designed for **Manjaro GNOME** running on the **HP Spectre x360**. The included scripts monitor input events to detect when the device enters or exits tablet mode and toggle the virtual keyboard accordingly. While specifically tailored for the HP Spectre x360, it may also work on other hardware configurations.

## Features
- Detects tablet mode using input event devices.
- Automatically enables/disables the GNOME virtual keyboard based on tablet mode.
- Includes a setup script for easy installation and autostart integration.
- Uninstallation script to clean up the setup if no longer needed.

## Getting Started
### Prerequisites
- A Linux distribution running **GNOME**, such as [Manjaro GNOME](https://manjaro.org/downloads/gnome/).
- A convertible laptop or device supporting tablet mode, such as the [HP Spectre x360](https://www.hp.com/us-en/shop/tech-takes/hp-spectre-x360-2-in-1-review).

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/kevinveenbirkenbach/tablet-mode-control.git
   cd tablet-mode-control
   ```
2. Run the setup script:
   ```bash
   ./setup.sh
   ```
3. Restart your system or log out and back in to activate the autostart functionality.

### Uninstallation
1. Run the uninstall script:
   ```bash
   ./uninstall.sh
   ```

## How It Works
The script detects tablet mode events via the `/dev/input/event*` devices using `evtest`. When the mode switches:
- **Tablet Mode Activated**: The GNOME virtual keyboard is enabled.
- **Tablet Mode Deactivated**: The GNOME virtual keyboard is disabled.

## License
This project is licensed under the [GNU Affero General Public License v3](./LICENSE).

## Credits
This tool was developed by [Kevin Veen-Birkenbach](https://cybermaster.space/) and generated with the assistance of [ChatGPT](https://openai.com/). View the original conversation [here](https://chatgpt.com/share/67864b6e-1bf8-800f-a372-be919c1fb09c).

## Disclaimer
While designed for **Manjaro GNOME** and **HP Spectre x360**, it may function on other Linux distributions and hardware configurations with minor modifications. Compatibility is not guaranteed.

For additional details or issues, feel free to reach out or contribute to the project.