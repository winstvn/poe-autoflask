#IfWinActive Path of Exile
#SingleInstance force
#NoEnv  
#Warn  
#Persistent 

pot_bar_col := "0x99D7F9"
Hotkey, RButton, Off


random_sleep()
{
	random, delay, 57, 114
	sleep %delay%
	return
}

~F1::
{
	Hotkey, RButton, Toggle
}

XButton2::
{
	Hotkey, RButton, On
	return
}

XButton1::
{
	Hotkey, RButton, Off
	return
}

; much of this is hardcoded, but I will be updating it for better scalability.
~RButton::
{
	while(GetKeyState("RButton", "P"))
	{
		PixelGetColor, flask1_col, 315, 1075
		PixelGetColor, flask2_col, 360, 1075
		PixelGetColor, flask3_col, 405, 1075
		PixelGetColor, flask4_col, 450, 1075

		if (flask1_col != pot_bar_col)
			send 1
			random_sleep()

		if (flask2_col != pot_bar_col)
			send 2
			random_sleep()

		if (flask3_col != pot_bar_col)
			send 3
			random_sleep()

		if (flask4_col != pot_bar_col)
		{
			send 4
			random_sleep()
		}

		sleep 200
	}
	return
}