# StormRam Door Opener Script

This is a simple script for using the **StormRam** item to break open locked doors in your server. The script leverages the **ox_lib**, **ox_doorlock**, **ox_inventory**, and **ox_target** dependencies to function properly. It allows players to interact with doors and unlock them by using the StormRam item when they look at the door.

## Features
- Use the **StormRam** item to break open locked doors.
- Integration with **ox_lib**, **ox_doorlock**, **ox_inventory**, and **ox_target**.
- Easy-to-use script for door interaction.

## Requirements
Before using this script, you need to ensure that the following dependencies are installed and working:

- [**ox_lib**]([https://github.com/YourLinkHere](https://github.com/overextended/ox_lib))
- [**ox_doorlock**]([https://github.com/YourLinkHere](https://github.com/overextended/ox_doorlock))
- [**ox_inventory**]([https://github.com/YourLinkHere](https://github.com/overextended/ox_inventory))
- [**ox_target**]([https://github.com/YourLinkHere](https://github.com/overextended/ox_target))

## Installation

1. Download or clone this repository to your server's resource folder.
2. Ensure that **ox_lib**, **ox_doorlock**, **ox_inventory**, and **ox_target** are installed and properly configured on your server.
3. Add the following lines to your `server.cfg` to ensure the script is loaded:

```plaintext
ensure ox_lib
ensure ox_doorlock
ensure ox_inventory
ensure ox_target
ensure howsn_stormram
```

4. Restart your server.

## Adding the StormRam Item to **ox_inventory**

To ensure the **StormRam** item works with your server, you'll need to add it to **ox_inventory**. Add the following code to your `ox_inventory` configuration file:

```lua
["police_stormram"] = {
    label = "Stormram",
    weight = 18000,
    stack = true,
    close = true,
    description = "Knock knock!",
    client = {
        image = "police_stormram.png",
    }
},
```

Make sure the `police_stormram.png` image is available in your inventory images folder.

## Usage

1. Equip the **StormRam** item in your inventory.
2. Look at a locked door that is supported by **ox_doorlock**.
3. Use the **ox_target** system to interact with the door while having the **StormRam** in your inventory. The door will unlock and open.

## Configuration

This script comes with basic functionality and should work out-of-the-box, but if you'd like to make modifications, you can do so by editing the script's code directly.

## License

This script is open-source and available under the MIT License.
