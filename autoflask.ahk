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
; See https://www.autohotkey.com/docs/KeyList.htm for full list of keys
; flasks {k:v, ..} where k your flask position and v is
; the key associated with the flask.
flasks := {6:1, 2:2, 3:3, 4:4, 5:"{Space}"}
hp_flask := 5 ; hp flask position
hp_threshold := 30 ; percentage of life left at which to trigger hp flask
toggle_key := "F8" ; key to toggle autoflask script on/off
hp_toggle_key := "F9" ; key to toggle hp autoflask script on/off
hp_calibrate_key := "F10" ; calibrate the color of hp bar
attack_key := "RButton" ; key binded to your primary attack
; ----------------------------------------------------

; should not change these values
flask_origin_x := 316 ; x-origin of flask bar
flask_origin_y := 1075 ; y-origin of flask bar
hp_bar_top := [121, 872] ; coordinates for top of hp bar
hp_bar_bottom :=  [121, 1072] ; coordinates for bottom of hp bar
delay_lower := 57 ; lower bound of sleep duration
delay_upper := 114 ; upper bound of sleep duration
tooltip_duration := 500 ; how long to keep tooltip up

Hotkey %hp_toggle_key%, toggle_hp
Hotkey %hp_calibrate_key%, calibrate_hp
Hotkey %toggle_key%, toggle_flasking
Hotkey ~%attack_key%, attack
Hotkey ~%attack_key% up, attack_up

flask_dur_col := "0x99D7F9" ; this is the BRG of yellow
flasking := True ; initialize flasking behaviour
hp_flasking := True ; initialize hp flask behaviour
hp_calibrated := True ; flag for hp calibration

toggle_hp:
{
	if !hp_calibrated {
		ToolTip, HP not calibrated yet! Press %hp_calibrate_key% to calibrate.)
		SetTimer, remove_tooltip, -1000
		return
	}

	ToolTip, % "HP Autoflask " ((hp_flasking := !hp_flasking) ? "enabled" : "disabled")
	SetTimer, remove_tooltip, -%tooltip_duration%
	If hp_flasking
	{
		SetTimer, hp_timer, -1
	}
	Else
	{
		SetTimer, hp_timer, Off
	}
	return
}

calibrate_hp:
{
	ToolTip, Calibrating Life Bar...
	SetTimer, remove_tooltip, -%tooltip_duration%

	hp_calibrated := True

	; quick maffs to calculate the coordinates of hp threshold
	hp_threshold_x := hp_bar_bottom[1]
	hp_threshold_y := Ceil((hp_bar_bottom[2] - hp_bar_top[2]) * hp_threshold / 100) - hp_bar_bottom[2]
	
	PixelGetColor, hp_threshold_col, hp_threshold_x, hp_threshold_y
	return
}

toggle_flasking:
{
	ToolTip, % "Autoflask " ((flasking := !flasking) ? "enabled" : "disabled")
	SetTimer, remove_tooltip, -%tooltip_duration%
	return
}

; autoflask
attack:
attack_up:
{
	If (!flasking and !looping)
		return 

; start flask_timer subroutine when attacking
	SetTimer, flask_timer, % (looping := !looping) ? 1 : "Off"
	return
}

flask_timer:
{
	; check each flask to determine if they need to be activated
	for flask_pos, bbutton in flasks
	{
		If ((flask_pos < 0) or (flask_pos > 5) or (flask_pos == hp_flask))
			Continue
		
		new_x := flask_origin_x+45*(flask_pos-1)
        PixelGetColor, flask_col, new_x, flask_origin_y

        If (flask_col != flask_dur_col) {
        	send %bbutton%
			Random, delay, delay_lower, delay_upper
			sleep %delay%
		}
	}
	return
}

hp_timer:
{
    PixelGetColor, hp_col, %hp_threshold_x%, %hp_threshold_y%
	
	If (hp_col != hp_threshold_col)	{
		hp_key := flasks[hp_flask]
		send %hp_key%
	}
}

remove_tooltip:
{
	ToolTip
	return
}