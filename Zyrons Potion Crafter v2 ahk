
#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode "Mouse", "Screen"

global toggle := false
global addX := 0, addY := 0
global craftX := 0, craftY := 0

; ===== GUI =====
gui1 := Gui("+AlwaysOnTop", "zyrons AWESOME heavenly crafter")
gui1.BackColor := "1E1E2E"

gui1.SetFont("s12 cFFFFFF", "Segoe UI")
gui1.AddText("x20 y10 w260 Center", "Heavenly Crafter")

gui1.SetFont("s10 cFFFFFF", "Segoe UI")

btnAdd := gui1.AddButton("x20 y50 w260 h30", "Set Add Everything (F7)")
btnCraft := gui1.AddButton("x20 y90 w260 h30", "Set Craft (F8)")
btnToggle := gui1.AddButton("x20 y140 w260 h40", "START / STOP (F6)")

statusText := gui1.AddText("x20 y200 w260 Center cAAAAFF", "Status: Idle")

gui1.Show("w300 h240")

; ===== EVENTS =====
btnAdd.OnEvent("Click", SetAdd)
btnCraft.OnEvent("Click", SetCraft)
btnToggle.OnEvent("Click", ToggleBot)

F7::SetAdd()
F8::SetCraft()
F6::ToggleBot()

; ===== FUNCTIONS =====
SetAdd(*) {
    global addX, addY, statusText
    MouseGetPos &addX, &addY
    statusText.Value := "Add position saved"
}

SetCraft(*) {
    global craftX, craftY, statusText
    MouseGetPos &craftX, &craftY
    statusText.Value := "Craft position saved"
}

ToggleBot(*) {
    global toggle, addX, craftX, statusText

    if (addX = 0 || craftX = 0) {
        MsgBox("Set both positions first (F7 and F8)")
        return
    }

    toggle := !toggle

    if (toggle) {
        statusText.Value := "Status: Running"
        SetTimer(CraftLoop, 50)
    } else {
        statusText.Value := "Status: Stopped"
        SetTimer(CraftLoop, 0)
    }
}

CraftLoop() {
    global addX, addY, craftX, craftY

    MouseMove addX, addY, 0
    Click
    Sleep 120

    MouseMove craftX, craftY, 0
    Click
    Sleep 300
}
