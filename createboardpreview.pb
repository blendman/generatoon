UsePNGImageDecoder()
UsePNGImageEncoder()
UseJPEGImageEncoder()

Structure sImage
  image.i
  name$
  date.i
EndStructure
Global Dim img.sImage(0)
Global nbimage= -1

Procedure ResizeImageProportion(image,width,mode=#PB_Image_Smooth)
  s = width
  t = image
  w = ImageWidth(t)
  h = ImageHeight(t)
  
  If w>width Or h>w
    If w>h And w>0
      nw = s
      nh = (h * s)/w
      ok=1
    Else
      If h>0
        nh = s
        nw = (w * s)/h
        ok=1
      EndIf
    EndIf
  EndIf
  If ok=1
    ResizeImage(image, nw, nh, mode)
  EndIf
EndProcedure

; ici, je définis le nombre de colonne
a = 7; 4
; la largeur max des case
w5 = 350
; ici, je définis la taille des bordures entre les images
bordw = 3
Bordh = 3



repertoire$ = GetCurrentDirectory()+"save\ok_pets\"
If ExamineDirectory(0, Repertoire$, "*.png")  
  
  While NextDirectoryEntry(0)
    If DirectoryEntryType(0) = #PB_DirectoryEntry_File
      file$ =  Repertoire$+DirectoryEntryName(0)
      If FileSize(file$)>0
        
        nbimage+1
        i = nbimage
        ReDim img(i)
        u = LoadImage(#PB_Any,file$)
        ;ResizeImage(u,256,-1)
        img(i)\image = u
        img(i)\name$ = ReplaceString(GetFilePart(file$),".png", "")
        img(i)\date = DirectoryEntryDate(0, #PB_Date_Created )
        ResizeImageProportion(img(i)\image,w5)
        h1=Round((i+1)/a, #PB_Round_Up)
      EndIf
    EndIf
    
  Wend
  FinishDirectory(0)
EndIf

; SortStructuredArray(img(),#PB_Sort_Ascending ,OffsetOf(sImage\name$),TypeOf(sImage\name$)) 

; For i=0 To ArraySize(img())
;   Debug img(i)\name$ + " :"+Str(img(i)\date)
;  Next

w1 = a*(w5+bordw)
h2 = ImageHeight(img(0)\image) + bordh
h1 * h2
w5 = w5+bordw

If CreateImage(0,w1,h1)
  
  If StartDrawing(ImageOutput(0))
    Box(0,0,OutputWidth(), OutputHeight(), RGB(255,255,255)) ;RGB(150,150,150))
    For i=0 To ArraySize(img())
      x = Mod(i,a)* w5 
      y = (i/a)*h2 
      ; je dessine la case
      Box(x,y,w5-1, h2-1,RGBA(180,180,180,255))
      ; je centre l'image par case à la case 
      DrawAlphaImage(ImageID(img(i)\image),x+ (w5 - ImageWidth(img(i)\image))*0.5,y+ (h2 - ImageHeight(img(i)\image))*0.5 )
    Next
    
    StopDrawing()
  EndIf
  
  If SaveImage(0,GetCurrentDirectory()+"save\"+ "charBoard.png",#PB_ImagePlugin_PNG)
  EndIf
  
  
EndIf



; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 18
; FirstLine = 8
; Folding = -+-
; EnableXP