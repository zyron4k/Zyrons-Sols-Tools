
; ============================================
; ZYRONS ULTIMATE + WEBHOOK EDITION (V1)
; ============================================

#SingleInstance Force
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

; ===== SETTINGS =====
webhookURL := "PASTE_YOUR_WEBHOOK_HERE"

; ===== GLOBALS =====
toggle := false
addX := 0
addY := 0
craftX := 0
craftY := 0
speed := 200

; ===== WEBHOOK FUNCTION =====
SendWebhook(msg) {
    global webhookURL
    if (webhookURL = "PASTE_YOUR_WEBHOOK_HERE")
        return

    json := "{""content"": """ msg """}"
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("POST", webhookURL, false)
    whr.SetRequestHeader("Content-Type", "application/json")
    whr.Send(json)
}

; ===== GUI =====
Gui, +AlwaysOnTop
Gui, Color, 140A2E
Gui, Font, s12 cFFD700 Bold, Segoe UI
Gui, Add, Text, x20 y10 w500 Center, ZYRONS ULTIMATE WEBHOOK

Gui, Add, Tab2, x10 y40 w520 h420, Main|Craft|Webhook|Config

; MAIN
Gui, Tab, 1
Gui, Font, s10 cFFFFFF
Gui, Add, Button, x40 y80 w200 h50 gStartBot, START (F6)
Gui, Add, Button, x280 y80 w200 h50 gStopBot, STOP (F7)
Gui, Add, Text, x40 y150 w440 vStatus, Status: Idle

; CRAFT
Gui, Tab, 2
Gui, Add, Button, x40 y80 w200 h40 gSetAdd, Set Add (F8)
Gui, Add, Button, x280 y80 w200 h40 gSetCraft, Set Craft (F9)
Gui, Add, Button, x40 y140 w440 h40 gTestRun, Test Run

; WEBHOOK TAB
Gui, Tab, 3
Gui, Add, Text, x40 y80 w440, Send alerts when crafting runs
Gui, Add, Button, x40 y120 w200 h40 gTestWebhook, Test Webhook
Gui, Add, Button, x280 y120 w200 h40 gToggleAlerts, Toggle Alerts

; CONFIG
Gui, Tab, 4
Gui, Add, Text, x40 y80, Speed
Gui, Add, Edit, x120 y75 w100 vSpeedBox, 200
Gui, Add, Button, x240 y75 w120 h30 gApplySpeed, Apply

Gui, Show, w540 h460
return

; ===== HOTKEYS =====
F6::Gosub, StartBot
F7::Gosub, StopBot
F8::Gosub, SetAdd
F9::Gosub, SetCraft
ESC::ExitApp

alerts := true

ToggleAlerts:
alerts := !alerts
return

TestWebhook:
SendWebhook("Webhook working from Zyrons Tool")
return

; ===== CORE =====

StartBot:
if (addX=0 || craftX=0) {
    MsgBox, Set positions first!
    return
}
toggle := true
GuiControl,, Status, Running
SendWebhook("🟢 Macro Started")
SetTimer, CraftLoop, %speed%
return

StopBot:
toggle := false
SetTimer, CraftLoop, Off
GuiControl,, Status, Stopped
SendWebhook("🔴 Macro Stopped")
return

CraftLoop:
Random, d1, 80, 150
Random, d2, 200, 400

MouseMove, %addX%, %addY%
Click
Sleep, %d1%

MouseMove, %craftX%, %craftY%
Click
Sleep, %d2%

if (alerts) {
    SendWebhook("⚡ Craft cycle completed")
}
return

; ===== SETUP =====

SetAdd:
MouseGetPos, addX, addY
GuiControl,, Status, Add Set
return

SetCraft:
MouseGetPos, craftX, craftY
GuiControl,, Status, Craft Set
return

TestRun:
MouseMove, %addX%, %addY%
Click
Sleep, 120
MouseMove, %craftX%, %craftY%
Click
SendWebhook("🧪 Test Run Executed")
return

ApplySpeed:
Gui, Submit, NoHide
speed := SpeedBox
return

GuiClose:
ExitApp
