; declaration
Declare CHG_Doc_reset()
Declare CHG_Doc_Save(filename$=#Empty$, saveas=0)
Declare CHG_Doc_Load(filename$=#Empty$)
Declare.s CHG_Doc_SaveImage(Filename$=#Empty$, automatic=1,index$="")

; gadgets
Declare CHG_UpdatePartlist()
Declare CHG_UpdateCanvasImageObject()

; template 
Declare CHG_OpenObjectCenter()
Declare CHG_PreLoadTemplatesBank()
; center
Declare CHG_SaveObjectCenter()
; character
Declare CHG_SetCharacterPropFromTemplate()
Declare CHG_SortCharacter()
Declare CHG_SetCharacterPartImage(mode=0,miror=0,obj$="",filename$="")
Declare CHG_SetObjetCenter(partId)
Declare CHG_SetCharacterColor()
Declare CHG_SetCharacterPartColorImage(part_id)

Declare.a CHG_GetCHG_ObjIDIsOk()

; window main
Declare WindowCharacterEditor_updatecanvas()

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 5
; EnableXP