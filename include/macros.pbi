; macros
;{ array
Macro DeleteArrayElement(ar, el)
    
    For a=el To ArraySize(ar())-1
        ar(a) = ar(a+1)
    Next
    
    a = 0
    If ArraySize(ar())-1>=0
        a = ArraySize(ar())-1    
    EndIf
    ReDim ar(a)
    
EndMacro
Macro InsertArrayElement(ar, el)
  
  a = ArraySize(ar())+1    
  ReDim ar(a)
  
  For a=ArraySize(ar())-1 To el Step -1
    ar(a+1) = ar(a)
  Next
    
EndMacro
;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; Folding = -
; EnableXP