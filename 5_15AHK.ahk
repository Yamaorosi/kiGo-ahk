#Requires AutoHotkey v2.0
InstallKeybdHook() ; キー判定の精度を上げるために追加

; --- Mouse Control (JIS) ---
; Movement Mapping (Finalized):
; SC01B: Up, SC02B & SC073: Down, SC028: Left, SC01C: Right
; SC01A: Up-Left, SC136: Down-Right, SC035: Down-Left
; Wheel: SC00D: Up, SC07D: Down
; Clicks: SC11D: Left, SC00E: Right

global m_Up := 0, m_Down1 := 0, m_Down2 := 0, m_Left := 0, m_Right := 0
global m_UL := 0, m_UR := 0, m_DL := 0, m_DR := 0
SetTimer(UpdateMouse, 10)

UpdateMouse() {
    static m_Speed := 2
    
    ; Determine vector from specific keys
    vx := (m_Right + m_DR) - (m_Left + m_UL + m_DL)
    vy := (m_Down1 + m_Down2 + m_DR + m_DL) - (m_Up + m_UL)

    if (vx != 0 || vy != 0) {
        ; Use Left Shift for precision mode
        s := GetKeyState("LShift", "P") ? 1 : m_Speed
        
        ; Normalize for diagonal movement
        if (vx != 0 && vy != 0) {
            dx := (vx > 0 ? 1 : -1) * s * 0.7071
            dy := (vy > 0 ? 1 : -1) * s * 0.7071
        } else {
            dx := (vx > 0 ? 1 : (vx < 0 ? -1 : 0)) * s
            dy := (vy > 0 ? 1 : (vy < 0 ? -1 : 0)) * s
        }
        
        MouseMove(dx, dy, 0, "R")
        if (m_Speed < 25)
            m_Speed += 0.5
    } else {
        m_Speed := 2
    }
}

; Movement Keys
*sc01b:: global m_Up := 1    ; [ (Up)
*sc01b up:: global m_Up := 0
*sc02b:: global m_Down1 := 1 ; ] (Down 1)
*sc02b up:: global m_Down1 := 0
*sc073:: global m_Down2 := 1 ; \ (Down 2)
*sc073 up:: global m_Down2 := 0
*sc028:: global m_Left := 1  ; : (Left)
*sc028 up:: global m_Left := 0
*sc01c:: global m_Right := 1 ; Enter (Right)
*sc01c up:: global m_Right := 0
*sc01a:: global m_UL := 1    ; @ (Up-Left)
*sc01a up:: global m_UL := 0
*RShift::
*sc136:: global m_DR := 1    ; Right Shift / sc136 (Down-Right)
*RShift up::
*sc136 up:: global m_DR := 0
*sc035:: global m_DL := 1    ; / (Down-Left)
*sc035 up:: global m_DL := 0

; Wheel Keys
*sc00d:: Click "WheelUp"      ; ^
*sc07d:: Click "WheelDown"    ; ¥

; Click Keys
global m_Dragging := 0

ReleaseDrag() {
    global m_Dragging
    if (m_Dragging) {
        Click "Up Left"
        m_Dragging := 0
        ToolTip ""
    }
}

*sc11d:: {
    ReleaseDrag()
    Click "Down Left"    ; RCtrl (Left Click)
}
*sc11d up:: Click "Up Left"

*sc00e:: Click "Down Right"   ; BS (Right Click)
*sc00e up:: Click "Up Right"

; Drag Toggle
*sc00c:: {
    global m_Dragging
    if (m_Dragging) {
        ReleaseDrag()
    } else {
        Click "Down Left"
        m_Dragging := 1
        ToolTip "Dragging..."
    }
}

; BackSpace & Enter Re-assignment (JIS)
*sc07b:: Send "{BackSpace}"   ; 無変換 (BS)
*sc079:: Send "{Enter}"       ; 変換 (Enter)
