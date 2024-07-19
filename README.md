# ky-dvall
---

# KY-DVALL Script for QBCore

## Overview

This is a DV (Delete Vehicle) script for QBCore framework. The script includes exclusion zones where vehicles will not be deleted and provides two commands: `/dvauto` for automatic deletion and a DV timer. The only dependency required for this script is `qb-core`.

## Features

- **Exclusion Zones**: Define areas where vehicles should not be deleted.
- **Commands**:
  - `/dvauto`: Automatically delete vehicles.
  -  Set a timer for automatic vehicle deletion in the config.lua.

## Dependencies

- [QBCore Framework](https://github.com/qbcore-framework/qb-core)

## Installation

1. Clone or download the repository and place it in the `resources` folder of your QBCore server.

    ```bash
    git clone https://github.com/yourusername/yourrepository.git
    ```

2. Ensure `qb-core` is included in your server's resources.

3. Add the script to your server configuration file (e.g., `server.cfg`).

    ```plaintext
    ensure ky-dvscript
    ```

## Configuration

1. Open the `config.lua` file to configure exclusion zones and timer settings.

2. Customize the exclusion zones and timer settings as per your requirements.

## Usage

- **/dvauto**: Use this command to automatically delete vehicles. 

    ```plaintext
    /dvauto
    ```

- **dv timer**: Set a timer for automatic vehicle deletion. The timer is configured in the `config.lua` file.

## Support

If you encounter any issues or have any questions, feel free to open an issue on the [GitHub repository](https://github.com/yourusername/yourrepository/issues).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

Feel free to customize this README further according to your specific needs and details.
