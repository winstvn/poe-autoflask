; Directives
;#IfWinActive Path of Exile
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
flasks := {1:1, 2:2, 3:3, 4:4}
toggle_key := "F8" ; key to toggle script on/off
attack_key := "RButton" ; key binded to your primary attack
; ----------------------------------------------------

; initialize default variables
flask_origin_x := 316 ; x-origin of flask bar
flask_origin_y := 1075 ; y-origin of flask bar
delay_lower := 57 ; lower bound of sleep duration
delay_upper := 114 ; upper bound of sleep duration
tooltip_duration := 500 ; how long to keep tooltip up
flask_dur_col := "0x99D7F9" ; this is the BRG of yellow

; assign hotkeys to labels
Hotkey ~%toggle_key%, toggle_flasking
Hotkey ~%attack_key%, attack
Hotkey ~%attack_key% up, attack_up
Return

; toggle flasking behaviour
toggle_flasking:
ToolTip, % "Autoflask " ((flasking := !flasking) ? "enabled" : "disabled")
SetTimer, remove_tooltip, -%tooltip_duration%
Return

; attack button hotkey
attack:
attack_up:
if (!flasking and !looping) {
	Return
} 
SetTimer, flask_timer, % (looping := !looping) ? 1 : "Off"
Return

; flasking subroutine
flask_timer:
for flask_pos, bbutton in flasks {
	If ((flask_pos < 1) or (flask_pos > 5) or !flasking) {
		Continue
	}

	new_x := flask_origin_x + 45 * (flask_pos - 1)
	PixelGetColor, flask_col, %new_x%, %flask_origin_y%

	If (flask_col != flask_dur_col) {
		send %bbutton%
		Random, delay, delay_lower, delay_upper
		sleep %delay%
	}
}
Return

; clear any existing tooltips
remove_tooltip:
ToolTip
Return
