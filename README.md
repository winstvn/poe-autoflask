# poe-autoflask
AutoHotKey script for autoflask utility in Path of Exile.

<p align="center">
  <img src="https://media.giphy.com/media/TLfssGIcO8dqMGFaWt/giphy.gif">
</p>

*Disclaimer: As with any script, use this at your own risk! The script is generally safe as long as you use the default delay values.* 

Features
----
- Unlike some other autoflasking scripts, this one does not require you to input the flask durations.
- Only activates during combat and ensures 100% flask uptime during mapping.
- Emulates human behaviour with random delay times.

How does it work?
---
This script uses the `PixelGetColor` command to scan the bottom left region of your screen to detect when your flask effects have worn out. It will automatically activate your flasks if the yellow bar runs out and you are in combat.

How do I run it?
----
Download and install AutoHotKey from here: https://www.autohotkey.com/ (current version or V2 Alpha will work)  
Then, clone or download the ahk file from this repo and run `autoflask.ahk`.

OR

*Note: You will not be able to make any configurations to keybinds if you go with this option.*  
Download the precompiled executable to run the script without installing AutoHotKey.  


Configurations
---
tbd

TODO
---
- Add user configurability (GUI? Nah. Unless... aha)
- Automatic activation of hp flask when low life threshold is reached.

