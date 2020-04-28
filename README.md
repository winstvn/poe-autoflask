# poe-autoflask
Simple and lightweight AutoHotKey script for autoflask utility in Path of Exile.

<p align="center">
  <img src="https://media.giphy.com/media/TLfssGIcO8dqMGFaWt/giphy.gif">
</p>

*Disclaimer: As with any script, use this at your own risk! The script is generally safe as long as you use the default delay values.* 

Features
----
- Automatically activates your flasks for you so that you can maximize your flask uptime without having to worry about getting carpal tunnel syndrome.
- Unlike some other autoflasking scripts, this one does not require you to tediously input your flask durations; thus, further reducing your chances of developing carpal tunnel syndrome.
- Only activates during combat and ensures 100% flask uptime during mapping.
- Emulates human behaviour with random delay times.

How does it work?
---
This script uses the `PixelGetColor` command to scan the bottom left region of your screen to detect when your flask effects have worn out. It will automatically reactivate your flasks if the duration bar runs out and you are in combat.

How do I run it?
----
Download and install the current version of AutoHotKey from [their website.](https://www.autohotkey.com/)  
Then, clone or download the `autoflask.ahk` file from this repo and run.

OR

*Note: You will not be able to make any configurations to keybinds if you go with this option.*  
Download the precompiled executable `autoflask.exe` to run the script without installing AutoHotKey.  


Configurations
---
**Default Keybinds:**
| Function       | Keybind              |
|----------------|----------------------|
| F2             | Toggle Script On/Off |
| Right Click    | Primary Attack       |
| Flask 1        | 1                    |
| Flask 2        | 2                    |
| Flask 3        | 3                    |
| Flask 4        | 4                    |

*I'd recommend binding the toggle key to something easily accessible so that you can quickly toggle autoflasking on/off in tense situations.*

**Flask Keymap:**  
You can configure the autoflask keybinds in line 24-26 of the AHK script.  
Configuring the keymap for flasks are a bit more tricky, but see the example below:

![Imgur](https://i.imgur.com/bCyTtC5.png)

In the above image, my offense/defense flasks are in slots 1, 2, 3, 4 with their corresponding keybinds as 1, 2, 3, 4. Thus, I would in line 24 of the script, I would write: `flasks := {1:1, 2:2, 3:3, 4:4}`.  
The structure of the keymap configuration follows `flask := {[slot]:[button], ...}` where slot is the slot number from 1-5 and button is the corresponding button to activate.  

*Note: if you have a non-numerical input key, it must be wrapped in quotation marks, like `"F1"` or `"v"`. Some special keys like spacebar must be wrapping in curly braces as well `"{Space}"`.*

This is the current method for configuring the keymap until I complete a GUI.

TODO
---
- ~~Add user configurability~~ ✅
- ~~Further performance improvements~~ ✅
- Automatic activation of hp flask when low life threshold is reached. **WIP**
- GUI? Nah... Unless? aha 🤫

