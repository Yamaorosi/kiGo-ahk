#Requires AutoHotkey v2.0

; --- 関数定義 ---
SinglePress(lastkey, sendkey) {
    KeyWait lastkey
    if (A_PriorKey = lastkey) {
        Send sendkey
    }
}

; --- Space Layers ---
Space:: SinglePress("Space", "{Space}")

Space & 1::Send "``"
Space & 2::Send "@"
Space & 3::Send "{#}"
Space & 4::Send "$"
Space & 5::Send "%"
Space & 6::Send '&'
Space & 7::Send "'"
Space & 8::Send "{^}"
Space & 9::Send "|"
Space & 0::Send "\"
Space & q::Send "{{}"
Space & w::Send "["
Space & e::Send "("
Space & r::Send "<"
Space & t::Send '>'
Space & y::Send('{Blind}{Up}')
Space & u::Send '"'
Space & i::Send ")"
Space & o::Send "]"
Space & p::Send "{}}"
Space & a::Send "*"
Space & s::Send "{+}"
Space & d::Send "="
Space & f::Send "/"
Space & g::Send('{Blind}{Left}')
Space & h::Send('{Blind}{Down}')
Space & j::Send('{Blind}{Right}')
Space & k::Send ";"
Space & l::Send ":"
Space & SC027::Send "_"
+SC027::Send "~" ; SHIFT + SC027 for Tilde (approximate based on user's hint)
SC027::-
Space & z::Send("笑")
Space & x::Send('{Blind}{F10}')
Space & c::{
    Send('{Home}')
    Send('+{End}')
}
Space & v::Send "" ; Free
Space & b::Send('{Blind}{Home}')
Space & n::Send('{Blind}{End}')
Space & m::Send('{F10}{Enter}')
Space & SC033::Send "{!}"
Space & SC034::Send "{?}"