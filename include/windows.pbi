; window
  Enumeration 
  ;{ window Scene properties
  #G_winScProp_cameraId = #G_WinCHG_LAST
  #G_winScProp_cameraAdd
  #G_winScProp_cameraSave
  #G_winScProp_cameraName
  #G_winScProp_cameraW
  #G_winScProp_cameraH
  #G_winScProp_cameraX
  #G_winScProp_cameraY
  #G_winScProp_cameracropX
  #G_winScProp_cameracropY
  #G_winScProp_cameracropW
  #G_winScProp_cameracropH
  #G_winScProp_cameraZoom
  #G_winScProp_outputW
  #G_winScProp_outputH
  #G_winScProp_Pourcentage
  #G_winScProp_FormatOutput
  #G_winScProp_FormatOption
  ;}
EndEnumeration

Structure sVDCamera Extends sRect
  name$
  zoom.d
  id.w
  optionoutput.w
  crop.sRect
EndStructure
Global Dim VD_camera.sVDCamera(0), NBcamera=-1, cameraId

Procedure Addbuttons(win)
  
  w1 = WindowWidth(win)
  h1 = WindowHeight(win)
  h=30
  w=80
  ButtonGadget(#G_Win_BtnOk, w1-w-10, h1-h-5, w, h, Lang("Ok"))
  ButtonGadget(#G_Win_BtnCancel, w1-(w+10)*2, h1-h-5, w, h, Lang("Cancel"))
  
EndProcedure

Procedure DrawCanvas()
  WindowCharacterEditor_updatecanvas()
EndProcedure

; Window scene properties
;{ camera
Procedure.s VD_GetCameratext(i)
  ; to get the camera parameter in txt
  d$ =","
  With VD_camera(i)
    txt$ = "camera,"+\ID+d$+\name$+d$+\x+d$+\y+d$+\w+d$+\h+d$+\scale+d$+\zoom+d$
    txt$ +\optionoutput+d$+\crop\x+d$+\crop\y+d$+\crop\w+d$+\crop\h+d$
  EndWith
  ProcedureReturn txt$
EndProcedure
Procedure VD_ExportPresetCamera(filename$=#Empty$)
  ; export camera parameters as preset
  If filename$ =#Empty$
    filename$ = InputRequester(lang("Export"),lang("Export camera Preset"),VD_camera(CameraId)\name$)
  EndIf
  If filename$ <>#Empty$
    filename$ = ReplaceString(filename$, " ", "")
    If GetExtensionPart(filename$) <>"txt"
      filename$ = ReplaceString(filename$, "txt","")+".txt"
    EndIf
    
    If VD_GetFileExists(filename$)=0
      If CreateFile(0,"data\presets\camera\"+filename$)
        txt$ = VD_GetCameratext(cameraId)
        WriteStringN(0,txt$)
        CloseFile(0)
      EndIf
    EndIf
  EndIf
EndProcedure
;}
Procedure VD_CameraAdd(name$,x,y,w,h,scale,zoom.d)
  NBcamera+1
  i = NBcamera
  ReDim VD_camera.sVDCamera(i)
  With VD_camera(i)
    \w = w
    \h = h
    \x = x
    \y = y
    \name$ = name$
    \scale = scale
    \zoom = zoom
  EndWith
EndProcedure
Procedure VD_Camera_SetGadgetPropertie()
  With VD_camera(cameraId)
    SetGadgetText(#G_winScProp_Pourcentage, Str(\scale))
    SetGadgetText(#G_winScProp_cameraH, Str(\h))
    SetGadgetText(#G_winScProp_cameraW, Str(\w))
    SetGadgetText(#G_winScProp_cameraX, Str(\x))
    SetGadgetText(#G_winScProp_cameraY, Str(\Y))
    SetGadgetText(#G_winScProp_cameraName, \name$)
    
    finalW = \W * \scale * 0.01
    finalH = \H * \scale * 0.01
    If finalW <= 8096 And FinalH <= 8096
      SetGadgetText(#G_winScProp_outputW, Str(finalW))
      SetGadgetText(#G_winScProp_outputH, Str(finalH))
    EndIf
                
  EndWith
EndProcedure
Procedure OpenWindow_Sceneproperties()
  
  Protected x,y,w,h,folder$
  winW = 800
  WinH = 500
  If OpenWindow(#Win_CHG_Sceneproperties,0,0,Winw,winH,lang("Scene Properties","Scene properties"),#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget,WindowID(#Win_CHG_CharacterEditor))
    WindowBounds(#Win_CHG_Sceneproperties, 400, 500, winW, WinH) 
    
    ;{ check camera presets
    NBcamera = -1
    Global Dim VD_camera.sVDCamera(0)
    VD_CameraAdd(Lang("Camera Default"),CHG_Options\Camera\x,CHG_Options\Camera\y,CHG_Options\Camera\w,CHG_Options\Camera\H,100,1)
    ; check presets camera in folder
    folder$ = "data\presets\camera\"
    If ExamineDirectory(0,folder$,"*.txt")
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = #PB_DirectoryEntry_File
          If DirectoryEntrySize(0)>0 And DirectoryEntryName(0)<>""
            If ReadFile(0,folder$+DirectoryEntryName(0))
              line$ = ReadString(0)
              d$ = ","
              index$ = StringField(line$,1,d$)
              If index$ ="camera"
                u=2
                id = Val(StringField(line$,u,d$)) : u+1
                name$ = StringField(line$,u,d$) : u+1
                x = Val(StringField(line$,u,d$)) : u+1
                y = Val(StringField(line$,u,d$)) : u+1
                w = Val(StringField(line$,u,d$)) : u+1
                h = Val(StringField(line$,u,d$)) : u+1
                scale = Val(StringField(line$,u,d$)) : u+1
                zoom.d = ValD(StringField(line$,u,d$)) : u+1
                VD_CameraADd(name$,x,y,w,h,scale,zoom)
              EndIf
              CloseFile(0)
            EndIf
          EndIf
        EndIf
      Wend
      FinishDirectory(0)
    EndIf
    ;}
    
    ; create the gadgets
    x=10 : y=10 : w=120 : h=25 : a=4
    If FrameGadget(#PB_Any, x,y,250,(h+a)*9+35,lang("Camera"))
      y+25 : x=20
      AddGadget(#G_winScProp_cameraId,#Gad_Cbbox,x,y,w,h,"",0,0,lang("Select the camera"),cameraId,lang("Camera")+" :")  : y+h+a
      
      For i=0 To ArraySize(VD_camera())
        AddGadgetItem(#G_winScProp_cameraId,i,VD_camera(i)\name$)
      Next
      SetGadgetState(#G_winScProp_cameraId, cameraId)
      
      AddGadget(#G_winScProp_cameraAdd,#Gad_Btn,x,y,w,h,"+",0,0,lang("Add a new camera preset"),-65257,Lang("Add")) : y+h+a
      AddGadget(#G_winScProp_cameraSave,#Gad_Btn,x,y,w,h,lang("Save"),0,0,lang("Save the camera as preset"),-65257,Lang("Save")) : y+h+15
      
      AddGadget(#G_winScProp_cameraName,#Gad_String,x,y,w,h,VD_camera(cameraId)\name$,0,0,lang("Name of the current camera for output"),-65257,Lang("Name")) : y+h+a
      AddGadget(#G_winScProp_cameraX,#Gad_String,x,y,w,h,"",1,0,lang("X Position of the image output"),VD_camera(cameraId)\x,Lang("X")) : y+h+a
      AddGadget(#G_winScProp_cameraY,#Gad_String,x,y,w,h,"",1,0,lang("Y Position of the image output"),VD_camera(cameraId)\y,Lang("Y")) : y+h+a
      AddGadget(#G_winScProp_cameraW,#Gad_String,x,y,w,h,"",1,0,lang("Width of the image output"),VD_camera(cameraId)\w,Lang("Width")) : y+h+a
      AddGadget(#G_winScProp_cameraH,#Gad_String,x,y,w,h,"",1,0,lang("Height of the image output"),VD_camera(cameraId)\h,Lang("Height")) : y+h+a
      ; AddGadget(#G_winScProp_cameraZoom,#Gad_String,x,y,w,h,"",0,0,lang("Zoom of the image output"),VD_camera(cameraId)\zoom,Lang("Zoom")) : y+h+a
      AddGadget(#G_winScProp_Pourcentage,#Gad_String,x,y,w,h,"",0,0,lang("Pourcentage for output"),VD_camera(cameraId)\scale,Lang("%")) : y+h+a
      
    EndIf
    y+20
    x=10
    If FrameGadget(#PB_Any, x,y,250,(h+a)*2+35,lang("Output Image"))
      y+25 : x=20
      AddGadget(#G_winScProp_outputW,#Gad_String,x,y,w,h,"",2,0,lang("Width of output image"),
                (VD_camera(cameraId)\W)*VD_camera(cameraId)\scale*0.01 ,Lang("Width")) : y+h+a
      AddGadget(#G_winScProp_outputH,#Gad_String,x,y,w,h,"",2,0,lang("Height of output image"),
                (VD_camera(cameraId)\h)*VD_camera(cameraId)\scale*0.01 ,Lang("Height")) : y+h+a
    EndIf
    
    ;   #G_winScProp_cameracropX
    ;   #G_winScProp_cameracropY
    ;   #G_winScProp_cameracropW
    ;   #G_winScProp_cameracropH
    ;   #G_winScProp_FormatOutput
    ;   #G_winScProp_FormatOption
    
    
    ; Add 2 buttons
    Addbuttons(#Win_CHG_Sceneproperties)
    
    ; define some variable
    x=VD_camera(cameraId)\x
    y=VD_camera(cameraId)\y
    w=VD_camera(cameraId)\w
    h=VD_camera(cameraId)\h
    name$=VD_camera(cameraId)\name$
    scale=VD_camera(cameraId)\scale
    zoom.d=VD_camera(cameraId)\zoom
    
    Repeat
      
      Event = WindowEvent()
      EventGadget = EventGadget()
      
      Select event
        Case #PB_Event_Gadget
          gad = 0
          Select EventGadget
              
            Case #G_winScProp_cameraAdd
              VD_CameraAdd(name$,x,y,w,h,scale,zoom)
              
            Case #G_winScProp_cameraSave
              VD_ExportPresetCamera()
              
            Case #G_winScProp_cameraId
              cameraId = GetGadgetState(#G_winScProp_cameraId)
              VD_Camera_SetGadgetPropertie()
              
            Case #G_winScProp_Pourcentage
              scale = Val(GetGadgetText(#G_winScProp_Pourcentage))
              If scale >0 
                finalW = VD_camera(cameraId)\W*scale*0.01
                finalH = VD_camera(cameraId)\H*scale*0.01
                If finalW <= 8096 And FinalH <= 8096
                  VD_camera(cameraId)\scale = scale
                  SetGadgetText(#G_winScProp_outputW, Str(finalW))
                  SetGadgetText(#G_winScProp_outputH, Str(finalH))
                Else
                  MessageRequester(Lang("Info"), lang("The final size can't be > 8096x8096. The size is : "+Str(finalW)+"x"+Str(finalH)))
                EndIf
              EndIf
              
            Case #G_winScProp_cameraW
              w = Val(GetGadgetText(#G_winScProp_cameraW))
              If w >0 And w < 8096
                VD_camera(cameraId)\w = w
                chg_options\Camera\W = w
                DrawCanvas()
                SetGadgetText(#G_winScProp_outputW, Str(VD_camera(cameraId)\W*VD_camera(cameraId)\scale*0.01))
              Else
                SetGadgetText(#G_winScProp_cameraw, Str(VD_camera(cameraId)\W))
              EndIf
              
            Case #G_winScProp_cameraH
              h = Val(GetGadgetText(#G_winScProp_cameraH))
              If h >0 And h < 8096
                VD_camera(cameraId)\H = h
                chg_options\Camera\H = h
                 DrawCanvas()
                SetGadgetText(#G_winScProp_outputH, Str(VD_camera(cameraId)\H*VD_camera(cameraId)\scale*0.01))
              Else
                SetGadgetText(#G_winScProp_cameraH, Str(VD_camera(cameraId)\H))
              EndIf
              
            Case #G_winScProp_cameraX
              x = Val(GetGadgetText(#G_winScProp_cameraX))
              VD_camera(cameraId)\x = x
              chg_options\Camera\X = x
              DrawCanvas()
              
            Case #G_winScProp_cameraY
              Y = Val(GetGadgetText(#G_winScProp_cameraY))
              VD_camera(cameraId)\Y = Y
              chg_options\Camera\y = y
              DrawCanvas()
               
            Case #G_winScProp_cameraName
              name$ = GetGadgetText(#G_winScProp_cameraName)
              If name$ <> #Empty$
                VD_camera(cameraId)\name$ = name$
              EndIf
              
            Case #G_Win_BtnOk
              quit = 2
            Case #G_Win_BtnCancel
              quit = 1
          EndSelect
          
        Case #PB_Event_CloseWindow
          quit = 2
      EndSelect
      
    Until quit >= 1
    DrawCanvas()
    CloseWindow(#Win_CHG_Sceneproperties)
  EndIf
  
EndProcedure

;{ Window Infos
Procedure WindowInfos_Update(info$)
  
  Shared maininfo1$

;   If StartVectorDrawing(CanvasVectorOutput(#G_CanvasWinInfos))
;     w = GadgetWidth(#G_CanvasWinInfos)
;     h = GadgetHeight(#G_CanvasWinInfos)
;     AddPathBox(0,0,w,h)
;     VectorSourceColor(RGBA(150,150,150,255))
;     FillPath()
;     
;     ; draw the text
;     w1 = w-20
;     h1 = h-20
;     MovePathCursor(10,10)
;     ; draw main infos (exemple: "please wait....")
;     DrawVectorText(maininfo1$)
;     h2 = VectorTextHeight(maininfo1$)
;     MovePathCursor(10,20+h2)
;     ; draw paragraph of infos
;     DrawVectorParagraph(info$,w1,h1)
;     VectorSourceColor(RGBA(255,100,100,255))
;     FillPath()
;     StopDrawing()
;   EndIf
  
  
  win = #Win_CHG_InfosForwainting
  ; count the number of line to draw
  info$ = maininfo1$+"#"+info$
  nb = CountString(info$, "#")
  Dim txt$(nb)
  
  For i=0 To nb
    
    Txt$(i) = StringField(info$, i+1, "#")
    ; check if need to resize the window
    w = Len(txt$(i))*20 
    h = 5+(1+nb*35)
    
    If h > WindowHeight( win)
      ResizeWindow(win, #PB_Ignore, #PB_Ignore, #PB_Ignore, h)
    EndIf
    If w > WindowWidth( win)
      ResizeWindow(win, #PB_Ignore, #PB_Ignore, w, #PB_Ignore)
    EndIf
    
  Next
  
  If StartDrawing(WindowOutput(win))
      DrawingMode(#PB_2DDrawing_Default)
      Box(0,0,OutputWidth(),OutputHeight(), RGB(150,150,150))
      
      ; draw the infos
      DrawingMode(#PB_2DDrawing_Transparent)
      DrawingFont(FontID(#FontArial20Bold))
      For i = 0 To nb
        DrawText(10, 5+30*i, txt$(i), RGB(255, 255, 255))
      Next 
      
      StopDrawing()
    EndIf
    
    FreeArray(txt$())
  
EndProcedure
Procedure WindowInfos_Create(maininfo$,info$)
  
  Shared maininfo1$
  maininfo1$ = maininfo$
  ; a window to wait when load or save long things (export image or load a big file)
  w = 500
  h = 300
  If OpenWindow(#Win_CHG_InfosForwainting,0,0,W,h,lang("Please, wait..."),#PB_Window_ScreenCentered, WindowID(#Win_CHG_CharacterEditor))
    
    SetActiveWindow(#Win_CHG_CharacterEditor)
    If StartDrawing(WindowOutput(#Win_CHG_InfosForwainting))
      DrawingMode(#PB_2DDrawing_Default)
      Box(0,0,OutputWidth(),OutputHeight(), RGB(150,150,150))
      DrawingMode(#PB_2DDrawing_Transparent)
      DrawingFont(FontID(#FontArial20Bold))
      DrawText(10, 5, maininfo$, RGB(255, 255, 255))
      DrawText(10, 25, info$, RGB(255, 255, 255))
      StopDrawing()
    EndIf
;     If CanvasGadget(#G_CanvasWinInfos,0,0,w,h)
;       WindowInfos_Update(info$)
;     EndIf
;     Repeat
;       event=WaitWindowEvent(1)
;       quit+1
;     Until quit >=5
  EndIf
  
EndProcedure
Procedure WindowInfos_Close()
  If IsWindow(#Win_CHG_InfosForwainting)
    CloseWindow(#Win_CHG_InfosForwainting)
  EndIf
EndProcedure

;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 397
; FirstLine = 125
; Folding = AAAGAA9--
; EnableXP