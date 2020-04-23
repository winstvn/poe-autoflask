# poe-autoflask
Simple and lightweight AutoHotKey script for autoflask utility in Path of Exile.

<p align="center">
  <img src="https://media.giphy.com/media/TLfssGIcO8dqMGFaWt/giphy.gif">
</p>

*Disclaimer: As with any script, use this at your own risk! The script is generally safe as long as you use the default delay values.* 

Features
----
- Automatically activates your flasks for you so that you can maximize your flask uptime without having to worry about getting carpal tunnel syndrome.
- Unlike some other autoflasking scripts, this one does not require you to tediously input your flask durations.
- Only activates during combat and ensures 100% flask uptime during mapping.
- Emulates human behaviour with random delay times.

How does it work?
---
This script uses the `PixelGetColor` command to scan the bottom left region of your screen to detect when your flask effects have worn out. It will automatically reactivate your flasks if the duration bar runs out and you are in combat.

How do I run it?
----
Download and install AutoHotKey from [their website.](https://www.autohotkey.com/)  (current version or V2 Alpha will work)  
Then, clone or download the ahk file from this repo and run `autoflask.ahk`.

OR

*Note: You will not be able to make any configurations to keybinds if you go with this option.*  
Download the precompiled executable `autoflask.exe` to run the script without installing AutoHotKey.  


Configurations
---
*To be updated.*  
| Function       | Keybind              |
|----------------|----------------------|
| F1             | Toggle Script On/Off |
| Right Click    | Primary Attack       |
| Flask 1        | 1                    |
| Flask 2        | 2                    |
| Flask 3        | 3                    |
| Flask 4        | 4                    |

These are just my keybinds. Feel free to change them to whatever you prefer.  
This will probably change in the future.


TODO
---
- Add user configurability **WIP**
  - GUI? Nah... Unless? aha 🤫
- Automatic activation of hp flask when low life threshold is reached.

