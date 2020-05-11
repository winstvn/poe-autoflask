#IfWinActive Path of Exile
#Persistent
#NoEnv
#SingleInstance force
#MaxHotkeysPerInterval 32767
#HotkeyInterval 32767
#KeyHistory 0
ListLines Off
Process, Priority, , L
SetBatchLines, -1
SetKeyDelay, -1, 25
SetMouseDelay, -1
SetWinDelay, -1
SetControlDelay, -1
SendMode Input

; USER CONFIGURATION
; ----------------------------------------------------
; Keybinds
; See https://www.autohotkey.com/docs/KeyList.htm for full list of accepted keys
; map your flasks {k:v, ..} where k your flask position and v is
; the key associated with the flask.
flasks := {1:1, 2:2, 3:3, 4:4, 5:"{Space}"}
hp_flask := 5 ; hp flask position
hp_threshold := 30 ; percentage of life left at which to trigger hp flask
toggle_key := "F2" ; key to toggle autoflask script on/off
hp_toggle_key := "F3" ; key to toggle hp autoflask script on/off
hp_calibrate_key := "F4" ; calibrate the color of hp bar
attack_key := "RButton" ; key binded to your primary attack
; ----------------------------------------------------

; initialize default variables
flask_origin_x := 316 ; x-origin of flask bar
flask_origin_y := 1075 ; y-origin of flask bar
hp_bar_full := [120, 872] ; coords of full hp bar
hp_bar_empty := [120, 1072] ; coords of empty hp bar
delay_lower := 57 ; lower bound of sleep duration
delay_upper := 114 ; upper bound of sleep duration
tooltip_duration := 500 ; how long to keep tooltip up
flask_dur_col := "0x99D7F9" ; this is the BRG of yellow
hp_calibrated := False ; hp calibration flag

; load default values from config file if not done yet
config := "config.ini"

If !FileExist(config) {
	IniWrite, %hp_flask%, %config%, user_config, hp_flask
	IniWrite, %hp_threshold%, %config%, user_config, hp_threshold
	IniWrite, %toggle_key%, %config%, user_config, toggle_key
	IniWrite, %hp_toggle_key%, %config%, user_config, hp_toggle_key
	IniWrite, %hp_calibrate_key%, %config%, user_config, hp_calibrate_key
	IniWrite, %attack_key%, %config%, user_config, attack_key

	for k, v in flasks
		IniWrite, %v%, %config%, flasks, %k%

} Else If FileExist(config) {
	IniRead, hp_flask, %config%, user_config, hp_flask, %hp_flask%
	IniRead, hp_threshold, %config%, user_config, hp_threshold, %hp_threshold%
	IniRead, toggle_key, %config%, user_config, toggle_key, %toggle_key%
	IniRead, hp_toggle_key, %config%, user_config, hp_toggle_key, %hp_toggle_key%
	IniRead, hp_calibrate_key, %config%, user_config, hp_calibrate_key, %hp_calibrate_key%
	IniRead, attack_key, %config%, user_config, attack_key, %attack_key%
	IniRead, hp_calibrated, %config%, auto_hp, hp_calibrated, False
	IniRead, hp_threshold_col, %config%, auto_hp, hp_threshold_col

	IniRead, flask_str, config.ini, flasks
	flasks := {}
	Loop, Parse, flask_str, `n 
	{
		arr := StrSplit(A_LoopField, "=")
		flasks[arr[1]] := arr[2]
	}
}

; assign hotkeys to labels
Hotkey %hp_toggle_key%, toggle_hp
Hotkey %hp_calibrate_key%, calibrate_hp
Hotkey %toggle_key%, toggle_flasking
Hotkey ~%attack_key%, attack
Hotkey ~%attack_key% up, attack_up
Return

; toggle hp flasking
toggle_hp:
If !hp_calibrated {
	ToolTip, AutoHP not calibrated yet! Press %hp_calibrate_key% to calibrate.
	SetTimer, remove_tooltip, -1500
	Return
} Else {
	ToolTip, % "HP Autoflask " ((hp_flasking := !hp_flasking) ? "enabled" : "disabled")
	SetTimer, remove_tooltip, -%tooltip_duration%
	SetTimer, hp_timer, % (hp_flasking) ? 100 : "Off"
	Return
}

; calibrate the color of the hp bar color at the threshold pixel
calibrate_hp:
	ToolTip, Calibrated Life Bar!
	SetTimer, remove_tooltip, -%tooltip_duration%

	; quick maffs to calculate the coordinates of hp threshold
	hp_threshold_x := hp_bar_empty[1]
	hp_threshold_y := hp_bar_empty[2] - Ceil((hp_bar_empty[2] - hp_bar_full[2]) * hp_threshold / 100)
	
	PixelGetColor, hp_threshold_col, hp_threshold_x, hp_threshold_y
	hp_calibrated := True

	IniWrite, %hp_threshold_col%, config.ini, auto_hp, hp_threshold_col
	IniWrite, %hp_calibrated%, config.ini, auto_hp, hp_calibrated
	return

; toggle flasking behaviour
toggle_flasking:
ToolTip, % "Autoflask " ((flasking := !flasking) ? "enabled" : "disabled")
SetTimer, remove_tooltip, -%tooltip_duration%
Return

; attack button hotkey
attack:
attack_up:
If (!flasking and !looping) {
	Return
} Else {
	SetTimer, flask_timer, % (looping := !looping) ? 1 : "Off"
	Return
} 

; autoflasking subroutine
flask_timer:
For flask_pos, bbutton in flasks {
	If ((flask_pos < 1) or (flask_pos > 5) or (flask_pos == hp_flask) or !flasking) {
		Continue
	} Else {
		new_x := flask_origin_x + 45 * (flask_pos - 1)
		PixelGetColor, flask_col, %new_x%, %flask_origin_y%

		If (flask_col != flask_dur_col) {
			send %bbutton%
			Random, delay, delay_lower, delay_upper
			sleep %delay%
		}
	}
}
Return

; hp autoflask subroutine
hp_timer:
PixelGetColor, hp_col, %hp_threshold_x%, %hp_threshold_y%

If (hp_col != hp_threshold_col)	{
	hp_key := flasks[hp_flask]
	send %hp_key%
}
Return

; clear any existing tooltips
remove_tooltip:
ToolTip
Return
