;{ INFOS

;{ GENERAL INFOS
; window Character Generator (CHG_)
; blendman 2021-2023, pb 5.73 x86 (should work on 64)
; video :  https://www.youtube.com/watch?v=dHUIYqc641w

; Some codes are by developpers from purebasic forum : Mickael Vogel, LSI, Wilbert, Guillot, Naheulf, Chi,
;}

;{ PROJECTS
; Moyfys (Syfy Human) elements : 
; 19 nose, 7 hair, 14 eye, 10 mouth, 10 hear, 1head, 1 neck, 0 subneck, 0 body, 0subbody, 
; 0 hairover, 0 arm, 0 epaule, 0 lunette, 0 barb, 
;}

;{ CHANGES

;{ BUGS :
; OK 0.15 - parfois les oreilles sont mal placées
; ok 0.18 - miror ne fonctionne pas si on clique sur miror
; ok 0.18 - hide ne unhide pas le truc selected
; ok 0.18 - exporteImage devrait demander le nom de l'image ?
;}


;{ todo :

;{ OK 
; - CHG_Doc_Save()
; - CHG_Options_Reset()
; - CHG_Options_Load()
; - CHG_Options_save()
; - pouvoir changer le dossier principal
; - view : showcenter, showcameraborder,showrenderingborder
; - main canvas : zoom, pan
; - maincanvas : add border rendering
; - event canvas : clic To Select objet
; - panel edit : add gadgets (x,y,w,h,scale,hide image & folder name, color (skin, hair))
; - event canvas : object move (if chg_action=1)
; - event canvas : object scale (if chg_action=1 and ctrl or if chg_action=2)
; - panel edit : event gadgets (position, w,h, scale, alpha, hide, locked)
; - add panel "Bank" : templateList, btn new/save
; - modifier le systeme en utilisant des char\part non défini, 
; - New system : on peut changer prop (position, scale, depth, color...)
; - New system : on peut enregistrer le template
; - add panel "Bank" : ccbox folder "image" (part)
; - New system : on peut ajouter un element (Character(1)\part() (=template) et Character(0)\part())
; - add panel "Bank" : canvas preview (to select image)
; - CHG_Doc_Open()
; - hideall selected, unhide all, hide unselected
; - delete part
; - change image by dbleclic on canvasImagepart
; - propertie : change colortype -> update color of image
; - add panel "Bank" : center object(canvas) + string (cx,cy)
; - panel edit : event gadgets (change image, color (skin, hair))
; - set BG color of Character()
; - window properties
; - maincanvas : change rendering output scale.
; - view : Showshapebbox
; - set color with character()\color() and no more \skinhue...
; - convert character to template : copy x et y char vers template, ensuite, je mets à zero x et y du character
; - ajouter un progressbar pour certaines action : créer un personnage par exem^ples

;}


; Not priority :
; - autosave
; - copy paste part
; - locked all selected, unlocked all, locked unselected
; - grid
; - snap
; - origin (0,0)

; ANIMATION TODO : 
; - timeline (keyframe, selector, start, end, layer)
; - animation layer (see, locked, name, order)
; - keyframe Add, copy, paste, delete, move
; - play stop anim
; - animation fps, speed, play, stop, loop

; TODO priority :
; - parent part (move)
; - parent part (rotate)
; - parent part (scale)
; - part keyframe
; - bank : add buton "randomise" (when ad object : random x, y, image)
;}

; pas urgent :
; - center on canvasimagefolder
; - zoom for canvasCenter

; moyen urgent : 
; - option : use -y for depth (to create easily map for gamelevel for exemple)
; - autodepth realtime (to create level for game or animation for example)

; priority : 
; ok ?? - opendoc : color (skin, hair) for mycharacter (not randomised created character file)
; - bug si fichier utilise un gabarit avec pas les mêmes noms etc...
; ok ? - drag & drop un élement (depuis la banque) sur le canvas 
; - center_canvas: ajouter stringgadget centerX/centerY
; - center_canvas: ajouter checkbox pour option show centerline
; - create random char : ajouter option (use clone eye, clone oreille)
; - create random expression : ajouter option (checkbox : change eye, mouth)

; bugs : 
; - 


;{ 01/2023 (1/22)

; 3/01/2023 0.25.5 (22)
; // New
; - menu file : preference
; - CHG_WinPreference()
;}

;{ 12/2021 (3/21)




; 3/12/2021 0.25.4 (21)
; // NEw
; - menu object : move Object to front (depth)
; - menu object : move Object to back (depth)
; // changes
; - lang system improved
; - addlangcomment()
; - lang(): on peut ajouter un comment dans le fichier langue (direcement avec lang(keyword$, comment$="").


; 2/12/2021 0.25 (20)
; // New
; - add paint tool : to add part of char directly on the canvas.
; - add icone : apint, play, stop
; - add action : #CHG_ActionAdd (clic on canvasmain -> add the objet with current image)
; - drag & drop (from canvasImages to canvasmain)


; 1/12/2021 0.24.5 (19)
; // New
; - center_canvas: ajouter ligne de centre 
; - InitLang() : init the langage by default. 
; - SaveLang(keyword$) : save the keywords in the lang file
; - readlang(keyword$) : read the keyword in the lang file.
; - add langage file in editor\lang\
; // changes
; - now, lang() use the words if it exists in the lang file.
;}
;{ 11/2021 (2/18)

; 30/11/2021 0.24 (18)
; // New
; - UnPreMultiplyAlpha() (procedure & module).
; - added than removed (because color technic normal is fixed) new color technic (normal HSL)
; - menu savedoc : add project folder
; - menu opendoc : now, it use the project folder to open the correct image for the file.
; // Changes
; - add UnPreMultiplyAlpha() when export image
; // Fixes
; - bouton colornew mal placé (trop bas)
; - scrollarea & canvas color plus petits
; - color technic 2 ne fonctionne pas correctement
; - some fixes with debugger (gadget not exists...)
; - Quand on reouvre un fichier, parfois, ça bug sur les couleurs (si on n'a pas mis de couleur aux elements, ça en met quand même)
; - Quand on reouvre un fichier, parfois, ça bug sur le miror

; 29/11/2021 0.23.5 (17)
; // new
; - Add cbobox to choose the coloring technic (old, new).
; - Add options\TechnicForColoring
; // Changes
; - les dossier (des répertoire d'images (=dossier "projets" dans "data") sont désormais triés par ordre alphabetique
; - les dossier d'images sont désormais triés par ordre alphabetique
; // fixes
; - au depart, on n'était pas sur le bon dernier dossier sélectionné

;}
;{ 10/2021 (11/16)

; 15/10/2021 0.23 (16)
; // new
; - CHG_CreateRandomExpressionfromCharacter()
; - CHG_options\NBRandomExpressions pour définir le nombre d'expressions à créer avec CHG_CreateRandomExpressionfromCharacter
; - CHG_convertchar2template()
; - add \rotation to template
; // Changes
; - CHG_Doc_SaveImage() add index$ to add several image with same date/h-m-s
; - CHG_saveTemplate() now convert chr2template before to save it.
; - template list is now sorted by name
; - createPart : character()\depth now start at 10 (was 0)
; - CHG_OpenTemplate : depth now start at 10 (was 0)
; // fixes
; - when addcharpart(), it wasn't created at mousex/y
; - when select a tool, all the other tool butons should be untoggled


; 14/10/2021 0.22 (15)
; // new
; - CHG_Doc_Save() : save character(0)\color()
; - CHG_Doc_Open() : open character(0)\color()
; - add brighness (luminosity) to character()\brightness() and set brightness
; // Changes
; - add HSL gadget (hue, saturation, lightness)
; - add character()\color : hue, saturation, luminosity
; - add character()\color : hue, saturation, luminosity
; // Fixes
; - The number of template files wasn't correct in the gadget combobox list


; 12/10/2021 0.21.4 (14)
; // Changes
; - use HSL2RGB() From Mickael Vogen (pb english forum) for HSL color
; // Fixes
; - Doc_new() : should reset chracter(0)\color()

; 11/10/2021 0.21.1 (13)
; // CHanges
; - set color with character()\color() and no more \skinhue...


; 7/10/2021 0.21 (12)
; // New
; - when clic on part, it change the folderimage automatycally. 
; - select tool : we can only add/supp from selection (with ctrl) and selection tool.
; - select +ctrl : unselect (if already selected) or select (if not selected) the part 
; - window info : open, update, close.
; - menu\showdebug infos
; - CHG_SetMenuState(menuitem, option, update=1,setoption=1)
; - Menu\help\about
; - add font needed
; // Changes
; - when create the menu -> I use now SetMenuItemState()
; // fixes
; - Doc_open() : some changes to fixe bugs with files which not use only template
; - CHG_SetCharacterPartImage() : with miror : the color isn't updated
; - when a part, the size (w,) was 1,1 and not w,H
; - fixe a bug when we change the depth of an object
; - when change the depth of an object, gadget partlist shouldbe updated
; - part\depth was max 255 (part\depth.a instead of part\depth.w)
; - check to select a part : usealpha only if imagedepth()=32


; 6/10/2021 0.20.3 (11)
; // New
; - CHG_GetClicOnImageRotated() : to know if we have clicked on rotated image
; - view : Showshapebbox
; // Changes
; - when use other gadget than spin or string, the shortcut are reused
; // fixes
; - when use spingadget, the shortcut aren't removed

; 5/10/2021 0.20 (10)
; // New
; - add color to character()\color()
; - tab color: buton add new color
; - tab color: buton set current color
; - tab color: canvas to see the colors (clic on color select the current chg_colorID)
; - now, exportimage and updatecanvasmain use vd_camera()
; - OpenWindow_Sceneproperties()
; - add functions from cartoon and adapt the code to work with (VD_GetCameratext(), VD_CameraAdd()...)
; - VD_ExportPresetCamera()
; - Add gadget to change the main folder projects
; - shortcut : M = miror, h = hide, 
; // Changes
; - clic on part : check alpha only if \rotation=0
; - now, the output use VD_camera(cameraId)
; // Fixes
; - when trying to select apart with zoom<>100 and viewx\y <> 0
; - when create a new part (with A key), it should be create at mouse coord


; 4/10/2021 0.19 (9)
; // New
; - Gadget SetBGColor 
; - Gadget UseBGColor (to use or note the BG color (preview & render))
; - Menu View UseClipping
; - CHG_SaveObjectCenter()
; - panel "Bank" : if move center object-> update center on all character(0)\part() which use this image
; - panel "Bank" : change center by clicking on canvas centerpreview
; - propertie : change colortype -> update color of image
; - change image by dbleclic on canvasImagepart (and set center and \w, \h if needed)
; - Menu\Object\delete part
; - Delete Part
; - menu\object\add object
; - add macros : DeleteArrayElement(), InsertArrayElement()
; - current tool is now saved in options
; // Fixes
; - set prop : rotation didn't work
; - when open a file, the miror isn't used
; - when hide a part, it should be \selected=0
; - when add a part, the gadgetlist (character part) isn't updated
; - when add a part, the new part replace another part (after create random character)
; - opendoc : if version<0.18 -> set depth = id*10
; - when move template\part, the startx,y wasn't used
; - when CHG_InitCharacter(), character(1) should be init too
; - create template doesn't use use the extension ".tce"
; - Opentemplate now \depth = 10*Part_id
; - if change depth or prop (except x,y), should change prop for character(1)



; 3/10/2021 0.18 (8)
;// new
; - CHG_Doc_Open()
; - toolbar : new, open, save are ok
; - Menu : SelectALL, DeselectALl
; - Menu : unhide All, hide all except selected
; - chg_optionc\useClipping to use or not the clipping (on the preview rendering)
; - add rotation to drawtheCharacter() 
; - move selection 
; - scale selection (in origin, not bounding box)
; - setpropertie : imagename
; - setpropertie : Miror
; - Shortcut : remove if we use a gadget string or spin, and set it if not.
;// changes
; - CHG_EventMainCanvas() : lots of changes to use selection
; - tool move, scale, rotate works with selection now
; - set properties works with selection now
; - select a part only if clic on alpha(x,y)>0
;// fixes
; - menu\exportimageas : dont ask filename
; - setprop : hide/unhide didnt work


; 2/10/2021 0.17 (7)
; // New
; - panel bank : add button to open a window for center image
; - menu : export Image as
; - menu doc_new ok (CHG_Doc_New())
; - panel bank : add canvas to see center image
; - panel bank : cbbox select folderimage -> CHG_UpdateListImageFromFolder()
; - CHG_UpdateCanvasImageObject() : to update canvas image (from folder)
; - CHG_EventCanvasImageObject() : clic to select image
; - panel bank : add canvas for images from folder-part
; - panel bank : add cbbox to select folderImage-part
; - panel bank : clic on "+" -> add objet with current image from current folderImage
; - CHG_AddTemplatePart(name$,obj$)
; // changes
; - we can change the name of a part
; - we can change the depth of a part - > then CHG_SortCharacter()
; - addcharacterpart() sort by depth (Character(0) & Character(1))
; - addcharacterpart() : \depth = 10*i
; - addcharacterpart() : use CHG_SetObjetCenter() to set the center of image
; - now, the images are in "projectFolder\images\"
; - CHG_OpenObjectCenter() : open and keep all center by image in an array CHG_BankImageCenter()
; // Fixes
; - fixe some bugs (array index out of bounds) with Character()\part()


; 1/10/2021 0.16 (6)
; // New
; - chg_SaveTemplate()
; - tab edit : add gadget list to Select the part (of character or template) and update gadget on panel "edit"
; - tab edit : add gadget to Set template or character for gadgets
; - tab edit : add depth, alpha, miror, rotation, locked
; - now, we can use : chg_options\settemplate, to use gadgets (tab edit) to set the template.
; - add panel "Bank" : templateList, btn save
; - add panel "Bank" : when change templateList, it change the template position of part
; - event canvas : object scale (if chg_action=1 and ctrl or if chg_action=2)
; - Draw character : add alpha
; - Tab edit : event gadgets ok : x,y,hide,locked,alpha,w,h,scale. ok but do nothing for the moment : rotation, depth
; - we can change the tool (chg_action) : only move works for the moment.
; - add toolbar : container+ buttons_image (new, open, save, tool (select, move, scale, rotate)
; - Panel left edit : add clone, rotation, locked, color, colortype.
; - enumeration : add image icone (toolbar), for some gadgets (edit : locked, clone..)
; // Changes
; - Change character.sCharacter to dim character.sCharacter(1)
; - now, template\ is Character(1)\
; - now, the mx,my isn't updated if movemouse+leftclic
; // Fixes
; - when open the program, viewX,Y isn't updated.
;}
;{ 09/2021 (5/5)
; 30/09/2021 0.15 (5)
; // New
; - enumeration : add enumeration gagdets for panel, gadgettype
; - addgadget(), gadget_AddItems(), setgadgetcolor2()
; - panel edit : add gadgets (x,y,w,h,scale,hide, image & folder name)
; - event canvas : object move (if CHG_action=1)
; - add CHG_action
; - add part of character by template is now very easy !
; - template: add random hide
; // changes
; - template & character : all is ok
; - lots of changes in template and character to not use predefined character
; - character properties : add depth, colortype, miror, tx,ty (template x,y)
; - template properties : add depth, colortype, miror, tx,ty (template x,y)
; - modifier le systeme en utilisant des char\part non défini, 


; 29/09/2021 0.13.7 (4)
; // New
; - menu view: zoom (50,100,150,200), reset, center
; - use Brightness to change color of character (skin & hair)
; - main canvas : zoom, pan
; - event canvas : clic To Select objet, 
; - MainCanvas options : showcameraborder, showcenter, showRenderingborder
; - menu file : save, saveimage
; - menu view : showcameraborder, showcenter
; - CHG_Doc_Save(): general, character prop (template, color&brightness (skin, hair)), render(x,y,w,h,scale), char\part
; - Add shortcut Ctrl+R to randomly create a new character
; - add parameters in structure : CHG_options, CHG_Doc (filename$, template$)
; - add & change parameters in sCharacter : hairhue, hairbrightness,skinBrightness BG (color).
; - add parameters in sPart : hide, selected, alpha, Scale
; - CHG_Options_Reset()
; - CHG_Options_Load()
; - CHG_Options_save()
; - we can change the main folder of the project (for the moment, only with option (preference.json)
; // Changes
; - now, the program use the camera for rendering (x,y,w,h)


; 28/09/2021 0.12 (3)
; // New
; - Opentemplate() : to open randomly a templates
; - add templates to create character (to define position of each elements) : 5 templates added for the moment (folder data\_myfolder_\templates\)
; - add HUE changes for hair and skin ! 
; - new elements : 11 nose/19, 2 hair/7, 5 eye/14, 5 mouth/10, 7 hear/10
; // changes
; - now, when CreateCharacter() : I add Opentemplate() (random selection)

; 27/09/2021 0.1 (2)
; // New
; - Copy from cartoon : enumeration, structure sCharPart, sCharacter, WindowCharacterEditor_updatecanvas(),WindowCharacterEditor()
; - openwidow & loop
; - create gadget (panel left, canvas main)
; - test : add A character with some part (head, eye * 2, mouth, nose, hair, hear *2)
; - AddCharacterPart(i,obj$,filename$) : to add part to the character
; - CreateCharacter() : to create the character
; - OpenObjectCenter()
; - menu : random characters

;}
;}
;}

;- ENUMERATION
#CHG_ProgramVersion="0.25.5"
#CHG_ProgramName="Generatoon"
#PB_Compiler_Backend = 0

Enumeration
  ; windows
  #Win_CHG_CharacterEditor = 1
  #Win_CHG_Sceneproperties
  #Win_CHG_InfosForwainting
  #win_Chg_Preference
  
  ;{ menu
  #menu_wincharacter=0
  ; menuitem
  ; file
  #MenuCHG_FileNewProject = 0
  #MenuCHG_FileNew
  #MenuCHG_FileNewCharacter
  #MenuCHG_FileSave
  #MenuCHG_FileSaveAs
  #MenuCHG_FileSaveRandomExpressions
  #MenuCHG_FileOpen
  #MenuCHG_FileExportImage
  #MenuCHG_FileExportImageAs
  #MenuCHG_FileExportTemplate
  #MenuCHG_FileOutputProperties
  #MenuCHG_FilePreference
  #MenuCHG_FileQuit
  ; edit
  #MenuCHG_EditConvertchartotemplate
  #MenuCHG_EditCreateRandomCharacter
  #MenuCHG_EditCopy
  #MenuCHG_EditPaste
  #MenuCHG_EditSelectAll
  #MenuCHG_EditDeselectAll
  #MenuCHG_EditHideAllexceptSelected
  #MenuCHG_EditUnHideAll
  #MenuCHG_EditHideSelected
  ; view
  #MenuCHG_ViewShowCameraBorder
  #MenuCHG_ViewShowRenderBorder
  #MenuCHG_ViewShowShapeBbox
  #MenuCHG_ViewShowCenter
  #MenuCHG_ViewShowDebugInfos
  #MenuCHG_ViewReset
  #MenuCHG_ViewCenter
  #MenuCHG_ViewZoom50
  #MenuCHG_ViewZoom100
  #MenuCHG_ViewZoom150
  #MenuCHG_ViewZoom200
  #MenuCHG_ViewUseClipping
  ; Object
  #MenuCHG_ObjectAddObjet
  #MenuCHG_ObjectDelObjet
  #MenuCHG_ObjectWindowColor
  #MenuCHG_ObjectMiror
  #MenuCHG_ObjectSetToFront
  #MenuCHG_ObjectSetToBack
  ; help
  #MenuCHG_HelpAbout
  ;}
  
  ;{ gadgets
  ;{ window character editor
  #G_WinCHG_First= 0
;   #G_WinCHG_ElementImage

  
  ; toolbar
  #G_WinCHG_TbCont
  #G_WinCHG_TbNew
  #G_WinCHG_TbOpen
  #G_WinCHG_TbSave
  #G_WinCHG_TbAdd
  #G_WinCHG_TbSelect
  #G_WinCHG_TbMove
  #G_WinCHG_TbScale
  #G_WinCHG_TbRotate
  #G_WinCHG_TbLAST
  
  ; panell left
  #G_WinCHG_PanelL
  #G_WinCHG_ContPanelL

  ;tab bank
  ; #G_WinCHG_Bank_ProjectFolder
  #G_WinCHG_Bank_ProjectFolder
  #G_WinCHG_Bank_TemplateSelect
  #G_WinCHG_Bank_TemplateSave
  #G_WinCHG_Bank_TemplateNew
  #G_WinCHG_Bank_ListFolderImage
  #G_WinCHG_Bank_AddObject
  #G_WinCHG_Bank_SA
  #G_WinCHG_Bank_CanvasPreviewObject
  #G_WinCHG_Bank_SAObjCenter
  #G_WinCHG_Bank_CanvasObjCenter
  #G_WinCHG_Bank_CanvasObjCenterSet
  
  #G_WinCHG_Edit_ElementNext
  #G_WinCHG_Edit_ElementPrevious
  
  ; tab Edit
  #G_WinCHG_SA
  
  
  #G_WinCHG_Edit_SetTemplate
  #G_WinCHG_Edit_SelectPart

  ; attention, should be in the same order than Gadget character propertie (see after)
  #G_WinCHG_Edit_Name
  #G_WinCHG_Edit_ImageName
  #G_WinCHG_Edit_ObjName
  #G_WinCHG_Edit_X
  #G_WinCHG_Edit_y
  #G_WinCHG_Edit_w
  #G_WinCHG_Edit_h
  #G_WinCHG_Edit_scale
  #G_WinCHG_Edit_alpha
  #G_WinCHG_Edit_Color
  #G_WinCHG_Edit_ColorType
  #G_WinCHG_Edit_Clone
  #G_WinCHG_Edit_Miror
  #G_WinCHG_Edit_Rotate
  #G_WinCHG_Edit_Depth
  #G_WinCHG_Edit_hide
  #G_WinCHG_Edit_locked
  
  ; colors
  #G_WinCHG_Color_SetBG
  #G_WinCHG_Color_UseBG
  
  #G_WinCHG_Color_TechnicUsed
  #G_WinCHG_Color_NewColor
  #G_WinCHG_Color_Name
  #G_WinCHG_Color_CanvasColor
  #G_WinCHG_Color_SA
  #G_WinCHG_Color_Hue
  #G_WinCHG_Color_Saturation
  #G_WinCHG_Color_Luminosity
  
  ; main canvas
  #G_WinCHG_CanvasMain

  
  ;{ panel right - not used
  #G_WinCHG_PanelR
  #G_WinCHG_Eye
  #G_WinCHG_EyeNext
  #G_WinCHG_EyePrev
  #G_WinCHG_Head
  #G_WinCHG_HeadNext
  #G_WinCHG_HeadPrev
  #G_WinCHG_Hear
  #G_WinCHG_Nose
  #G_WinCHG_Mouth
  #G_WinCHG_Hair
  #G_WinCHG_Neck
  #G_WinCHG_Mustach
  #G_WinCHG_Glass
  #G_WinCHG_Hat
  ;}
  
  
  ;{ window preference
  #G_WinPref_Lang
  ;}
  
  ;{ other windows
  
  ; for all window
  #G_Win_BtnOk
  #G_Win_BtnCancel
  ;}
  
  
  #G_WinCHG_LAST
  
  ;}
  ;}
  
  ;{ Gadget character propertie
  ; attention, should be in the same order than Gadget propertie (see before)

  #CHGProp_Name=0
  #CHGProp_ImageName
  #CHGProp_ObjName
  #CHGProp_x
  #CHGProp_y
  #CHGProp_w
  #CHGProp_h
  #CHGProp_Scale
  #CHGProp_Alpha
  #CHGProp_Color
  #CHGProp_ColorType
  #CHGProp_Clone
  #CHGProp_Miror
  #CHGProp_Rotation
  #CHGProp_Depth
  #CHGProp_Hide
  #CHGProp_locked
  ;}
    
  ;{ gadget type (for procedure addgadgets()
  #Gad_spin=0
  #Gad_String
  #Gad_Btn
  #Gad_BtnImg
  #Gad_Chkbox
  #Gad_Cbbox
  #Gad_ListV
  ;}

  ; files
  #JSONFile = 0
  ;{ image
  #chg_Img_New=1
  #chg_Img_Open
  #chg_Img_Save
  #chg_Img_paint
  #chg_Img_Select
  #chg_Img_Move
  #chg_Img_Scale
  #chg_Img_Rotate
  #chg_Img_Propertie
  ; autre
  #image_Export
  #CHG_image_Drag
  ;}
  
  ;{ chg_action (tool)
  #CHG_ActionAdd=0
  #CHG_ActionSelect
  #CHG_ActionMove
  #CHG_ActionScale
  #CHG_ActionRotate
  ;}
  
  ; font
  #FontArial20Bold = 0
EndEnumeration

;{ structures
;- STRUCTURES

Structure sRect
  x.w
  y.w
  w.w
  h.w
  scale.w
EndStructure
Structure sPoint
  x.i
  y.i
EndStructure

Structure sCHG_Options
  ; editor
  viewx.w
  viewy.w
  Zoom.w
  SetTemplate.a
  UseClipping.a
  TechnicForColoring.a
  UseBG.a
  Action.a
  ; ui
  PanelW.w
  PanelR.w
  CanvasCenterShowLine.a
  CanvasCenterShowCenter.a
  Lang$
  NewLang$ ; When we change the langage
  ; show
  ShowCenter.a
  ShowBBox.a
  ShowCameraBorder.a
  ShowRenderingBorder.a
  showdebuginfos.a
  ; path
  PathSave$
  PathOpen$
  PathExport$
  ; Camera rendering
  Camera.sRect
  ; last project
  FolderProject$
  AutoSaveFile.a
  AutoSaveImage.a
  NBRandomExpressions.w
EndStructure
Global CHG_Options.sCHG_Options

Structure sDocument
  prop.sRect
  camera.sRect
  FolderProject$
  filename$
  template$ ; le template utilisé
EndStructure
Global CHG_doc.sDocument

Structure sHSL
  Hue.w
  Saturation.w
  Luminosity.w
EndStructure
Structure sCharPart
  filename$ ; image name
  obj$ ; folder$
  name$ ; name of the part
  ; if the part use the same image as another part, clone$ is the the name$ of the other part
  Clone$
  ; image
  img.i
  ; position, by default = 0
  x.d
  y.d
  Finalx.w
  FinalY.w
  ; template position
  tx.w
  ty.w
  tr.w ; template rotation
  ts.d ; template scale
  ; center position
  cx.f
  cy.f
  finalcx.f
  finalcy.f
  w.w
  h.w
  Scale.w
  Rotation.w
  Miror.a
  ; for transformation
  startX.w
  startY.w
  StartScale.w
  StartRot.w
  ; prop rendering
  Hide.a
  Alpha.a 
  Depth.w
  Color.i
  ColorType.w
  ; editor
  Selected.a
  locked.a
EndStructure
; character, for the window character creator
Structure sCharacter
  Array part.sCharPart(0)
  Array Color.sHSL(0)
  NbColor.w
  NbPart.w
  BG.i
  template$
  OkColor.a
  ; Ã  supprimer quand j'utiliserai l'array color()
  SkinHue.w
  SkinBrightness.w
  HairHue.w
  HairBrightness.w
  ; other
  NotUsetemplate.a
EndStructure
Global Dim Character.sCharacter(1), CHG_CharacterID=0, CHG_NBPart = -1, CHG_ColorId, chg_nbcolor=0
; Character(0) = character
; Character(1) = template // gabarit

Structure sFile
  Filename$
  Name$
EndStructure
Global Dim BankTemplates.sFile(0), nbBanktemplates=-1, CHG_BankTemplateId
Global Dim BankFolderImages.sFile(0), CHG_ImageFolderID
Global Dim BankProjectFolder.sFile(0), CHG_ProjectFolderID

Structure sBankImage Extends sFile
  Image.i
  ImageOrigin.i
  cx.w
  cy.w
  w.w
  h.w
EndStructure
Global Dim BankImages.sBankImage(0), NbBankImage=-1

Structure sCenter
  ImageName$
  Folder$ ; folder for the ucrrent part- images (ex : "mouth")
  cx.w
  cy.w
  w.w
  h.w
EndStructure
Global Dim CHG_BankImageCenter.sCenter(0), NbCenterImage=-1

Global CHG_ObjID=-1, CHG_action = 0,mx, my
; local to use in procedure
Dim wec_bankimage.sFile(0)
;}
;{ includefile 
;- INCLUDEFILE
XIncludeFile "include\macros.pbi"
XIncludeFile "include\lang.pbi" ; for langage localisation
XIncludeFile "include\init.pbi"
XIncludeFile "include\GadgetR.pbi" ; by guillot & naheulf
UseModule GadgetR
XIncludeFile "include\declaration.pbi"
;}
;{ procedures
;- PROCEDURES

;{ declare 
Declare CHG_SetViewZoom(vx,vy,zoom=0)
Declare WindowInfoCreate(info$)
Declare WindowInfoUpdate(info$)
Declare CloseWindowInfo()
Declare UnPreMultiplyAlpha(image)
;}

;{ images (& init images)
Procedure FreeImage2(image)
  If IsImage(image)
    FreeImage(Image)
  EndIf
EndProcedure
Procedure Message(txt$)
  MessageRequester(Lang("Infos"),txt$)
EndProcedure
Procedure CheckZero(vv,valdefault,usemax=0)
  If vv<=0
    vv = valdefault
  EndIf
  If usemax
    If vv>valdefault
      vv = valdefault
    EndIf
  EndIf
  ProcedureReturn vv
EndProcedure
Procedure ErrorHandler()
  
  ErrorMessage$ = "A program error was detected:" + Chr(13) 
  ErrorMessage$ + Chr(13)
  ErrorMessage$ + "Error Message:   " + ErrorMessage()      + Chr(13)
  ErrorMessage$ + "Error Code:      " + Str(ErrorCode())    + Chr(13)  
  ErrorMessage$ + "Code Address:    " + Str(ErrorAddress()) + Chr(13)
  
  Select ErrorCode() 
    Case #PB_OnError_InvalidMemory   
      ErrorMessage$ + "Error IMA :  " + Str(ErrorTargetAddress()) + Chr(13)
      
    Case #PB_OnError_DivideByZero 
      ErrorMessage$ + "Error divide by zero :  " + Str(ErrorTargetAddress()) + Chr(13)
      
    Case #PB_OnError_IllegalInstruction    
      ErrorMessage$ + "Illegal instruction :  " + Str(ErrorTargetAddress()) + Chr(13)

  EndSelect
  
  If ErrorLine() = -1
    ErrorMessage$ + "Sourcecode line: Enable OnError lines support to get code line information." + Chr(13)
  Else
    ErrorMessage$ + "Sourcecode line: " + Str(ErrorLine()) + Chr(13)
    ErrorMessage$ + "Sourcecode file: " + ErrorFile() + Chr(13)
  EndIf
  
  ErrorMessage$ + Chr(13)
  
  MessageRequester("Error", ErrorMessage$)
  End
  
EndProcedure
Procedure VD_GetFileExists(filename$)
  
  If FileSize(filename$)<=0
    ProcedureReturn 0
  Else
    If MessageRequester(lang("Info"), lang("The file already exists. Do you want ot overwrite it ?"), #PB_MessageRequester_YesNo) = #PB_MessageRequester_No
      ProcedureReturn 1
    Else
      ProcedureReturn 0
    EndIf
  EndIf
  
EndProcedure

Procedure.i Brightness(Color.i, value.f) 
  
  ; Eclaicir ou foncer une Color
  ; by LSI ?
  Protected Red.i, Green.i, Blue.i, Alpha.i
  
  Red = Color & $FF
  Green = Color >> 8 & $FF
  Blue = Color >> 16 & $FF
  Alpha = Color >> 24
  Red * value
  Green * value
  Blue * value
  
  If Red > 255 : Red = 255 : EndIf
  If Green > 255 : Green = 255 : EndIf
  If Blue > 255 : Blue = 255 : EndIf
  
  ProcedureReturn (Red | Green <<8 | Blue << 16 | Alpha << 24)
EndProcedure

; by mickael vogel
#Factor=1000
Procedure.f HUE2COL(l.f,s.f,h.f)

	l=l*2-s
	If h<0 : h+1 : ElseIf h>1 : h-1 : EndIf

	If h*6<1 : ProcedureReturn (l+(s-l)*6*h) : EndIf
	If h*2<1 : ProcedureReturn s : EndIf
	If h*3<2 : ProcedureReturn (l+(s-l)*(2/3-h)*6) : EndIf

	ProcedureReturn l

EndProcedure
Procedure HSL2RGB(Hue.f,Sat.f,Lum.f,*R.Integer,*G.Integer,*B.Integer)

	Hue/360
	Sat/#Factor
	Lum/#Factor

	If Sat=0
		Lum*255
		*R\i=Lum
		*G\i=Lum
		*B\i=Lum

	Else
		If Lum<0.5
			Sat=Lum*(1+Sat)
		Else
			Sat=(Lum+Sat)-(Sat*Lum)
		EndIf

		*R\i=255*HUE2COL(Lum,Sat,Hue+1/3)
		*G\i=255*HUE2COL(Lum,Sat,Hue)
		*B\i=255*HUE2COL(Lum,Sat,Hue-1/3)

	EndIf

EndProcedure
Procedure RGB2HSL(R.f,G.f,B.f,*hue.Integer,*sat.Integer,*lum.Integer)

	Protected min.f,max.f
	Protected c.f

	R/255 : G/255 : B/255

	max=R : min=R
	If min>G : min=G : EndIf
	If min>B : min=B : EndIf
	If max<G : max=G : EndIf
	If max<B : max=B : EndIf

	*lum\i=(min+max)*#Factor/2

	If max-min
		c=max-min
		*sat\i=#Factor*c / (1 - Abs(min+max-1))
		If r=max
			*hue\i=60*(g-b)/c
		ElseIf g=max
			*hue\i=60*(b-r)/c+120
		ElseIf b=max
			*hue\i=60*(r-g)/c+240
		EndIf

	Else
		*hue\i=0
		*sat\i=0

	EndIf

EndProcedure

Procedure.f Hue2RGB(v1.f, v2.f, vH.f)
   If vH < 0 : vH + 1 : EndIf
   If vH > 1 : vH - 1 : EndIf
   If (6 * vH) < 1 : ProcedureReturn (v1 + (v2 - v1) * 6 * vH) : EndIf
   If (2 * vH) < 1 : ProcedureReturn v2 : EndIf
   If (3 * vh) < 2 : ProcedureReturn (v1 + (v2 - v1) * ((2.0 / 3.0) - vH) * 6) : EndIf
   
   ProcedureReturn v1
EndProcedure
Procedure.l HSL2RGB2(H.f, S.f, L.f)
   
   Protected.i R, G, B
   Protected.f var_1, var_2
   
   If S = 0
      R = L * 255
      G = L * 255
      B = L * 255
   Else
      If L < 0.5
         var_2 = L * (1 + S)
      Else
         var_2 = (L + S) - (S * L)
      EndIf
         
      var_1 = 2 * L - var_2
     
      R = 255 * Hue2RGB(var_1, var_2, H + (1.0 / 3.0))
      G = 255 * Hue2RGB(var_1, var_2, H)
      B = 255 * Hue2RGB(var_1, var_2, H - (1.0 / 3.0))
   EndIf
   
   ProcedureReturn (R | G<<8 | B<<16)
EndProcedure



Procedure ColorTint2(Color, Level.d) ; Change color tint (-1 <= Level <= 1)
  ; Auteur : Le Soldat Inconnu

	Protected Rouge, Vert, Bleu, Alpha, a.d, Nuance_Blanc, Nuance_Noir, b.d, i, ii
  
	If Level > 0.5
		Level -1
	ElseIf Level < -0.5
		Level + 1
	EndIf
	If Level > 1
		Level = 1
	ElseIf Level < -1
		Level = -1
	EndIf
	
  Rouge = Color & $FF
  Vert = Color >> 8 & $FF
  Bleu = Color >> 16 & $FF
	Alpha = Color >> 24
	
	; Recherche de la teinte
	If Bleu >= Vert And Bleu >= Rouge And Bleu > 0
    a = 255 / Bleu
    Nuance_Noir = 255 - Bleu
    Bleu = 255
    Vert = a * Vert
    Rouge = a * Rouge
	ElseIf Vert >= Bleu And Vert >= Rouge And Vert > 0
    a = 255 / Vert
    Nuance_Noir = 255 - Vert
    Bleu = a * Bleu
    Vert = 255
    Rouge = a * Rouge
	ElseIf Rouge >= Vert And Rouge >= Bleu And Rouge > 0
    a = 255 / Rouge
    Nuance_Noir = 255 - Rouge
    Bleu = a * Bleu
    Vert = a * Vert
    Rouge = 255
	Else
    Nuance_Noir = 255
    Bleu = 255
    Vert = 255
    Rouge = 255
	EndIf
  
  If Bleu < Vert And Bleu < Rouge
    a = 1 - (Bleu / 255)
    Nuance_Blanc = 255 - Bleu
    Vert = (Vert - Bleu) / a
    Rouge = (Rouge - Bleu) / a
    Bleu = 0
	ElseIf Vert < Bleu And Vert < Rouge
    a = 1 - (Vert / 255)
    Nuance_Blanc = 255 - Vert
    Bleu = (Bleu - Vert) / a
    Rouge = (Rouge - Vert) / a
    Vert = 0
	ElseIf Rouge < Bleu And Rouge < Vert
    a = 1 - (Rouge / 255)
    Nuance_Blanc = 255 - Rouge
    Bleu = (Bleu - Rouge) / a
    Vert = (Vert - Rouge) / a
    Rouge = 0
	Else
    Nuance_Blanc = 255
	EndIf
	
	ii = Level * 1530
	If ii > 0
		For i = 1 To ii
			If Rouge = 255 And Vert <> 255 And Bleu = 0
				Vert + 1
			ElseIf Vert = 255 And Rouge <> 0 And Bleu = 0
				Rouge - 1
			ElseIf Vert = 255 And Bleu <> 255 And Rouge = 0
				Bleu + 1
			ElseIf Bleu = 255 And Vert <> 0 And Rouge = 0
				Vert - 1
			ElseIf Bleu = 255 And Rouge <> 255 And Vert = 0
				Rouge + 1
			ElseIf Rouge = 255 And Bleu <> 0 And Vert = 0
				Bleu - 1
			EndIf
		Next
	Else
		ii = -ii
		For i = 1 To ii
			If Bleu = 255 And Vert <> 255 And Rouge = 0
				Vert + 1
			ElseIf Vert = 255 And Bleu <> 0 And Rouge = 0
				Bleu - 1
			ElseIf Vert = 255 And Rouge <> 255 And Bleu = 0
				Rouge + 1
			ElseIf Rouge = 255 And Vert <> 0 And Bleu = 0
				Vert - 1
			ElseIf Rouge = 255 And Bleu <> 255 And Vert = 0
				Bleu + 1
			ElseIf Bleu = 255 And Rouge <> 0 And Vert = 0
				Rouge - 1
			EndIf
		Next
	EndIf
	
  a = 1 - Nuance_Blanc / 255
  b = (255 - Nuance_Noir) / 255
  Rouge = (Rouge + (255 - Rouge) * a) * b
  If Rouge < 0
    Rouge = 0
	ElseIf Rouge > 255
    Rouge = 255
	EndIf
  Vert = (Vert + (255 - Vert) * a) * b
  If Vert < 0
    Vert = 0
	ElseIf Vert > 255
    Vert = 255
	EndIf
  Bleu = (Bleu + (255 - Bleu) * a) * b
  If Bleu < 0
    Bleu = 0
	ElseIf Bleu > 255
    Bleu = 255
	EndIf
	
	ProcedureReturn (Rouge | Vert <<8 | Bleu << 16 | Alpha << 24)
EndProcedure
Procedure Image_transform(img,transform=0,value=20,fixed=0,min=0,luminosity=1, saturation=0)
  
  UseNewTechnic = CHG_Options\TechnicForColoring
  
  Debug UseNewTechnic
  
  
  ; to transform an image
  ; transform = 0 : miror vertical
  ; transform = 1 :  miror h
  ; transform = 2 : change color
  
  If IsImage(img)
    w = ImageWidth(img)
    h = ImageHeight(img) 
    
    If transform = 0 
      ;{ mirorV
      NewImg = CreateImage(#PB_Any, w, h, 32, #PB_Image_Transparent)
      If NewImg
        If StartDrawing(ImageOutput(NewImg))
          DrawingMode(#PB_2DDrawing_AlphaBlend)
          For x = w - 1 To 0 Step -1
            StripeImg = GrabImage(Img, #PB_Any, x, 0, 1, h)
            If StripeImg
              DrawAlphaImage(ImageID(StripeImg), w - x - 1, 0) 
              FreeImage(StripeImg)
            EndIf
          Next x
          
          StopDrawing()
          
        EndIf
        
        ; FreeImage(img)
      EndIf
      ProcedureReturn NewImg
      ;}
      
    ElseIf transform = 2 
      ;{ change HUE (teinte )
      
      ; on change la teinte
      If fixed
        Level.d = (value+Min)/255
      Else
        value = Random(value)
        Level.d = (value+Min)/255
      EndIf
      c = Value ; (value+Min)
      hue_ = 223 ; value
      satu = saturation
      lumi = luminosity
      ; on enregistre les pixels de l'image
      ; we get the color // on chope la couleur
      
      If StartDrawing(ImageOutput(img))
        DrawingMode(#PB_2DDrawing_AllChannels)
        
        For y = 0 To h - 1
          For x = 0 To w - 1
            color = Point(x, y)
            
            alpha = Alpha(color)
            color2 = RGBA(Red(color),Green(color),Blue(color), alpha)
            ;If( ((color < RGBA(0,0,0,255)  Or color >RGBA(20,20,20,255))Or lumi<0) And alpha >20 ) 
            If color <> 0 And alpha >0
              If UseNewTechnic =0 
                ;{ old
                color1 = ColorTint2(color, Level)
                If color1 < RGBA(250,250,250,alpha)
                  color1 = Brightness(color1, luminosity *0.01)
                EndIf
                Plot(x,y,RGBA(Red(color1),Green(color1),Blue(color1),alpha))
                ;}
              ElseIf UseNewTechnic =1 
                ;{ space
                ; on convertit la couleur actuelle
                RGB2HSL(Red(color),Green(color),Blue(color),@hue,@sat,@lum)
                HSL2RGB(Hue,Sat,Lum,@R,@G,@b)
                color1 = RGBA(r,g,b,alpha)
                If color1 < RGBA(250,250,250,alpha) And (lum >10 Or lumi <=0) ; (color >=RGBA(10,10,10,alpha) Or lumi<0) And lum >10
                  l = Lum+lumi
                  If l<0
                    l=0
                  EndIf
                  HSL2RGB(Hue+c,Sat+satu,l,@R,@G,@b)
                  color1 = RGBA(r,g,b,alpha)
                  ; Debug ""+r+"/"+g+"/"+b
                  Plot(x,y,color1)
                Else
                  ; Plot(x,y,color2)
                EndIf
                ;}
              ElseIf UseNewTechnic =2
                ;{ normal  
                ; on convertit la couleur actuelle en HSL
                RGB2HSL(Red(color),Green(color),Blue(color),@hue,@satu,@lumi)
                ; on transforme la couleur
                HSL2RGB(hue+c,Satu+sat,Lumi+lum,@R,@G,@b)
                color1 = RGBA(r,g,b,alpha)
                Plot(x,y,color1)
                ;}
              EndIf
            EndIf
          Next
        Next
        StopDrawing()
      EndIf
      
      ProcedureReturn value
      ;}
    EndIf
    
  EndIf

EndProcedure
Procedure ResizeImageProportion(image.i,width.u,mode=#PB_Image_Raw)
  ; to resize an image with proportionnal size
  ; exemple 200,100 become 50,100 if width=50
  Protected s.u, w.u, h.u, ok.a, nw.u, nh.u
  s.u = width
  t = image
  w.u = ImageWidth(t)
  h.u = ImageHeight(t)
  If w>h And w>0
    nw.u = s
    nh.u = (h * s)/w
    ok.a =1
  Else
    If h>0
      nh = s
      nw = (w * s)/h
      ok=1
    EndIf
  EndIf
  If ok=1
    ResizeImage(image, nw, nh, mode)
  EndIf
EndProcedure

Procedure GetClicOnImageRotated(mx,my,imagex,imagey,cx.f,cy.f,imageangle,imagew,imageh)
  ; cx = center X of image
  ; cy = center y of image
  ; mx, my = mouse x, y (sometimes, needed to be mousex- viewx/mousey-viewy
  ; imagex/y : position of image (could be or without center, depend of your code)
  ; imageangle : angle of rotation of the image
  ; imagew/h : total size of image (With scale Or other thing)
  
  xa = mx - imagex
  ya = my - imagey
  ; get the cos, sin
  Cos.f = Cos(Radian(-imageangle))
  Sin.f = Sin(Radian(-imageangle))
  ; get the position of the new x/y converted of the mouse
  x.f = Xa*Cos-Ya*Sin +cx
  y.f = Xa*Sin+Ya*Cos +cy
  ; check if the new position is in the image
  If x>=0 And x<=imagew And y>=0 And y<=imageh
    ; Debug "clic on the image"
    ; here, we can do a point(x,y) to verify for example if the alpha() at this position >0 to validate the clic
    ProcedureReturn 1
  EndIf
EndProcedure

Procedure CHG_InitImages()
  ; to load the images & fontfor the program 
  If LoadFont(#FontArial20Bold, "Arial", 20, #PB_Font_Bold) : EndIf
  
  folder$ = GetCurrentDirectory()+"data\editor\"
  If LoadImage(#chg_Img_New,folder$+"new.png") : EndIf
  If LoadImage(#chg_Img_Open,folder$+"open.png") : EndIf
  If LoadImage(#chg_Img_Save,folder$+"save.png") : EndIf
  If LoadImage(#chg_Img_paint,folder$+"paint.png") : EndIf
  If LoadImage(#chg_Img_Select,folder$+"select.png") : EndIf
  If LoadImage(#chg_Img_Move,folder$+"move.png") : EndIf
  If LoadImage(#chg_Img_Scale,folder$+"scale.png") : EndIf
  If LoadImage(#chg_Img_Rotate,folder$+"rotate.png") : EndIf
  If LoadImage(#chg_Img_Propertie,folder$+"properties.png") : EndIf
EndProcedure


;{ unpremultiply
;{ module unpremultiply

CompilerIf #PB_Compiler_Backend = 0
; MOdule by Wilbert
DeclareModule Premultiply
  
  ; 32 bits RGBA or BGRA pixel buffer
  
  Declare PremultiplyPixels(*PixelBuffer32, NumPixels)
  Declare UnpremultiplyPixels(*PixelBuffer32, NumPixels)
  
EndDeclareModule

Module Premultiply
  
  EnableASM
  DisableDebugger
    
  CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
    Macro rax : eax : EndMacro
    Macro rbx : ebx : EndMacro
    Macro rcx : ecx : EndMacro
    Macro rdx : edx : EndMacro
    Macro rsi : esi : EndMacro
  CompilerEndIf
  
  Procedure PremultiplyPixels(*PixelBuffer32, NumPixels)
    LEA rax, [premultiply.l_premultiplyTable]
    MOV rdx, *PixelBuffer32
    MOV rcx, NumPixels
    PUSH rbx
    PUSH rsi
    MOV rsi, rax
    !premultiply.l_premul0:
    MOVZX eax, word [rdx + 2]
    CMP ah, 255
    !je premultiply.l_premul1
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 2], bl
    MOV al, [rdx + 1]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 1], bl
    MOV al, [rdx]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx], bl
    !premultiply.l_premul1:
    ADD rdx, 4
    SUB rcx, 1
    !jnz premultiply.l_premul0
    POP rsi
    POP rbx   
  EndProcedure
  
  Procedure UnpremultiplyPixels(*PixelBuffer32, NumPixels)
    LEA rax, [premultiply.l_premultiplyTable + 0x10000]
    MOV rdx, *PixelBuffer32
    MOV rcx, NumPixels
    PUSH rbx
    PUSH rsi
    MOV rsi, rax
    !premultiply.l_unpremul0:
    MOVZX eax, word [rdx + 2]
    CMP ah, 255
    !je premultiply.l_unpremul1
    CMP ah, 0
    !je premultiply.l_unpremul1
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 2], bl
    MOV al, [rdx + 1]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 1], bl
    MOV al, [rdx]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx], bl
    !premultiply.l_unpremul1:
    ADD rdx, 4
    SUB rcx, 1
    !jnz premultiply.l_unpremul0
    POP rsi
    POP rbx
  EndProcedure
  
  Procedure FillTable()
    LEA rdx, [premultiply.l_premultiplyTable]
    PUSH rbx
    MOV ebx, 255
    SUB ecx, ecx
    !premultiply.l_filltable0:
    MOVZX eax, ch
    MUL cl
    ADD eax, 127
    DIV bl
    MOV [rdx + rcx], al
    ADD cx, 1
    !jnz premultiply.l_filltable0
    ADD rdx, 0x10000
    MOV ecx, 0x100
    SUB bx, bx
    !premultiply.l_filltable1:
    MOV eax, 255
    CMP cl, ch
    !jae premultiply.l_filltable2
    MUL cl
    ADD ax, bx
    DIV ch
    !premultiply.l_filltable2:
    MOV [rdx + rcx], al
    ADD cl, 1
    !jnz premultiply.l_filltable1
    MOVZX bx, ch
    ADD bx, 1
    SHR bx, 1
    ADD ch, 1
    !jnz premultiply.l_filltable1
    POP rbx
  EndProcedure
  
  FillTable()
  
  DataSection
    !premultiply.l_premultiplyTable: times 131072 db 0
  EndDataSection
  
  DisableASM
EndModule

CompilerEndIf
;}

Procedure UnPreMultiplyAlpha(image)
  ; by Chi, english forum
  c = 255
  tmp = CopyImage(image,#PB_Any)
  
  If StartDrawing(ImageOutput(image))
    DrawingMode(#PB_2DDrawing_AllChannels)
    Box(0,0,OutputWidth(),OutputHeight(),RGBA(0,0,0,255))
    DrawAlphaImage(ImageID(tmp),0,0)
    
    DrawingMode(#PB_2DDrawing_AlphaClip)
    Box(0,0,OutputWidth(),OutputHeight(),RGBA(0,0,0,255))
   ; DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(tmp),0,0)
    
    For y=0 To ImageHeight(image)-1
      For x=0 To ImageWidth(image)-1
        color = Point(x, y)
        alpha = Alpha(color)
        
        alpha2 = Alpha(color)
        If alpha=0 : alpha=1 : EndIf
        If alpha2>0
          ;r = (255 * Red(color) + (alpha2 /2)) /alpha
          r = (c * Red(color) ) /alpha
          If r>255
            r=255
          EndIf
          ;g = (255 * Green(color) + (alpha2 /2)) /alpha
          g = (c * Green(color)) /alpha
          If g>255
            g=255
          EndIf
          ;b = (255 * Blue(color) + (alpha2 /2)) /alpha
          b = (c * Blue(color) ) /alpha
          If b>255
            b = 255
          EndIf
          Plot(x, y, RGBA( r, g, b, alpha2))
        Else
          Plot(x, y, RGBA(Red(color), Green(color), Blue(color), alpha2))
        EndIf
      Next
    Next
    StopDrawing()
  EndIf
  
  FreeImage2(tmp)
  
  ; MessageRequester("", "unpremul ok : "+Str(image))
  
  ProcedureReturn image
EndProcedure

;}

;}

;{ Gadgets
Procedure Gadget_AddItems(gad,itemList$,state=0,folder$="",pattern$="*.*",ext_$="",foldertype = #PB_DirectoryEntry_Directory)
  Shared wec_bankimage()
  ; itemList$ = les noms des items (séparés par une ",") Ã  ajouter dans la combobox 
  ; si itemList$ = "", alors, on ajoute les items en fonction des autres parametres : folder$, pattern$...)
  wec_NbItem = -1
  
  If itemList$= #Empty$
    ;{  la liste est vide, on va chercher les infos avec les autres éléments (folder$, pattern$, etc)
    ; Debug folder$
    If ExamineDirectory(0,folder$, pattern$)
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = foldertype
          ;If DirectoryEntrySize(0) > 0
          If DirectoryEntryName(0)<> "." And DirectoryEntryName(0)<> ".."
            ext$ = LCase(GetExtensionPart(DirectoryEntryName(0)))
            ;Debug DirectoryEntryName(0)
            If (ext$ =ext_$) Or foldertype = #PB_DirectoryEntry_Directory
              wec_NbItem +1
              i = wec_NbItem
              ReDim wec_bankimage(i)
              With wec_bankimage(i)
                \Filename$ = folder$+DirectoryEntryName(0)
                \Name$ = DirectoryEntryName(0)
                ; Debug \file$
              EndWith
            EndIf
          EndIf
        EndIf 
      Wend
      FinishDirectory(0)
    EndIf
    ClearGadgetItems(gad)
    For i=0 To ArraySize(wec_bankimage())
      AddGadgetItem(gad, -1,  wec_bankimage(i)\Name$)
    Next
    ;}
  Else
    
    nb = FindString(itemList$, ",")-1
    ClearGadgetItems(gad)
    For i=0 To nb
      t$ = StringField(itemList$,i+1,",")
      ; Debug t$
      If t$ <> ""
        AddGadgetItem(gad,-1,lang(t$))
      EndIf
    Next 
  EndIf
  
  SetGadgetState(gad,state)
EndProcedure
Procedure SetGadgetColor2(gadget,color=-1)
  If color=-1
    b = 150
    c = RGB(b,b,b)
  Else
    c = RGB(color,color,color)
  EndIf
  
  SetGadgetColor(gadget, #PB_Gadget_BackColor, c)
EndProcedure

Procedure AddGadget(id,typ,x,y,w,h,txt$="",min.d=0,max.d=0,tip$="",val.d=-65257,name$=#Empty$)
  
  ; pour ajouter plus facilement un gadget
  w_1 = CHG_Options\PanelW/3
  If name$ <> #Empty$ 
    w1 = w_1
    g = TextGadget(#PB_Any,x,y,w1,h,name$) 
    If G
      SetGadgetColor2(g)
    EndIf 
    If typ = #Gad_String And txt$ = #Empty$
      txt$ = StrD(val,3)
    EndIf
    
  ElseIf txt$ <>#Empty$  And typ <= #Gad_String 
    w1 = w_1
    g = TextGadget(#PB_Any,x,y,w1,h,txt$) 
    If G
      SetGadgetColor2(g)
    EndIf 
  EndIf
  
  Select typ
    Case #Gad_spin
      If SpinGadget(id, x+w1,y,w,h,min,max,#PB_Spin_Numeric) : EndIf
      
    Case #Gad_String
      If min =1
        If StringGadget(id, x+w1,y,w,h,txt$,#PB_String_Numeric) : EndIf
      ElseIf val = #PB_String_ReadOnly Or min = 2
        If StringGadget(id, x+w1,y,w,h,txt$,#PB_String_ReadOnly) : EndIf  
      Else
        ;Debug txt$
        If StringGadget(id, x+w1,y,w,h,txt$) : EndIf                
      EndIf
      
    Case #Gad_Btn
      If min = 1
        If ButtonGadget(id,x+w1,y,w,h,txt$,#PB_Button_Toggle)  : EndIf    
      Else
        If ButtonGadget(id,x+w1,y,w,h,txt$)  : EndIf    
      EndIf
      
    Case #Gad_BtnImg
      If min = 1
        If ButtonImageGadget(id,x+w1,y,w,h,ImageID(max),#PB_Button_Toggle)  : EndIf    
      Else
        If ButtonImageGadget(id,x+w1,y,w,h,ImageID(max))  : EndIf    
      EndIf
      
    Case #Gad_Chkbox
      If CheckBoxGadget(id,x+w1+2,y,w,h,txt$) : EndIf    
      
    Case #Gad_Cbbox
      If ComboBoxGadget(id,x+w1,y,w,h) : EndIf    
      
    Case #Gad_ListV
      If ListViewGadget(id,x+w1,y,w,h) : EndIf    
      
  EndSelect
  
  If tip$ <> #Empty$      
    If IsGadget(id)
      GadgetToolTip(id,tip$)
    EndIf
  EndIf
  
  If val <> -65257
    If typ = #Gad_String
      If txt$ = #Empty$
        SetGadgetText(id,StrD(val))
      EndIf
    Else
      SetGadgetState(id,val)
    EndIf
  EndIf
  
EndProcedure

; canvas (center of image)
Procedure CHG_UpdateCanvasCenterImage(resizecanvas=0)
  Shared CHG_BankImageID
  If resizecanvas
    ResizeGadget(#G_WinCHG_Bank_CanvasObjCenter,0,0,BankImages(CHG_BankImageID)\w+500,BankImages(CHG_BankImageID)\h+500)
    SetGadgetAttribute(#G_WinCHG_Bank_SaObjCenter,#PB_ScrollArea_InnerWidth,BankImages(CHG_BankImageID)\w+500)
    SetGadgetAttribute(#G_WinCHG_Bank_SaObjCenter,#PB_ScrollArea_InnerHeight,BankImages(CHG_BankImageID)\h+500)
  EndIf
  
  If StartDrawing(CanvasOutput(#G_WinCHG_Bank_CanvasObjCenter))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    w = OutputWidth()
    h = OutputHeight()
    img = BankImages(CHG_BankImageID)\ImageOrigin
    Box(0,0,w,h,RGBA(150,150,150,255))
    DrawAlphaImage(ImageID(img),0,0)
    ; draw line
    w= ImageWidth(img)
    h = ImageHeight(img)
    c.q = RGBA(50,50,50,100)
    Box(w/2,0,2,h,c)
    Box(0,h/2,w,2,c)
     DrawingMode(#PB_2DDrawing_Outlined)
   Box(0,0,w,h,c)
    ; draw center
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    Box(BankImages(CHG_BankImageID)\cx-1,BankImages(CHG_BankImageID)\cy-1,7,7,RGBA(0,0,0,255))
    Box(BankImages(CHG_BankImageID)\cx,BankImages(CHG_BankImageID)\cy, 5,5,RGBA(255,0,0,255))
    StopDrawing()
  EndIf
EndProcedure
Procedure CHG_EventCanvasCenterImage()
  Shared CHG_BankImageID

  ; event for the canvas "center image"
  gad = #G_WinCHG_Bank_CanvasObjCenter
  If EventType() = #PB_EventType_LeftButtonDown Or (EventType() = #PB_EventType_MouseMove And                         
      GetGadgetAttribute(gad, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
    
    px = GetGadgetAttribute(gad, #PB_Canvas_MouseX)
    py = GetGadgetAttribute(gad, #PB_Canvas_MouseY) 
    
    w = GadgetWidth(gad)
    h = GadgetHeight(gad)
    
    ;Debug "bank image name: "+BankImages(CHG_BankImageID)\Name$
    ;Debug "CHG_BankImageCenter : "+Str(ArraySize(CHG_BankImageCenter()))
    
    For k= 0 To ArraySize(CHG_BankImageCenter())
      If BankImages(CHG_BankImageID)\Name$= CHG_BankImageCenter(k)\ImageName$
        ; Debug "ok trouvé :"+CHG_BankImageCenter(k)\ImageName$
        trouve = 1
        Break
      EndIf
    Next  
    ; on update les centres
    BankImages(CHG_BankImageID)\cx = px
    BankImages(CHG_BankImageID)\cy = py
    If trouve = 1 ; k>-1 And k<=ArraySize(CHG_BankImageCenter())
      CHG_BankImageCenter(k)\cx = px 
      CHG_BankImageCenter(k)\cy = py
    Else
      ; on ajoute dans CHG_BankImageCenter() l'image
      k = ArraySize(CHG_BankImageCenter())+1
      ReDim CHG_BankImageCenter(k)
      CHG_BankImageCenter(k)\Folder$ = GetGadgetText(#G_WinCHG_Bank_ListFolderImage)
      CHG_BankImageCenter(k)\ImageName$ = BankImages(CHG_BankImageID)\Name$
      CHG_BankImageCenter(k)\cx = px 
      CHG_BankImageCenter(k)\cy = py
     
    EndIf
    CHG_SaveObjectCenter()
    
    ; on update tous les part avec ce centre
    For i=0 To ArraySize(Character(0)\part())
      With Character(0)\part(i)
        If \filename$ = BankImages(CHG_BankImageID)\Name$
          \cx = px
          \cy = py
        EndIf
      EndWith
    Next
    
    CHG_UpdateCanvasCenterImage()
    WindowCharacterEditor_updatecanvas()  
  EndIf
  
EndProcedure

; canvas (images from folder (part))
Procedure CHG_EventCanvasImageObject()
  Shared Px, py, wcp, hcp,CHG_BankImageID, folder$
  a = 64
  gad = #G_WinCHG_Bank_CanvasPreviewObject
  ev_t =  EventType()
  If ev_t= #PB_EventType_LeftButtonDown Or ev_t = #PB_EventType_LeftDoubleClick 
    px = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/a 
    py = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/a  
    If py>hcp
      py=hcp
    EndIf
    If px >wcp
      px = wcp
    EndIf
    If ev_t = #PB_EventType_LeftDoubleClick 
      CHG_SetCharacterPartImage(1,0,GetGadgetText(#G_WinCHG_Bank_ListFolderImage),BankImages(CHG_BankImageID)\Name$)
      ; update the main canvas
      WindowCharacterEditor_updatecanvas() 
    Else
      FreeImage2(#CHG_image_Drag)
      ImageFolder$ = folder$ +"images\"
      obj$ = GetGadgetText(#G_WinCHG_Bank_ListFolderImage)
      file$ = ImageFolder$+obj$+"\"+BankImages(CHG_BankImageID)\Name$
      If LoadImage(#CHG_image_Drag,file$)
        DragImage(ImageID(#CHG_image_Drag))
      EndIf
    EndIf
    
    CHG_UpdateCanvasImageObject()
    CHG_UpdateCanvasCenterImage(1)
  EndIf
  
EndProcedure
Procedure CHG_UpdateCanvasImageObject()
  Protected x,y
  Shared Px, py, wcp, hcp,CHG_BankImageID
  a=64
  a1=a+2
  If StartDrawing(CanvasOutput(#G_WinCHG_Bank_CanvasPreviewObject))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    w = OutputWidth()
    h = OutputHeight()
    
    Box(0,0,w,h,RGBA(150,150,150,255))
    b = w/a
    wcp= b-1
    For i=0 To ArraySize(BankImages())
      If IsImage(BankImages(i)\Image)
        x = Mod(i,b)
        x*a1
        y = (i/b)
        y*a1
        Box(x,y,a,a,RGBA(180,180,180,255))
        DrawAlphaImage(ImageID(BankImages(i)\Image),x,y)
      EndIf
      
    Next
    If b>i-1
      wcp = i-1
    EndIf
    
    hcp = (i-1)/b
    DrawingMode(#PB_2DDrawing_Outlined)
    Box(px*a1,py*a1,a,a,RGBA(255,0,0,255))
    CHG_BankImageID = px + py *b 

    StopDrawing()
  EndIf
  
EndProcedure

Procedure CHG_UpdateTemplateList()
  ;For i=0 To ArraySize(BankTemplates())
    ;itemList$ + BankTemplates(i)\Name$ +","
  ;Next 
  ;   Gadget_AddItems(#G_WinCHG_Bank_TemplateSelect,itemlist$,CHG_BankTemplateId)
  gad = #G_WinCHG_Bank_TemplateSelect
  If IsGadget(gad)
    ClearGadgetItems(gad)
    For i=0 To ArraySize(BankTemplates())
      AddGadgetItem(gad,-1,lang(BankTemplates(i)\Name$))
    Next 
    SetGadgetState(gad,0)
  EndIf
EndProcedure

; update list (folders of images, and list of images from current folder)
Procedure CHG_UpdatePartlist()
  ; to update the part list
  ClearGadgetItems(#G_WinCHG_Edit_SelectPart)
  For i=0 To ArraySize(Character(CHG_CharacterID)\part())
    AddGadgetItem(#G_WinCHG_Edit_SelectPart,i,Character(CHG_CharacterID)\part(i)\Name$ )
  Next
  SetGadgetState(#G_WinCHG_Edit_SelectPart, CHG_ObjID)
EndProcedure

Procedure CHG_UpdateListImageFromFolder(name$="")
  ; on mets Ã  jour la liste des images en fonction du dossier choisi
  ; name$ , cest le nom du dossier (exemple : hear, eye, etc)
  Shared folder$, CHG_BankImageID, Px, py
  CHG_BankImageID = 0
  If name$ = ""
    If IsGadget(#G_WinCHG_Bank_ListFolderImage)
      name$ = GetGadgetText(#G_WinCHG_Bank_ListFolderImage)
    EndIf
  Else
    For i=0 To ArraySize(BankFolderImages())
      If BankFolderImages(i)\Name$ = name$
        SetGadgetState(#G_WinCHG_Bank_ListFolderImage,i)
        Break
      EndIf
    Next
  EndIf
  
  If name$ <> ""
  dir$ = folder$+"images\"+name$+"\"
  ; Debug dir$
  n=-1
  If ExamineDirectory(0, dir$, "*.*")
    While NextDirectoryEntry(0)
      If DirectoryEntryType(0) = #PB_DirectoryEntry_File
        name$ = DirectoryEntryName(0)
        filename$ = dir$+name$
        If FileSize(filename$) >0
          n+1
          i = n
          ReDim BankImages(i)
          With BankImages(i)
            \filename$ = filename$
            \Name$ = DirectoryEntryName(0) 
            \Image = LoadImage(#PB_Any, filename$)
            \ImageOrigin =CopyImage(\image, #PB_Any)
            w = ImageWidth(\image)
            h = ImageHeight(\image)
            
            ; on resize l'image
            ResizeImageProportion(\Image,64,#PB_Image_Smooth)
            neww= ImageWidth(\image)
            newh= ImageHeight(\image)
            
            BankImages(i)\w = w
            BankImages(i)\h = h
            
            For k=0 To ArraySize(CHG_BankImageCenter())
              If CHG_BankImageCenter(k)\ImageName$ = \name$
                 CHG_BankImageCenter(k)\w = w
                 CHG_BankImageCenter(k)\h = w
                 ;                 cx.d = CHG_BankImageCenter(k)\cx /w
                 ;                 \cx = cx * neww
                 ;                 cy.d = CHG_BankImageCenter(k)\cy /h
                 ;                 \cy = cy * newh
                 \cx = CHG_BankImageCenter(k)\cx
                 \cy = CHG_BankImageCenter(k)\cy
                Break
              EndIf
            Next
          EndWith
          ; Debug filename$
        EndIf
      EndIf
    Wend
    FinishDirectory(0)
  EndIf
  ; update canvas preview image
  px = 0
  py = 0
  CHG_UpdateCanvasImageObject()
  CHG_UpdateCanvasCenterImage(1)
  EndIf
EndProcedure
Procedure CHG_UpdateListFolderImages()
  ; Pour mettre à jour la liste des dossier contenus dans le dossier \image
  Shared folder$
  If IsGadget(#G_WinCHG_Bank_ListFolderImage)
    ClearGadgetItems(#G_WinCHG_Bank_ListFolderImage)
  EndIf
  
  dir$ = folder$+"images\"
  n=-1
  If ExamineDirectory(0, dir$, "*.*")
    While NextDirectoryEntry(0)
      If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
        name$ = DirectoryEntryName(0)
        If name$ <> "." And name$<> ".."
          n+1
          i = n
          ReDim BankFolderImages(i)
          BankFolderImages(i)\filename$ = DirectoryEntryName(0) 
          BankFolderImages(i)\Name$ = DirectoryEntryName(0) 
          ; Debug BankTemplates(i)\filename$
        EndIf
      EndIf
    Wend
    FinishDirectory(0)
  EndIf
  
  ; je trie par ordre alphabétique :
  SortStructuredArray(BankFolderImages(), #PB_Sort_Ascending|#PB_Sort_NoCase, OffsetOf(sFile\Name$), TypeOf(sFile\Name$))

  ; puis, j'ajoute les noms au combobox
  If IsGadget(#G_WinCHG_Bank_ListFolderImage)
    For i=0 To ArraySize(BankFolderImages())
      AddGadgetItem(#G_WinCHG_Bank_ListFolderImage,i,BankFolderImages(i)\Name$ )
    Next
    SetGadgetState(#G_WinCHG_Bank_ListFolderImage, 0)
  EndIf
EndProcedure
Procedure CHG_UpdateProjectFolder(updateprojectfolder=1,id=0)
  ; on mets a  jour la liste des dossiers contenu dans "data\projects\"
  Shared folder$, CHG_BankImageID
  CHG_BankImageID = 0

  dir$ = "data\projects\"
  ; Debug dir$
  n=-1
  If ExamineDirectory(0, dir$, "*.*")
    While NextDirectoryEntry(0)
      If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
        name$ = DirectoryEntryName(0)
        filename$ = dir$+name$
        If name$<>"." And name$<>".."
          n+1
          i = n
          ReDim BankProjectFolder(i)
          With BankProjectFolder(i)
            \filename$ = filename$
            \Name$ = DirectoryEntryName(0) 
          EndWith
          ; Debug filename$
        EndIf
      EndIf
    Wend
    FinishDirectory(0)
  EndIf
  
;   For i=0 To ArraySize(BankProjectFolder())
;     Debug BankProjectFolder(i)\Name$
;   Next
  
;   Debug "je trie :"
  ; Je trie pour afficher en par ordre alphabetique
  SortStructuredArray(BankProjectFolder(), #PB_Sort_Ascending|#PB_Sort_NoCase, OffsetOf(sFile\Name$), TypeOf(sFile\Name$))
;   For i=0 To ArraySize(BankProjectFolder())
;     Debug BankProjectFolder(i)\Name$
;     Debug BankProjectFolder(i)\Filename$
;   Next

  ; on met à jour le gadgetlist des projetfolder
  ClearGadgetItems(#G_WinCHG_Bank_ProjectFolder)
  For i=0 To ArraySize(BankProjectFolder())
    AddGadgetItem(#G_WinCHG_Bank_ProjectFolder,i,BankProjectFolder(i)\Name$)
  Next
      
      
  ; on met à jour le folder du projet
  If updateprojectfolder=1
    
;     Debug "le dossier à trouver : "+ CHG_Options\FolderProject$
    If id=-1
;       Debug "on doit trouver l'id de ce dossier dans la liste."
      For i=0 To ArraySize(BankProjectFolder())
        If CHG_Options\FolderProject$ = bankProjectFolder(i)\Name$ Or CHG_Options\FolderProject$ = bankProjectFolder(i)\Filename$+"\" 
;           Debug "ok dossier personnage (projet) trouvé dans bankProjectFolder()) "+Str(i)+"/"+bankProjectFolder(i)\Filename$ 
          id = i
          Break
        EndIf
      Next 
    EndIf
    CHG_ProjectFolderID = id
    If CHG_ProjectFolderID<0
      CHG_ProjectFolderID=0
    EndIf
    
    If CHG_ProjectFolderID>=0 And CHG_ProjectFolderID<=ArraySize(BankProjectFolder())
      CHG_Options\FolderProject$ = "data\projects\"+BankProjectFolder(CHG_ProjectFolderID)\Name$+"\"
      Folder$ = CHG_Options\FolderProject$
      
      SetGadgetState(#G_WinCHG_Bank_ProjectFolder,CHG_ProjectFolderID)
      
      ; update all is needed
      CHG_OpenObjectCenter()
      CHG_UpdateListFolderImages()
      CHG_UpdateListImageFromFolder()
      CHG_PreLoadTemplatesBank()
      CHG_UpdateTemplateList()
    EndIf
  Else
    ; sinon, on met à jour le gadget projectfolder en fonction d enotre dossier de projet
    For i=0 To ArraySize(BankProjectFolder())
      If BankProjectFolder(i)\Filename$ = folder$
        CHG_ProjectFolderID = i
        Break
      EndIf
    Next
    SetGadgetState(#G_WinCHG_Bank_ProjectFolder,CHG_ProjectFolderID)

  EndIf
  

EndProcedure

; canvas colors
Procedure CHG_UpdateCanvasColors()
  ; to update the colors of the project
  s=32
  s1 = s+2
  If StartDrawing(CanvasOutput(#G_WinCHG_Color_CanvasColor))
    w = OutputWidth()
    h = OutputHeight()
    c=150
    Box(0,0,w,h,RGB(c,c,c))
    w1=w/s1-1
    If CHG_ColorId>=0
    For i=0 To ArraySize(Character(0)\Color())
      x = Mod(i,w1)
      y = i/w1
      DrawingMode(#PB_2DDrawing_Default)
      c= Character(0)\Color(i)\Hue
      satur= Character(0)\Color(i)\Saturation
      lumi= Character(0)\Color(i)\Luminosity
      ;Debug level
      color = RGBA(255,223,180,255)
      ;color1 = Brightness(color1, 0.80)
      ; color1 = ColorTint2(color1, level)
      RGB2HSL(Red(color),Green(color),Blue(color),@hue,@sat,@lum)
      HSL2RGB(Hue+c,Sat+(satur/100),Lum+(lumi/100),@R,@G,@b)
      ;color1 = HSL2RGB2(Hue+c,Sat+(satur/100),Lum+(lumi/100))
      ; Debug ""+r+"/"+g+"/"+b
      color1 = RGBA(r,g,b,255)

      ;Debug color1
      Box(1+x*s1,1+y*s1,s,s, RGBA(Red(color1),Green(color1),Blue(color1),255))
      If i = CHG_ColorId
        DrawingMode(#PB_2DDrawing_Outlined)
        Box(x*s1,y*s1,s+2,s+2,RGBA(0,0,0,255))
        Box(1+x*s1,1+y*s1,s,s,RGBA(255,255,255,255))
      EndIf
      
    Next
    EndIf
    StopDrawing()
  EndIf
  
  ; set the color to the elements which use it
  u = CHG_ObjID
  For i=0 To ArraySize(character(0)\Color())
    For k=0 To ArraySize(character(0)\part())
      With character(0)\part(k)
        If \ColorType = i
          CHG_ObjID = k
          CHG_SetCharacterPartImage(2)
        EndIf
        
      EndWith
    Next
  Next
  CHG_ObjID = u
EndProcedure
Procedure CHG_EventCanvasColors()
  ; pour savoir qu'elle couleur on sélectionne
  gad = #G_WinCHG_Color_CanvasColor
  s=32
  s1 = s+1
  If EventType() = #PB_EventType_LeftButtonDown
    x = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/s
    y = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/s
    w=GadgetWidth(gad)
    w1=w/s1-1
    CHG_ColorId = x+y*w1
    If CHG_ColorId> ArraySize(Character(0)\Color())
      CHG_ColorId = ArraySize(Character(0)\Color())
    EndIf
    SetGadgetState(#G_WinCHG_Color_Hue, Character(0)\Color(CHG_ColorId)\Hue)
    SetGadgetState(#G_WinCHG_Color_Luminosity, Character(0)\Color(CHG_ColorId)\Luminosity)
    SetGadgetState(#G_WinCHG_Color_Saturation, Character(0)\Color(CHG_ColorId)\Saturation)
     CHG_UpdateCanvasColors()
  EndIf
  
EndProcedure

; Create all the gadgets
Procedure CHG_CreateTheGadgets()
  
  ;   Pour créer les gadgets sur la fenetre principale
  winW = WindowWidth(#Win_CHG_CharacterEditor)
  winH = WindowHeight(#Win_CHG_CharacterEditor)
  ; toolbar
  wb = 25
  htb=wb+4
  ; other gadgets
  w1 = CHG_Options\PanelW 
  w2 = winW-w1-20 : w3 = 80 : w4=120 : w5 = 150
  h2 = winh-60-MenuHeight()-Htb :  h1 = 20
  a=2 :  wp = w1-10-a*2
  
  ; Toolbar en haut
  If ContainerGadgetR(#G_WinCHG_TbCont,0,0,winw,htb,#PB_Container_BorderLess,0,0,0,1)
    AddLangComment("**** Toolbar ****")
    c=150 : SetGadgetColor2(#G_WinCHG_TbCont, 200)
    x = 5 : y = 2
    AddGadget(#G_WinCHG_TbNew,   #Gad_BtnImg,x,y,wb,wb,"",0,#chg_Img_new,Lang("Create a new document")) : x+wb+a
    AddGadget(#G_WinCHG_Tbopen,  #Gad_BtnImg,x,y,wb,wb,"",0,#chg_Img_Open,Lang("Open a document")) : x+wb+a
    AddGadget(#G_WinCHG_TbSave,  #Gad_BtnImg,x,y,wb,wb,"",0,#chg_Img_Save,Lang("Save the document")) : x+wb+15
    AddGadget(#G_WinCHG_TbAdd,   #Gad_BtnImg,x,y,wb,wb,"",1,#chg_Img_paint,Lang("Add an object on the canvas")) : x+wb+a
    AddGadget(#G_WinCHG_TbSelect,#Gad_BtnImg,x,y,wb,wb,"",1,#chg_Img_Select,Lang("Select an object")) : x+wb+a
    AddGadget(#G_WinCHG_TbMove,  #Gad_BtnImg,x,y,wb,wb,"",1,#chg_Img_Move,Lang("Move an object")) : x+wb+a
    AddGadget(#G_WinCHG_TbScale, #Gad_BtnImg,x,y,wb,wb,"",1,#chg_Img_Scale,Lang("Scale an object")) : x+wb+a
    AddGadget(#G_WinCHG_TbRotate,#Gad_BtnImg,x,y,wb,wb,"",1,#chg_Img_Rotate,Lang("Rotate an object")) : x+wb+a
    CloseGadgetListR()
  EndIf
  
  ; panel left (pnaelgadget à gauche : bank image, propertie et colors)
  If ContainerGadgetR(#G_WinCHG_ContPanelL, 0, htb, w1-5, h2, #PB_Container_BorderLess,0,0,0,1)
    AddLangComment("**** Panel Left ****")
      id = #G_WinCHG_PanelL
      If PanelGadgetR(id,0,0,w1,h2 ,0,0,0,1)
        y = 5 
        AddGadgetItem(id, -1, Lang("Bank", "* Bank *"))
        ;{ bank
        x=5
        AddGadget(#G_WinCHG_Bank_ProjectFolder,#Gad_Cbbox,x,y,w4,h1,"",0,0,Lang("The folder for character image")) : y+h1+a
        CHG_UpdateProjectFolder(0)
        
        AddGadget(#G_WinCHG_Bank_TemplateSelect,#Gad_Cbbox,x,y,w4,h1,"",0,0,Lang("Select The template file")) : x+w4+5
        CHG_UpdateTemplateList()
        ; AddGadget(#G_WinCHG_Bank_TemplateNew, #Gad_BtnImg, x,y,h1,h1,"",0,#chg_Img_new,lang("Create a new template.")) : x+H1+a
        AddGadget(#G_WinCHG_Bank_TemplateSave, #Gad_BtnImg, x,y,h1,h1,"",0,#chg_Img_Save,lang("Save the current template.")) : y+h1+a; : x+H1+a
        x=5
        AddGadget(#G_WinCHG_Bank_ListFolderImage,#Gad_Cbbox,x,y,w4,h1,"",0,0,Lang("Select The images folder for the current element")) : x+w4+5
        CHG_UpdateListFolderImages()
        AddGadget(#G_WinCHG_Bank_AddObject, #Gad_Btn, x,y,h1,h1,"+",0,0,lang("Add a new object element.")) : y+h1+5
        x=5
        
        ; canvas for preview images from folder (part)
        hcpo= 250
        If ScrollAreaGadget(#G_WinCHG_Bank_SA,a,y,wp,hcpo,w1-35-a*2,h2+200)
          If CanvasGadget(#G_WinCHG_Bank_CanvasPreviewObject,0,0,wp-25,h2+200) : EndIf
          CloseGadgetList()
          y+hcpo+5
        EndIf
          
        ; canvas for center image
        AddGadget(#G_WinCHG_Bank_CanvasObjCenterSet, #Gad_BtnImg,5,y,h1,h1,"",0,#chg_Img_Propertie,lang("Define the center for image.")) : y+h1+a
        If ScrollAreaGadget(#G_WinCHG_Bank_SAObjCenter,a,y,wp,wp,w1-35-a*2,h2+200) 
          If CanvasGadget(#G_WinCHG_Bank_CanvasObjCenter,0,0,w5,w5) : EndIf 
          CloseGadgetList()
        EndIf
        y+h1+10
        
          CHG_UpdateProjectFolder(1,-1)
          ; update list of images and canvas (preview & center)
          CHG_UpdateListImageFromFolder()
          
        ;}
        AddGadgetItem(id, -1, Lang("Properties","* Properties *"))
        ;{ properties
        ; combobox : type (humain, alien, house...
        ; combobox gabarit (si humain : homme/femme petit, trapu, ado, enfant6ans, enfant 9 ans, 12 ans, 15, 18ans...)
        ; combox : yeux/oreilles/bouche ?
        ; ou gadget ?
        wp = w1-10-a*2
        y = 10 
        ScrollAreaGadgetR(#G_WinCHG_SA,a,a, wp,h2-a*2-40,w1-35-a*2,h2+200 ,1,0,0,0,0,1)
        If FrameGadget(#PB_Any, 5,5,wp-10,(h1+a)*2+20,lang("Object select"))
          x=10 : y+15
          AddGadget(#G_WinCHG_Edit_SetTemplate,#Gad_Cbbox,x,y,w3,h1,lang("Object"),0,0,Lang("Select the object to edit (character or template)"),0,lang("Object")) : y+h1+a
          Gadget_AddItems(#G_WinCHG_Edit_SetTemplate,"Character,Template,",0)
          AddGadget(#G_WinCHG_Edit_SelectPart,#Gad_Cbbox,x,y,w3,h1,lang("Element"),0,0,Lang("Select the part (element) to edit"),0,lang("Element")) : y+h1+30
          CHG_UpdatePartList()
         EndIf 
         
        If FrameGadget(#PB_Any, 5,y,wp-10,(h1+a)*13+20,lang("Properties"))
            x=10 : y+15
          AddGadget(#G_WinCHG_Edit_Name,#Gad_String,x,y,w3,h1,lang("Name"),0,0,Lang("The Name of the element"),0,lang("Name")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_ImageName,#Gad_String,x,y,w3,h1,lang("Image"),0,0,Lang("The image file"),0,lang("Image")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_ObjName,#Gad_String,x,y,w3,h1,lang("Folder"),0,0,Lang("The folder"),0,lang("Folder")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_Clone,#Gad_String,x,y,w3,h1,lang("Clone"),0,0,Lang("Use this object as clone-image (use the same image as clone)"),0,lang("Clone")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_X,#Gad_spin,x,y,w3,h1,lang("X"),-100000,100000,Lang("X position"),0,lang("X")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_Y,#Gad_spin,x,y,w3,h1,lang("Y"),-100000,100000,Lang("Y position"),0,lang("Y")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_w,#Gad_spin,x,y,w3,h1,lang("Width"),1,10000,Lang("width")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_h,#Gad_spin,x,y,w3,h1,lang("Height"),1,10000,Lang("Height")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_ColorType,#Gad_Spin,x,y,w3,h1,lang("Color group"),0,1000,Lang("Set the color groupe")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_scale,#Gad_spin,x,y,w3,h1,lang("Scale"),1,10000,Lang("Scale of the element")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_Depth,#Gad_spin,x,y,w3,h1,lang("Depth"),0,100000,Lang("Depth of the element")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_alpha,#Gad_spin,x,y,w3,h1,lang("Transparency"),0,255,Lang("Transparency of the element")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_Miror,#Gad_Chkbox,x,y,w3,h1,lang("Miror"),0,0,Lang("Miror the element (horizontaly)"),0, lang("Miror")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_Rotate,#Gad_spin,x,y,w3,h1,lang("Rotation"),-10000,10000,Lang("Rotation of the element"),0, lang("Rotation")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_hide,#Gad_Chkbox,x,y,w3,h1,lang("Hide"),0,0,Lang("Hide the element"),0, lang("Hide")) : y+h1+a
          AddGadget(#G_WinCHG_Edit_locked,#Gad_Chkbox,x,y,w3,h1,lang("locked"),0,0,Lang("locked the element"),0, lang("locked")) : y+h1+a
        EndIf
        ; AddGadgetItem(id, 1, "Options")
        CloseGadgetListR()
        ;}
        AddGadgetItem(id, -1, Lang("Colors","* Colors *"))
        ;{ colors & BG
        y = 10
        x=5
        AddGadget(#G_WinCHG_Color_SetBG,#Gad_Btn,x,y,w3,h1,lang("Set BGColor"),0,0,Lang("Set the Background color"),0,lang("Set Bg Color")) : y+h1+a
        AddGadget(#G_WinCHG_Color_UseBG,#Gad_Chkbox,x,y,w3,h1,lang("Use BG"),0,0,
                  Lang("Use the Background color (rendering and image)"),chg_options\UseBG,lang("Use Bg")) : y+h1+a
        y+10
        AddGadget(#G_WinCHG_Color_TechnicUsed, #Gad_Cbbox, x,y,w3,h1,"",0,0,lang("Choose the technic For coloring."),0,lang("Color Technic")) : y+h1+a
        AddGadgetItem(#G_WinCHG_Color_TechnicUsed,-1, "Special (slow)")
        AddGadgetItem(#G_WinCHG_Color_TechnicUsed,-1, "Normal")
        SetGadgetState(#G_WinCHG_Color_TechnicUsed,CHG_Options\TechnicForColoring)
        x=5
        AddGadget(#G_WinCHG_Color_Hue, #Gad_spin, x,y,w3,h1,lang("Hue"),-600,360,lang("Set the current HUE color.")) : y+h1+a
        AddGadget(#G_WinCHG_Color_Saturation, #Gad_spin, x,y,w3,h1,LAng("sat"),-1000,1000,lang("Set the current Saturation color.")) : y+h1+a
        AddGadget(#G_WinCHG_Color_Luminosity, #Gad_spin, x,y,w3,h1,Lang("Lum"),-1000,1000,lang("Set the current luminosity color.")) : y+h1+a
        AddGadget(#G_WinCHG_Color_Name, #Gad_String, x,y,w3,h1,Lang("Name"),0,0,lang("Set the name for the color.")) : y+h1+a
        x=5
        
        ; les couleurs
        h3 =150
        If ScrollAreaGadget(#G_WinCHG_Color_SA,x,y,wp-10,h3,wp-35,h3)
          CanvasGadget(#G_WinCHG_Color_CanvasColor,0,0,wp,h3)
          CHG_updateCanvasColors()
          CloseGadgetList()
        EndIf
        
        ; boutons:  create new colors
        y+h3+a
        AddGadget(#G_WinCHG_Color_NewColor, #Gad_BtnImg, x,y,h1,h1,"",0,#chg_Img_New,lang("Create a new color.")) : x+H1+a

        ;}
        CloseGadgetListR()
      EndIf
      CloseGadgetListR()
    EndIf
    
    ;     CanvasGadgetR(#G_WinCHG_CanvasMain,X,5,W2,H2,0,0,1,0,1)
    x = w1+5
    CanvasGadgetR(#G_WinCHG_CanvasMain,x,htb+5,W2,H2-15,#PB_Canvas_Keyboard ,0,1,0,1)
    EnableGadgetDrop(#G_WinCHG_CanvasMain, #PB_Drop_Image, #PB_Drag_Copy)
    EnableGadgetDrop(#G_WinCHG_CanvasMain,#PB_Drop_Text,#PB_Drag_Copy)

    ;     ; Add 2 buttons
    ;     w1 = WindowWidth(win)
    ;     h1 = WindowHeight(win)
    ;     h=30
    ;     w=80
    ;     ButtonGadgetR(#G_Win_BtnOk, w1-w-10, h1-h-5, w, h, Lang("Ok"),0,1,0,1,0)
    ;     ButtonGadgetR(#G_Win_BtnCancel, w1-(w+10)*2, h1-h-5, w, h, Lang("Cancel"),0,1,0,1,0)

EndProcedure

; Set (gadget, propertie, image)
Procedure CHG_SetGadgetState()
  If CHG_GetCHG_ObjIDIsOk()
    With Character(CHG_CharacterID)\part(CHG_ObjID)
      \Selected = 1
        SetGadgetText(#G_WinCHG_Edit_ImageName,\filename$)
        SetGadgetText(#G_WinCHG_Edit_Name,\name$)
        SetGadgetText(#G_WinCHG_Edit_ObjName,\obj$)
        SetGadgetText(#G_WinCHG_Edit_Clone,\Clone$)
        SetGadgetState(#G_WinCHG_Edit_X,\x)
        SetGadgetState(#G_WinCHG_Edit_Y,\y)
        SetGadgetState(#G_WinCHG_Edit_h,\h)
        SetGadgetState(#G_WinCHG_Edit_w,\w)
        SetGadgetState(#G_WinCHG_Edit_scale,\Scale)
        SetGadgetState(#G_WinCHG_Edit_alpha,\Alpha)
        SetGadgetState(#G_WinCHG_Edit_depth,\Depth)
        SetGadgetState(#G_WinCHG_Edit_Rotate,\Rotation)
        SetGadgetState(#G_WinCHG_Edit_Miror,\Miror)
        SetGadgetState(#G_WinCHG_Edit_ColorType,\ColorType)
        SetGadgetState(#G_WinCHG_Edit_hide,\Hide)
        SetGadgetState(#G_WinCHG_Edit_locked,\locked)
      EndWith
  EndIf
EndProcedure
Procedure CHG_SetCharacterPartColorImage(part_id)
  ; to change the color of a part
  If Character(0)\OkColor=0
      CHG_SetCharacterColor()
  EndIf
  i=part_id
  img = Character(0)\part(i)\img
  
;   If Character(0)\part(i)\ColorType = 1
;     Image_transform(img,2,Character(0)\skinHue,1,-Character(0)\skinHue*2,Character(0)\SkinBrightness)
;   ElseIf Character(0)\part(i)\ColorType = 2
;     Image_transform(img,2,Character(0)\HairHue,1,-Character(0)\HairHue*2,Character(0)\HairBrightness)
;   Else
    For k=1 To ArraySize(Character(0)\Color())
      If Character(0)\part(i)\ColorType = k
        Image_transform(img,2,Character(0)\Color(k)\Hue,1,-Character(0)\Color(k)\hue*2,Character(0)\Color(k)\Luminosity,Character(0)\Color(k)\Saturation)
        Break
      EndIf
    Next
;   EndIf
EndProcedure
Procedure CHG_SetCharacterPartImage(mode=0,miror=0,obj$="",filename$="")
  Shared Folder$
  ; pour changer une image(d'un partie d'un objet-character) ou faire une operation dessus
  For i=0 To ArraySize(Character(CHG_CharacterID)\part())
    With Character(CHG_CharacterID)\part(i)
      updatecenter = 0
      updatesize = 0
      updateColor = 0
      If \Selected Or i = CHG_ObjID
        ; on fait un changement sur l'image
        If mode >0
          Select mode
              
            Case 1
              ; on change l'image par une nouvelle
              If obj$ = \obj$
                If FileSize(Folder$+"images\"+\obj$+"\"+ filename$)>0
                  \filename$ = filename$
                  miror=1
                  ; on va updater le center
                  updatecenter = 1
                  ; on va vérifier si on doit resizer l'image
                  If IsImage(\img)
                    w = ImageWidth(\img)
                    h = ImageHeight(\img)
                  Else
                    updatesize=1
                  EndIf
                  If \w=w And \h=h
                    updatesize=1
                  EndIf
                EndIf
              EndIf
              
            Case 2
              ; on change la couleur
              updateColor=1
              miror=1
            Case 3
              ; on clone l'image
              
          EndSelect
        EndIf
        
        If miror = 1
          updateColor = 1
          ; Debug Folder$+"images\"+\obj$+"\"+ \filename$
          If \miror = 1
            ; Debug "on fait un mmiror : "+Folder$+"images"+\obj$+"\"+ \filename$
            img = LoadImage(#PB_Any, Folder$+"images\"+\obj$+"\"+ \filename$)
            If IsImage(img) And img>0
              img2 = CopyImage(img,#PB_Any)
              \img = Image_transform(img2)
              FreeImage(img)
              FreeImage(img2)
            EndIf
          Else
            If IsImage(\img)
              FreeImage(\img)
            EndIf
            
            \img = LoadImage(#PB_Any, Folder$+"images\"+\obj$+"\"+ \filename$)
          EndIf
        EndIf
        If updatesize
          \w = ImageWidth(\img)
          \h = ImageHeight(\img)
        EndIf
        If updatecenter = 1
          CHG_SetObjetCenter(i)
        EndIf
        If updateColor = 1
          ; Debug "ok update color"
          CHG_SetCharacterPartColorImage(i)
        EndIf
      EndIf
    EndWith
  Next

EndProcedure
Procedure CHG_SetCharacterPropertie(propertie=#CHGProp_x,value=0,txt$="")
  ; change the properties
  If CHG_GetCHG_ObjIDIsOk()
    ;If CHG_CharacterID = 0
      If propertie<> #chgprop_x And propertie<> #chgprop_y
        n=1
      Else
        n=0
      EndIf
    ;EndIf
      
    For j=0 To n
     
      For i=0 To ArraySize(Character(j)\part())
        With Character(j)\part(i)
          If \Selected Or i = CHG_ObjID
          If propertie=#CHGProp_Hide Or propertie = #CHGProp_locked Or (\hide = 0 And \locked=0) Or CHG_Options\SetTemplate =1
            Select propertie
              Case #CHGProp_x
                \x = value
                If CHG_Options\SetTemplate = 1
                  CHG_SetCharacterPropFromTemplate()
                EndIf
              Case #CHGProp_y
                \y = value  
                If CHG_Options\SetTemplate = 1
                  CHG_SetCharacterPropFromTemplate()
                EndIf
              Case #CHGProp_w
                \w = value
              Case #CHGProp_h
                \h = value
              Case #CHGProp_Scale
                \Scale = value
              Case #CHGProp_Alpha
                \Alpha = value
              Case #CHGProp_Color
                color = ColorRequester(\Color)
                If color<>-1
                  \Color = color
                EndIf
              Case #CHGProp_ColorType
                \ColorType = value
                CHG_SetCharacterPartImage(2)
              Case #CHGProp_Miror
                If value=-1
                  \Miror = 1-\miror
                Else
                  \Miror = value
                EndIf
                CHG_SetCharacterPartImage(0,1)
              Case #CHGProp_Clone
                \Clone$ = txt$
                ; il faut changer l'image
                CHG_SetCharacterPartImage(-2,0)
              Case #CHGProp_ImageName
                \filename$=txt$
              Case #CHGProp_Name
                \name$ = txt$
              Case #CHGProp_locked
                \locked = value
                If \locked =1
                  \selected= 0
                  CHG_ObjID= -1
                EndIf
              Case #CHGProp_Rotation
                \Rotation = value
              Case #CHGProp_Depth
                \Depth = value
                CHG_SortCharacter()
              Case #CHGProp_Hide
                \Hide = value 
                If \hide =1
                  \selected= 0
                  CHG_ObjID= -1
                EndIf
            EndSelect
          EndIf
        EndIf
        EndWith
      Next 
    
    Next j
    ; update the main canvas
    WindowCharacterEditor_updatecanvas()
  EndIf
EndProcedure
;}

XIncludeFile "include\windows.pbi"

;{ create & draw character
; image center
Procedure CHG_SaveObjectCenter()
  ; pour enregistrer les centres dans le fichier
  Shared folder$
  
  ; on charge les centres des objets
  If CreateFile(0, folder$+"center.txt")
    
    d$= ","
    
    Date$ = FormatDate("%yyyy%mm%dd%hh%ii%ss", Date()) 
    txt$ = "gen"+d$+#CHG_ProgramVersion+d$+date$+d$
    WriteStringN(0, txt$)
    
    For i=0 To ArraySize(CHG_BankImageCenter())
      With CHG_BankImageCenter(i)
        txt$ = "obj"+d$+\Folder$+d$+\ImageName$+d$+Str(\cx)+d$+Str(\cy)+d$
        WriteStringN(0,txt$)
      EndWith
    Next
    CloseFile(0)
  EndIf
EndProcedure
Procedure CHG_OpenObjectCenter()
  Shared folder$
  
  ; Debug "center : "+folder$
  
  ; on charge les centres des objets
  If ReadFile(0, folder$+"center.txt")
    NbCenterImage = -1
    ReDim CHG_BankImageCenter(0)
    
    d$= ","
    While Eof(0)=0
      line$ = ReadString(0)
      index$ = StringField(line$,1, d$)
      u=2
      If index$ = "obj"
        NbCenterImage +1
        i = NbCenterImage
        ReDim CHG_BankImageCenter(i)
        With CHG_BankImageCenter(i)
          \Folder$ = LCase(StringField(line$,u, d$)) : u+1
          \ImageName$ = LCase(StringField(line$,u, d$)) : u+1
          \cx = Val(StringField(line$,u, d$)) : u+1
          \cy = Val(StringField(line$,u, d$)) : u+1
        EndWith
      EndIf
    Wend
    CloseFile(0)
  EndIf
  
EndProcedure
Procedure CHG_SetObjetCenter(partId)
  ; pour définir le centre de l'image (Character(0)\part(partId)\image)
  i = partId
  For k= 0 To ArraySize(CHG_BankImageCenter())
    With Character(0)
      If \part(i)\filename$ = CHG_BankImageCenter(k)\ImageName$
        ; Debug Str(k)+" : "+filename$
        \part(i)\cx = CHG_BankImageCenter(k)\cx
        \part(i)\cy = CHG_BankImageCenter(k)\cy
        Break
      EndIf
    EndWith
  Next  
EndProcedure
; select
Procedure CHG_SelectPart(k)
  Shared wec_ctrl
  With character(0)
    If CHG_action= #CHG_ActionSelect
      If wec_ctrl=1
        \part(k)\Selected = 1-\part(k)\Selected 
        If \part(k)\Selected 
          CHG_ObjID = k
        EndIf
      Else
        \part(k)\Selected = 1
        CHG_ObjID = k
      EndIf
    Else
      CHG_ObjID = k
    EndIf
  EndWith
EndProcedure
Procedure CHG_ConvertCharacterToTemplate()
  ; pour convertir un character en template 
  ; copy les paramètres du chracter(0) vers character(1)
  character(1) = character(0)
  For j=0 To ArraySize(character(1)\part())
    With character(0)\part(j)
      ; on doit définir la position du template 
      character(1)\part(j)\x = \x + \tx
      character(1)\part(j)\y = \Y + \ty
      character(1)\part(j)\Rotation = \Rotation + \tr
      ; puis, on remet à zéro la position du chracter(0), puisqu'on l'a mise sur le template
      \tx + \x
      \ty + \y
      \tr + \Rotation
      \Rotation = 0
      \x = 0
      \y = 0
    EndWith
  Next
  ; puis on update le canvas
  WindowCharacterEditor_updatecanvas()
EndProcedure
; to create the object (character)
Procedure CHG_SetCharacterColor()
  ; pour créer les couleurs pour le personnage
  Character(0)\OkColor = 1
  Character(0)\skinHue = Random(40) - Random(40)
  Character(0)\HairHue = Random(240) - Random(240)
  If Character(0)\skinHue>10
    a=15
  EndIf
  Character(0)\SkinBrightness = Random(100)+Random(15-a) - Random(100) ; -Random(60)
  Character(0)\HairBrightness = 100+Random(30) - Random(60)
  
  chg_nbcolor+1
  i = chg_nbcolor
  ReDim Character(0)\Color(i)
  With Character(0)\Color(i)
    \Hue = Character(0)\skinHue
    \Luminosity = Character(0)\SkinBrightness
    If \Luminosity<0
      a = 150
    EndIf
    \saturation = Random(150-a)-Random(200)
    If \saturation >10
      \saturation= -\saturation
    EndIf
    
    chg_nbcolor+1
    i = chg_nbcolor
    ReDim Character(0)\Color(i)
    \Hue = Character(0)\HairHue
    \Luminosity = Character(0)\HairBrightness
    If \Luminosity<0
      a = 150
    EndIf
    \saturation = Random(150-a)-Random(200)
    If \saturation >10
      \saturation= -\saturation
    EndIf
  EndWith
  
   Character(0)\NbColor = chg_nbcolor

EndProcedure
Procedure CHG_SortCharacter()
  ; pour trier les tableau Character() en fonction du depth
  ; on verifie si on a un object selectionné
  If CHG_GetCHG_ObjIDIsOk()
    With Character(0)\part(CHG_ObjID)
      idunik$ = Str(\x)+Str(\y)+\filename$+\name$+\obj$+\depth
    EndWith
  EndIf

  ; on trie
  SortStructuredArray(Character(0)\part(),#PB_Sort_Ascending,OffsetOf(sCharPart\depth),TypeOf(sCharPart\depth))
  SortStructuredArray(Character(1)\part(),#PB_Sort_Ascending,OffsetOf(sCharPart\depth),TypeOf(sCharPart\depth))
  
  ;on reselectionne le bon élement
  If CHG_GetCHG_ObjIDIsOk()
    For k =0 To ArraySize(Character(0)\part())
      With Character(0)\part(k)
      newidunik$ =  Str(\x)+Str(\y)+\filename$+\name$+\obj$+\depth
      If idunik$ = newidunik$
        CHG_ObjID = k
        Break
      EndIf
      EndWith
    Next
  EndIf
  
  CHG_UpdatePartlist()
  
EndProcedure
Procedure CHG_AddTemplatePart(name$,obj$,imagename$="",x=0,y=0)
  Character(1)\NbPart +1
  i = Character(1)\NbPart
  ReDim Character(1)\part(i)
  With Character(1)\part(i)
    \name$ = name$
    \filename$ = imagename$
    \x = x
    \y = y
    \obj$ = obj$
    \miror = 0
    \Colortype = 0
    \Clone$ = ""
    \hide = 0
    \Rotation = 0
    \Scale = 100
    \Alpha = 255
    \Depth =  10*(i+1)
  EndWith
  ProcedureReturn i
EndProcedure
Procedure CHG_SetCharacterPropFromTemplate()
  ;   To update a Character(0) propertie with the template (Character(1)) propertie
  For j = 0 To ArraySize(Character(1)\part())
    For k=0 To ArraySize(Character(0)\part())
      If Character(0)\part(k)\name$ = Character(1)\part(j)\name$
        Character(0)\part(k)\tx = Character(1)\part(j)\x
        Character(0)\part(k)\ty = Character(1)\part(j)\y
      EndIf
    Next
  Next
EndProcedure
Procedure CHG_AddCharacterPart(i,k,obj$,filename$="",name$="")
  Shared folder$
  
  ; pour ajouter un element au personnage (image+properties) par rapport au template actuel
  ; i = id for the new part of  character
  ; k = id of the part of template
  ImageFolder$ = folder$ +"images\"
  
  ; Debug "create Character(0)\part "+Str(i) +" :"+obj$
  With Character(0)
  If i > ArraySize(\part())
    ReDim \part(i)
  Else
    ; d'abord on supprime l'image
    If IsImage(\part(i)\img) And \part(i)\img>0
      FreeImage(\part(i)\img)
    EndIf
  EndIf
EndWith

  If obj$<>""
    ; si on n'a pas choisi l'objet spécifiquement, on fait un random
    If filename$ ="" 
      ; ATTENTION doit etre modifié pour utilisé nimporte quel nom d'images
      
      n = Random(ArraySize(BankImages()))
      filename$ = BankImages(n)\Name$
      Debug "fichier ouvert au hasard : "+filename$
      
      If FileSize(filename$)<=0
        Repeat 
          filename$ = obj$+Str(Random(50))+".png"
          ; Debug Folder$ +obj$+"\"+filename$
          If FileSize(ImageFolder$+obj$+"\"+filename$) >0
            ok=1
          EndIf
        Until ok=1
      EndIf
    EndIf
   
    ; define properties // on définit les propriétés
    With Character(0)
      \part(i)\filename$ = filename$
      \part(i)\name$ = name$
      \part(i)\obj$ = obj$
      \part(i)\scale = 100
      \part(i)\Depth = 10*(i+1)
      \part(i)\Alpha = 255
      \part(i)\Selected = 0
      \part(i)\locked = 0
      \part(i)\ColorType = 0
    EndWith
    
    ; set the propertie by template properties
    ;If Character(0)\NotUsetemplate = 0
    For k=0 To ArraySize(Character(1)\part())
      If Character(1)\part(k)\obj$ = obj$ And Character(1)\part(k)\name$ = name$
        ;{
        ; Debug "part trouvée dans template : "+obj$+" | "+name$
        FindTemplate = 1
        ; If k > -1 And k <= ArraySize(Character(1)\part())
        With Character(1)\part(k)
          Character(0)\part(i)\name$ = \name$
          Character(0)\part(i)\tx = \x
          Character(0)\part(i)\ty = \y
          Character(0)\part(i)\Miror = \Miror
          If Character(0)\part(i)\Depth<>0
            Character(0)\part(i)\Depth = \Depth
          EndIf
          Character(0)\part(i)\ColorType = \ColorType
          Character(0)\part(i)\Clone$ = \Clone$
          Character(0)\part(i)\Hide = Random(\Hide)
        EndWith
        
        ; Create the image
        ;Debug ImageFolder$ +obj$+"\"+filename$
        If Character(1)\part(k)\clone$ = ""
          Character(0)\part(i)\img = LoadImage(#PB_Any, ImageFolder$ +obj$+"\"+filename$)
        Else
          For k=0 To ArraySize(Character(0)\part())
            If Character(0)\part(k)\name$ = Character(0)\part(i)\Clone$
              filename$ = Character(0)\part(k)\filename$
              Character(0)\part(i)\filename$ = filename$
              ; Debug "filename : "+filename$
              Break
            EndIf
          Next
          Character(0)\part(i)\img = LoadImage(#PB_Any, ImageFolder$ +obj$+"\"+filename$)
        EndIf
        
        img = Character(0)\part(i)\img
        If IsImage(img)=0
          Character(0)\part(i)\img = LoadImage(#PB_Any, ImageFolder$ +obj$+"\"+filename$)
          img = Character(0)\part(i)\img
        EndIf
        If IsImage(img)
          If Character(1)\part(k)\w = 0
            Character(0)\part(i)\w = ImageWidth(img)
          Else
            Character(0)\part(i)\w = Character(1)\part(k)\w
          EndIf
          If Character(1)\part(k)\h = 0
            Character(0)\part(i)\h = ImageHeight(img)
          Else
            Character(0)\part(i)\h = Character(1)\part(k)\h
          EndIf
        EndIf
        Break
        ;}
      EndIf 
    Next
    ;EndIf
    
    If FindTemplate = 0
      ; attention ajouter les clones
      If name$= ""
        Character(0)\part(i)\name$ = obj$+Str(CHG_NBPart)
      Else
         Character(0)\part(i)\name$ = name$
      EndIf
      Character(0)\part(i)\img = LoadImage(#PB_Any, ImageFolder$ +obj$+"\"+filename$)
      img = Character(0)\part(i)\img
      If IsImage(img)
        Character(0)\part(i)\w = ImageWidth(img)
        Character(0)\part(i)\h = ImageHeight(img)
      EndIf
      Character(0)\part(i)\Hide = 0
    EndIf
  EndIf
  
  If obj$ <> "" And IsImage(img) And img >0
    ; Make a miror to image //  on fait un miror si besoin
    If Character(0)\part(i)\Miror =1
      ;     img = LoadImage(#PB_Any, Folder$ +obj$+"\"+ Character(0)\part(#BankTyp_hearL)\filename$)
      img2 = CopyImage(img,#PB_Any)
      Character(0)\part(i)\img =  Image_transform(img2)
      FreeImage(img)
      FreeImage(img2)
    EndIf
    
    ; Set the color // on change la teinte
    img = Character(0)\part(i)\img
    CHG_SetCharacterPartColorImage(i)
    CHG_SetObjetCenter(i)
    CHG_UpdatePartlist()
  EndIf
  
EndProcedure
Procedure CHG_PreLoadTemplatesBank()
  ; pour stocker les informations concernant :
  ; - les gabarits (templates) de personnages
  ; - pour savoir combien on a d'images dans chaque dossier (plus tard)
  
  Shared folder$
  dir$ = folder$+"templates\"
  nbbanktemplates = -1
  Dim BankTemplates(0)
  
  If ExamineDirectory(0, dir$, "*.tce")
    While NextDirectoryEntry(0)
      If DirectoryEntryType(0) = #PB_DirectoryEntry_File
        If FileSize(dir$+ DirectoryEntryName(0) )>0
          nbbanktemplates+1
          i = nbbanktemplates
          ReDim BankTemplates(i)
          BankTemplates(i)\filename$ = DirectoryEntryName(0) 
          BankTemplates(i)\Name$ = DirectoryEntryName(0) 
          ; Debug BankTemplates(i)\filename$
        EndIf
      EndIf
    Wend
    FinishDirectory(0)
  EndIf
  ; puis, on trie en fonction du nom
  SortStructuredArray(BankTemplates(),#PB_Sort_Ascending ,OffsetOf(sFile\Name$), TypeOf(sFile\Name$))
EndProcedure
Procedure CHG_SaveTemplate(filename$="", saveas=1)
  ; to save a template
  d$ = ","
  Folder$ =  CHG_options\FolderProject$+"templates\"
  If filename$="" Or saveas=1
    filename$ = SaveFileRequester(lang("Save template"), Folder$,"*.tce",1)
  EndIf
  If filename$<> ""
    
    If GetExtensionPart(filename$) <> "tce"
      filename$+".tce"
    EndIf
    
    If VD_GetFileExists(filename$) = 0 Or saveas=0
      
      If CreateFile(0,filename$)
        ; d'abord, je convertis si besoin le character en template
        CHG_ConvertCharacterToTemplate()
        
        ; puis, je le sauvegarde
        txt$ = "; Obj,name,x,y,folder,miror,colortype,clone of part,random hide,rotation,scale,alpha"
        WriteStringN(0,txt$)
        
        ; je sauve chaque partie
        For i=0 To ArraySize(Character(1)\part())
         
          With Character(1)\part(i)
             txt$ = "obj"+d$+\name$+d$+Str(\x)+d$+Str(\y)+d$+\obj$+d$
             txt$ +Str(\miror)+d$+Str(\Colortype)+d$
             txt$ +\Clone$+d$+Str(\hide)+d$+Str(\Rotation)+d$
             txt$ +Str(\Scale)+d$+Str(\Alpha)+d$
          EndWith
          WriteStringN(0,txt$)
        Next 
        
        CloseFile(0)
      EndIf
    EndIf
  EndIf
  
EndProcedure
Procedure.s CHG_OpenTemplate(file$="",value=-1, updatechar=0)
  ; pour charger un template (gabarit) de personange
  ; ce template définit les positions (et scale/rotation) de chaque élément : tete, oreille, nez, etc..
  Shared folder$
  d$ = ","
  
  ; randomise or not the template to load
  If file$ = ""
    If value=-1
      u = Random(ArraySize(BankTemplates()))
    Else 
      u = value
    EndIf
    If u<0
      u=0
    ElseIf u> ArraySize(BankTemplates())
      u= ArraySize(BankTemplates())
    EndIf
    CHG_BankTemplateId = u
    file$ = BankTemplates(u)\filename$
  EndIf
  
  ; Debug "open template "+file$
 ; Debug file$
  If file$ <> "" 
    filename$ = folder$+"templates\"+file$
    If FileSize(filename$)>0
      
      ; then read the template file
      If ReadFile(0, filename$)
        
        ; reset template
        Character(1)\NbPart =-1
        Character(1)\template$ = filename$
        ReDim Character(1)\part(0)
        
        ; save the filename
        CHG_doc\template$ = file$
     
        While Eof(0)=0
          line$ = ReadString(0)
          index$ = LCase(StringField(line$,1,d$))
          
          If index$ = "obj"
            ; on a un élément, on ajoute un partie au template
            u=2
            ; redim the Character(1)\part()
            Character(1)\NbPart +1
            i = Character(1)\NbPart
            ReDim Character(1)\part(i)
            
            ; then load the properties of the template
            ; name$,x,y,folder$,miror,colortype,clone$,randomhide,
            With Character(1)\part(i)
              \name$ = LCase(StringField(line$,u,d$)) : u+1
              \x = Val(StringField(line$,u,d$)) : u+1
              \y = Val(StringField(line$,u,d$)) : u+1
              \obj$ = StringField(line$,u,d$) : u+1
              \miror = Val(StringField(line$,u,d$)) : u+1
              \Colortype = Val(StringField(line$,u,d$)) : u+1
              \Clone$ = LCase(StringField(line$,u,d$)) : u+1
              \hide = Val(StringField(line$,u,d$)) : u+1
              \Rotation = Val(StringField(line$,u,d$)) : u+1
              \Scale = CheckZero(Val(StringField(line$,u,d$)),100) : u+1
              \Alpha = CheckZero(Val(StringField(line$,u,d$)),255,1) : u+1
              \depth = (1+i)*10
            EndWith
          EndIf
        Wend
        CloseFile(0)
        
        If updatechar = 1
          CHG_SetCharacterPropFromTemplate()
          WindowCharacterEditor_updatecanvas()
        EndIf
        
      EndIf
   EndIf
  EndIf
  
  ProcedureReturn file$
EndProcedure
Procedure CHG_InitCharacter()
  ; reset the character
  CHG_ObjID = -1
  Character(0)\NbPart =-1
  Character(1)\NbPart =-1
  Dim Character(0)\part(0)
  Dim Character(1)\part(0)
  Character(0)\NotUsetemplate = 1
  ReDim Character(0)\Color(0)
  chg_nbcolor = 0
  ; color groups
  CHG_SetCharacterColor()
  c=125
  a=130
  Character(0)\BG = RGBA(a+Random(c),a+Random(c),a+Random(c),255)
  If IsGadget(#G_WinCHG_Color_CanvasColor)
    CHG_updateCanvasColors()
  EndIf
EndProcedure
Procedure CHG_CreateCharacter()
  
  WindowInfoCreate("Create a character#Start")
  
  ; on efface tout 
  ;ClearStructure(@Character, sCharacter)
  ;ClearStructure(@template, sCharacter)
  CHG_InitCharacter()
  WindowInfos_Update("Init, ok")
  CHG_ObjID = -1
  Character(0)\NbPart =-1
  Character(1)\NbPart =-1
  Dim Character(0)\part(0)
  Dim Character(1)\part(0)
  Character(0)\NotUsetemplate = 0
  
  ; d'abord, on load le gabarit (position des différentes parties (Ã  ajouter scale, & rotation?))
  WindowInfos_Update("open template.")
  CHG_OpenTemplate()
  
  WindowInfos_Update("Set colors for character")
  ; pour modifier la couleur du personnage
  CHG_SetCharacterColor()
  c=125
  a=130
  Character(0)\BG = RGBA(a+Random(c),a+Random(c),a+Random(c),255)
  Character(0)\template$ = CHG_doc\template$
  
  ; on va loader les différentes parties du template
  For i=0 To ArraySize(Character(1)\part())
    WindowInfos_Update("Add character part :"+Character(1)\part(i)\name$)
    CHG_AddCharacterPart(i,i,Character(1)\part(i)\obj$,"",Character(1)\part(i)\name$)
  Next
  
  Chg_NBPart = ArraySize(Character(0)\part())
  
  ; update the canvas
  WindowInfos_Update("Update the canvas")
  WindowCharacterEditor_updatecanvas()
  SetGadgetState(#G_WinCHG_Bank_TemplateSelect,CHG_BankTemplateId)
  CHG_UpdatePartlist()
  
  ; save the character as image png
    WindowInfos_Update("Save document (autosave)")

  filename$ = CHG_Doc_SaveImage()
  CHG_Doc_Save(GetCurrentDirectory()+"save\"+filename$)
  
  CloseWindowInfo()
EndProcedure
Procedure CHG_AddPart(ADD_=1,x=0,y=0)
  ; To add a part to the current object
  Shared CHG_BankImageID
  
  If ADD_ = 1
    obj$ = GetGadgetText(#G_WinCHG_Bank_ListFolderImage)
    name$ = obj$+Str(Chg_NBPart+1)
    n= CHG_AddTemplatePart(name$,obj$,BankImages(CHG_BankImageID)\Name$,x,y)
    Chg_NBPart+1
    
    ;message("Après addchar : "+Str(Chg_NBPart)+"/"+Str(ArraySize(Character(0)\part())))
    
    CHG_AddCharacterPart(Chg_NBPart,n,obj$,BankImages(CHG_BankImageID)\Name$,name$)
    
   ;message("Après addchar : "+Str(Chg_NBPart)+"/"+Str(ArraySize(Character(0)\part())))

    CHG_SortCharacter()
  ElseIf ADD_ = 0 
    ; delete
    For i=0 To ArraySize(Character(0)\part())
      If Character(0)\part(i)\Selected = 1 And Character(0)\part(i)\locked =0
        DeleteArrayElement(Character(0)\part,i)
        Chg_NBPart-1
        If ArraySize(Character(0)\part())>0
          i-1
        Else
          If Character(0)\part(0)\selected
            ok =1
          EndIf
        EndIf
      EndIf
    Next
    If ok = 1
      bg = Character(0)\BG
      CHG_NBPart = -1
      FreeArray(Character())
      Global Dim Character.sCharacter(1)
      CHG_InitCharacter()
      Character(0)\BG =bg
    EndIf
    
     CHG_UpdatePartlist()
  EndIf
  WindowCharacterEditor_updatecanvas()

EndProcedure
Procedure CHG_DrawTheCharacter(drawutil=1)
  
  ; pour dessiner le personnage (main canvas et image export, etc)
  outputW = VD_camera(cameraID)\w ; CHG_Options\Camera\w
  outputh = VD_camera(cameraID)\h ; CHG_Options\Camera\h

  ; on definit la position de tous les elements par defaut
  x = outputW/2
  y = outputH/2 
  y2 = 0 ; -60
  
  ; puis, on dessine chaque element
  For k=0 To ArraySize(Character(0)\part())
    With Character(0)\part(k)
      If \Hide = 0 And \alpha>0
        If IsImage(\img) And \img>0
          
          s.d=\scale * 0.01
          w=\w*s
          h=\h*s
          \finalcx = \cx * s
          \Finalcy = \cy *s
          
          xa = x+ \tx -\finalcx +\x
          ya = y+ \ty -\Finalcy +\y ; -y2
          \Finalx = xa
          \Finaly = ya
          
          RotateCoordinates(xa+\finalcx,ya+\finalcy,\Rotation)
          
          MovePathCursor(xa,ya)
          DrawVectorImage(ImageID(\img),\Alpha,w,h)
          
          If drawutil And CHG_Options\ShowCenter= 1
            AddPathCircle(xa+\finalcx,ya+\finalcy,7)
            VectorSourceColor(RGBA(255,255,255,255))
            FillPath()
            AddPathCircle(xa+\finalcx,ya+\finalcy,5)
            VectorSourceColor(RGBA(255,0,0,100))
            FillPath()
          EndIf
          RotateCoordinates(xa+\finalcx,ya+\finalcy,-\Rotation)
      EndIf
      EndIf
    EndWith
  Next
  
  ; dessiner les utilities (bordure camera, infos debug)
  If drawutil
    
    ; border of selected object
    If CHG_Options\ShowBBox = 1 
      For i=0 To ArraySize(Character(0)\part())
        With Character(0)\part(i)
          If \Selected Or i= CHG_ObjID
            s.d=\scale * 0.01
            RotateCoordinates(\Finalx+\finalcx,\FinalY+\finalcy,\Rotation)
            AddPathBox(\Finalx,\FinalY,\w*s,\h*s)
            VectorSourceColor(RGBA(0,0,0,255))
            DashPath(1.5,5)
            RotateCoordinates(\Finalx+\finalcx,\FinalY+\finalcy,-\Rotation)
          EndIf
        EndWith
      Next
    EndIf
    
;     ; show rendering box
;     If CHG_Options\ShowRenderingBorder = 1 
;       With CHG_doc\prop
;         AddPathBox(x+\x-a*1.5,Y+\y-a*1.5,\w-\x,\h-\y)
;         VectorSourceColor(RGBA(255,255,0,200))
;         DashPath(1.5,5)
;       EndWith
;     EndIf
    
    If CHG_Options\showdebuginfos
      VectorSourceColor(RGBA(255,255,255,255))
      VectorFont(FontID(0), 20)
      MovePathCursor(10, 10)
      If CHG_BankTemplateId<=ArraySize(BankTemplates())
        DrawVectorText(Str(mx)+"/"+Str(my)+ " | "+BankTemplates(CHG_BankTemplateId)\filename$)
      EndIf
    EndIf
      
    If CHG_Options\ShowCameraBorder = 1 
      With VD_camera(cameraID)
        AddPathBox(\x,\y,\w,\h)
        VectorSourceColor(RGBA(100,0,0,255))
        StrokePath(3)
      EndWith
    EndIf

  EndIf
  
EndProcedure

;}

;{ Menu
Macro CHG_SetMenuState(menuitem, option, update=1,setoption=1)
  If setoption=1
    Option = 1-option
  EndIf
  SetMenuItemState(#menu_wincharacter,menuitem,option)
  If update
    WindowCharacterEditor_updatecanvas() 
  EndIf
EndMacro
Procedure CHG_ChangeShortCut(ok=1)
  ; shortcut
  win = #Win_CHG_CharacterEditor
  If ok=1
    AddKeyboardShortcut(win, #PB_Shortcut_Control|#PB_Shortcut_R,#MenuCHG_EditCreateRandomCharacter)
    AddKeyboardShortcut(win, #PB_Shortcut_Control|#PB_Shortcut_N,#MenuCHG_FileNew)
    AddKeyboardShortcut(win, #PB_Shortcut_Control|#PB_Shortcut_O,#MenuCHG_FileOpen)
    AddKeyboardShortcut(win, #PB_Shortcut_Control|#PB_Shortcut_S,#MenuCHG_FileSave)
    AddKeyboardShortcut(win, #PB_Shortcut_Control|#PB_Shortcut_A,#MenuCHG_EditSelectAll)
    AddKeyboardShortcut(win, #PB_Shortcut_Control|#PB_Shortcut_D,#MenuCHG_EditDeSelectAll)
    AddKeyboardShortcut(win, #PB_Shortcut_Control|#PB_Shortcut_H,#MenuCHG_EditUnHideAll)
    AddKeyboardShortcut(win, #PB_Shortcut_H,#MenuCHG_EditHideSelected)
    AddKeyboardShortcut(win, #PB_Shortcut_Shift|#PB_Shortcut_H,#MenuCHG_EditHideAllexceptSelected)
    AddKeyboardShortcut(win, #PB_Shortcut_A,#MenuCHG_ObjectAddObjet)
    AddKeyboardShortcut(win, #PB_Shortcut_Delete,#MenuCHG_ObjectDelObjet)
    AddKeyboardShortcut(win, #PB_Shortcut_M,#MenuCHG_ObjectMiror)
  Else
    RemoveKeyboardShortcut(win,#PB_All)
  EndIf

EndProcedure

; pour le menu
Procedure CreateMenu2(menu, windowId,comment$="")
  If comment$ <> ""
    AddLangComment(comment$)
  EndIf
  result = CreateMenu(menu, windowId)
  ProcedureReturn result
EndProcedure
  

; menu général
Procedure CHG_CreateTheMenu(win)
  
 If CreateMenu2(#menu_wincharacter, WindowID(win),"**** Main menu ****")
      MenuTitle(lang("File"," ** File"))
      MenuItem(#MenuCHG_FileNew, lang("New")+Chr(9)+"Ctrl+N")
;       MenuItem(#MenuCHG_FileNewCharacter, lang("Create a New character")+Chr(9))
      MenuItem(#MenuCHG_FileOpen, lang("Open")+Chr(9)+"Ctrl+O")
      MenuItem(#MenuCHG_FileSave, lang("Save")+Chr(9)+"Ctrl+S")
      MenuItem(#MenuCHG_FileSaveRandomExpressions, lang("Save random expression"))
      MenuBar()
      MenuItem(#MenuCHG_FileExportImage, lang("Export Image"))
      MenuItem(#MenuCHG_FileExportImageAs, lang("Export Image As"))
      MenuBar()
      MenuItem(#MenuCHG_FileOutputProperties, lang("Output properties"))
      MenuBar()
      MenuItem(#MenuCHG_FilePreference, lang("Preferences"))
     
      
      MenuTitle(lang("Edit"," ** Edit"))
      MenuItem(#MenuCHG_EditSelectAll, lang("Select All")+Chr(9)+"Ctrl+A")
      MenuItem(#MenuCHG_EditDeSelectAll, lang("Deselect All")+Chr(9)+"Ctrl+D")
      ; MenuBar()
      ; MenuItem(#MenuCHG_EditCopy, lang("Copy")+Chr(9)+"Ctrl+C")
      MenuBar()
      MenuItem(#MenuCHG_EditCreateRandomCharacter, lang("Create a random character")+Chr(9)+"Ctrl+R")
      MenuItem(#MenuCHG_EditConvertchartotemplate, lang("Convert character to template"))
      MenuBar()
      MenuItem(#MenuCHG_EditHideAllexceptSelected, lang("Hide All except selected")+Chr(9)+"shift+H")
      MenuItem(#MenuCHG_EditUnHideAll, lang("UnHide All")+Chr(9)+"Ctrl+H")
      MenuItem(#MenuCHG_EditHideSelected, lang("Hide selected")+Chr(9)+"H")
      
      MenuTitle(lang("View"," ** View"))
      MenuItem(#MenuCHG_ViewZoom50, lang("Zoom 50%"))
      MenuItem(#MenuCHG_ViewZoom100, lang("Zoom 100%"))
      MenuItem(#MenuCHG_ViewZoom150, lang("Zoom 150%"))
      MenuItem(#MenuCHG_ViewZoom200, lang("Zoom 200%"))
      MenuItem(#MenuCHG_ViewReset, lang("Reset View"))
      MenuItem(#MenuCHG_ViewCenter, lang("Center View"))
      MenuBar()
      ;       MenuItem(#MenuCHG_ViewShowRenderBorder, lang("Show rendering Border"))
      MenuItem(#MenuCHG_ViewShowCameraBorder, lang("Show camera Border"))
      MenuItem(#MenuCHG_ViewShowShapeBbox, lang("Show Object Border"))
      MenuItem(#MenuCHG_ViewShowCenter, lang("Show Object center"))
      MenuItem(#MenuCHG_ViewShowDebugInfos, lang("Show debug infos"))
      MenuBar()
      MenuItem(#MenuCHG_ViewUseClipping, lang("Use Clipping for display"))
      
      MenuTitle(lang("Object"," ** Object"))
      MenuItem(#MenuCHG_ObjectAddObjet, lang("Add a new Part to Object")+Chr(9)+"A")
      MenuItem(#MenuCHG_ObjectDelObjet, lang("Delete the selected Parts")+Chr(9)+"Del")
      MenuBar()
      MenuItem(#MenuCHG_ObjectSetToFront, lang("Move Object to front"))
      MenuItem(#MenuCHG_ObjectSetToBack, lang("Move Object to Back"))
       MenuBar()
      MenuItem(#MenuCHG_ObjectMiror, lang("Miror the selected Parts")+Chr(9)+"M")
      ;MenuBar()
      
      
      MenuTitle(lang("Help"," ** Help"))
      MenuItem(#MenuCHG_HelpAbout, lang("About"))
      
      ; set menu item state
      CHG_SetMenuState(#MenuCHG_ViewShowCameraBorder,CHG_Options\ShowCameraBorder,0,0)
      CHG_SetMenuState(#MenuCHG_ViewShowShapeBbox,CHG_Options\ShowBBox,0,0)
      CHG_SetMenuState(#MenuCHG_ViewShowCenter,CHG_Options\ShowCenter,0,0)
      CHG_SetMenuState(#MenuCHG_ViewShowDebugInfos,CHG_Options\showdebuginfos,0,0)

      ; set shortcuts
      CHG_ChangeShortCut()
    EndIf

EndProcedure
; options
Procedure CHG_OptionsReset()
  With CHG_Options
    \pathsave$ = "save\"
    \pathopen$ = "save\"
    \pathexport$ = "save\"
    ;
    \FolderProject$ = "data\projects\moyfys\"
    ; camera
    \Camera\X=0
    \Camera\Y=0
    \Camera\w=1024
    \Camera\h=768
    \Camera\scale=100
    ; 
    \viewx = 0
    \viewy = 0
    \Zoom = 100
    \PanelW = 250
 EndWith    
EndProcedure
Procedure CHG_OptionsSave()
  FileName.s = GetCurrentDirectory() + "Preferences.json"
  
  With CHG_Options
    \Action =CHG_action
  EndWith
  
  ; Sauvegarde des options
  CreateJSON(#JSONFile)
  InsertJSONStructure(JSONValue(#JSONFile), @CHG_Options, sCHG_Options)
  SaveJSON(#JSONFile, FileName, #PB_JSON_PrettyPrint)

EndProcedure
Procedure CHG_OptionsLoad()
  
  CHG_OptionsReset()
  FileName$ = GetCurrentDirectory() + "Preferences.json"
  
  If FileSize(FileName$) < 0        
    CHG_OptionsSave()
  EndIf
  
  ; Lecture des options
  If LoadJSON(#JSONFile, FileName$, #PB_JSON_NoCase)
    ExtractJSONStructure(JSONValue(#JSONFile),  @CHG_Options, sCHG_Options)
  EndIf
  
  With CHG_Options
    If \FolderProject$ = #Empty$
      \FolderProject$ =  GetCurrentDirectory() +"data\projects\moyfys\"
    EndIf
    If \PanelW<=100
       \PanelW = 250
    EndIf
    \SetTemplate = 0
    CHG_action = \Action
    VD_CameraAdd(Lang("Camera Default"),\Camera\x,\Camera\y,\Camera\w,\Camera\H,100,1)
  EndWith
  
;   Debug CHG_Options\Lang$
EndProcedure
; document, (menu file)
Procedure CHG_Doc_reset()
  Shared wec_NbImage
  wec_NbImage = -1
  With chg_doc
    \prop\x = 10000
    \prop\y = 10000
    \prop\w = 0
    \prop\h = 0
    \prop\scale = 100
    \camera\x = CHG_Options\Camera\x
    \camera\y = CHG_Options\Camera\y
    \camera\w = CHG_Options\Camera\w
    \camera\h = CHG_Options\Camera\h
    \camera\scale = CHG_Options\Camera\scale
  EndWith
EndProcedure
Procedure CHG_Doc_New(update=1)
  ; pour créer un nouveau document, tout remettre à 0, etc.
  REPonse = MessageRequester(lang("Infos"),lang("Are you sur that you want to erase the document ?")+Chr(13)+lang("All your unsaved works will be erased."),#PB_MessageRequester_YesNo) 
  ; on vérifie si on est ok.
  If REPonse =  #PB_MessageRequester_Yes  
    ; si oui, on remet à zero
    CHG_Doc_reset()
    CHG_CharacterID=0
    CHG_NBPart = -1
    FreeArray(Character())
    Global Dim Character.sCharacter(1)
    CHG_InitCharacter()
    If update=1
      WindowCharacterEditor_updatecanvas()
    EndIf
    ProcedureReturn 1
  Else
    ProcedureReturn 0
  EndIf
  
EndProcedure
Procedure CHG_Doc_Save(filename$=#Empty$, saveas=0)
  ; to save a character document
  If filename$=#Empty$ Or saveas = 1
    If CHG_Options\pathsave$=#Empty$
      CHG_Options\pathsave$="save\"
    EndIf
    filename$ = SaveFileRequester(lang("Save document"), CHG_Options\pathsave$, "*.chg",1)
  EndIf
 
  If filename$<>#Empty$
    If VD_GetFileExists(filename$) = 0
      
      d$ =","
      If GetExtensionPart(filename$) <> "chg"
        filename$ = RemoveString(filename$, GetExtensionPart(filename$))+".chg"
      EndIf
      
      If CreateFile(0,filename$)
        
        ; save general infos
        Date$ = FormatDate("%yyyy%mm%dd%hh%ii%ss", Date()) 
        txt$ = "gen"+d$+#CHG_ProgramVersion+d$+date$+d$
        WriteStringN(0, txt$)
        
        ; infos for rendering
        With VD_camera(CameraID)
          txt$ = "camera"+d$+Str(\x)+d$+Str(\y)+d$+Str(\W)+d$+Str(\h)+d$+Str(\scale)+d$
        EndWith
         WriteStringN(0, txt$)
      
        ; infos for character
        With Character(0)
          txt$ = "char"+d$+Str(\skinHue)+d$+Str(\HairHue)+d$+CHG_doc\template$+d$+Str(\BG)+d$
          txt$ +Str(\HairBrightness)+d$+Str(\SkinBrightness)+d$+\template$+d$+Str(\NotUsetemplate)+d$+CHG_options\FolderProject$+d$
          WriteStringN(0, txt$)
          ; save colors
          For k=0 To ArraySize(\Color())
            txt$ = "color"+d$+Str(k)+d$+Str(\Color(k)\Hue)+d$+Str(\Color(k)\Saturation)+d$+Str(\Color(k)\Luminosity)+d$
            WriteStringN(0, txt$)
          Next
          
        EndWith
        
        ; on enregistre chaque élément
        For i=0 To ArraySize(Character(0)\part())
          With Character(0)\part(i)
            txt$ = "obj"+d$+Str(i)+d$+\obj$+d$+\filename$+d$
            txt$ +Str(\w)+d$+Str(\h)+d$+Str(\Scale)+d$+Str(\Hide)+d$+Str(\Alpha)+d$
            txt$ +\Clone$+d$+Str(\Miror)+d$+Str(\Rotation)+d$+Str(\Color)+d$+Str(\ColorType)+d$
            txt$ +Str(\Depth)+d$+Str(\locked)+d$+\name$+d$
            txt$ +Str(\tx)+d$+Str(\ty)+d$+Str(\x)+d$+Str(\y)+d$
            WriteStringN(0, txt$)
          EndWith
        Next
      
        CloseFile(0)
      EndIf
      
      CHG_doc\filename$ = filename$
      SetWindowTitle(#Win_CHG_CharacterEditor, #CHG_ProgramName+" "+#CHG_ProgramVersion+" - "+filename$)
    EndIf
  EndIf
  
EndProcedure
Procedure CHG_Doc_Open(filename$=#Empty$)
  ; ouvrir un document (pas un projet)
  Shared folder$
  d$=","
  filename$ = OpenFileRequester(lang("Open a document","Open a document"),CHG_Options\PathOpen$,"Fichier Generatoon (CHG)|*.chg",1)
  If filename$<>"" And FileSize(filename$)>0
    
    If ReadFile(1, filename$)
      
      If CHG_Doc_New(0)
        
        WindowInfos_Create(Lang("Open the document"),lang("Read File"))
        While Eof(1)=0
          line$ = ReadString(1)
          index$ = StringField(line$,1,d$)
          u=2
          Select index$
              
            Case "gen"
              ; txt$ = "gen"+d$+#CHG_ProgramVersion+d$+date$+d$
              version$ = StringField(line$,u,d$) : u+1
              version.d = ValD(version$)
              
            Case "camera"
              ; txt$ = "camera"+d$+Str(\x)+d$+Str(\y)+d$+Str(\W)+d$+Str(\h)+d$+Str(\scale)+d$
              With vd_camera(cameraId)
                \x = Val(StringField(line$,u,d$)) : u+1
                \y = Val(StringField(line$,u,d$)) : u+1
                \w = CheckZero(Val(StringField(line$,u,d$)),450) : u+1
                \h = CheckZero(Val(StringField(line$,u,d$)),550) : u+1
                \scale = CheckZero(Val(StringField(line$,u,d$)),100) : u+1
              EndWith
              WindowInfos_Update(lang("Read Camera parameters"))
              
            Case "char"
              ; txt$ = "char"+d$+Str(\skinHue)+d$+Str(\HairHue)+d$+CHG_doc\template$+d$+Str(\BG)+d$
              ; txt$ +Str(\HairBrightness)+d$+Str(\SkinBrightness)+d$
              Character(0)\OkColor=1
              With Character(0)
                \skinHue = Val(StringField(line$,u,d$)) : u+1
                \HairHue = Val(StringField(line$,u,d$)) : u+1
                template$ = StringField(line$,u,d$) : u+1
                \bg = Val(StringField(line$,u,d$)) : u+1
                \HairBrightness = Val(StringField(line$,u,d$)) : u+1
                \SkinBrightness = Val(StringField(line$,u,d$)) : u+1
                \template$ = StringField(line$,u,d$) : u+1
                If version< 0.17 Or template$=\template$
                  CHG_OpenTemplate(template$)
                EndIf
                \NotUsetemplate = Val(StringField(line$,u,d$)) : u+1
                folder1$ = StringField(line$, u, d$) : u+1
                If folder1$ <> ""
                  path$ = ""
                  If FindString(folder1$, "data\") = 0
                    path$ = "data\projects\"
                    CHG_options\FolderProject$ = path$+folder1$+"\"
                  Else
                    CHG_options\FolderProject$ = folder1$
                  EndIf
                  folder$ = CHG_options\FolderProject$
                  ; update all folders
                  CHG_OpenObjectCenter()
                  CHG_UpdateListFolderImages()
                  CHG_UpdateListImageFromFolder()
                  CHG_PreLoadTemplatesBank()
                  CHG_UpdateTemplateList()
      
                EndIf
                
              EndWith
              WindowInfos_Update(lang("Read Character parameters"))
              WindowCharacterEditor_updatecanvas()
              
            Case "color"
              ; txt$ = "color"+d$+Str(\Color(k)\Hue)+d$+Str(\Color(k)\Saturation)+d$+Str(\Color(k)\Luminosity)+d$
              Character(0)\OkColor=1
              id = Val(StringField(line$,u,d$)) : u+1
              If id > ArraySize(Character(0)\Color())
                i = ArraySize(Character(0)\Color())+1
                chg_nbcolor = i
                ReDim Character(0)\Color(i)
              EndIf
              With Character(0)\Color(i)
                \Hue = Val(StringField(line$,u,d$)) : u+1
                \Luminosity = Val(StringField(line$,u,d$)) : u+1
                \saturation = Val(StringField(line$,u,d$)) : u+1
              EndWith
              Character(0)\NbColor = chg_nbcolor

              Case "obj", "part"
                Character(0)\OkColor=1
              ; txt$ = "obj"+d$+Str(i)+d$+\obj$+d$+\filename$+d$
              ; txt$ +Str(\w)+d$+Str(\h)+d$+Str(\Scale)+d$+Str(\Hide)+d$+Str(\Alpha)+d$
              ; txt$ +\Clone$+d$+Str(\Miror)+d$+Str(\Rotation)+d$+Str(\Color)+d$+Str(\ColorType)+d$
              ; txt$ +Str(\Depth)+d$+Str(\locked)+d$+\name$+d$+\tx+d$+\ty+d$
              ; txt$ +Str(\x)+d$+Str(\y)+d$
              id = Val(StringField(line$,u,d$)) : u+1
              obj$ = StringField(line$,u,d$) : u+1
              filename$ = StringField(line$,u,d$) : u+1
              
              WindowInfos_Update(lang("Add an image :")+obj$+ "| "+filename$)

              w = Val(StringField(line$,u,d$)) : u+1
              h = Val(StringField(line$,u,d$)) : u+1
              Scale = Val(StringField(line$,u,d$)) : u+1
              Hide = Val(StringField(line$,u,d$)) : u+1
              Alpha = Val(StringField(line$,u,d$)) : u+1
              Clone$ = StringField(line$,u,d$) : u+1
              Miror = Val(StringField(line$,u,d$)) : u+1
              Rotation = Val(StringField(line$,u,d$)) : u+1
              Color = Val(StringField(line$,u,d$)) : u+1
              ColorType = Val(StringField(line$,u,d$)) : u+1
              Depth = Val(StringField(line$,u,d$)) : u+1
              locked  = Val(StringField(line$,u,d$)) : u+1
              name$ = StringField(line$,u,d$) : u+1
              If name$ = ""
                If version <0.18
                  If id<= ArraySize(Character(1)\part())
                    name$ = Character(1)\part(id)\name$
                  EndIf
                  
                Else
                  ; name$ = obj$
                EndIf
                
              EndIf
              
              tx =  Val(StringField(line$,u,d$)) : u+1
              ty =  Val(StringField(line$,u,d$)) : u+1
              x  = Val(StringField(line$,u,d$)) : u+1
              y  = Val(StringField(line$,u,d$)) : u+1
              
              ; than add a part to the objet
              CHG_ObjID = id
              id2=id
              If Character(0)\template$ = "" And version>=0.18
                id2=-1
                ; attention : si pas de template : pas d'image et pas de center !!!
              EndIf
              CHG_AddCharacterPart(id,id2,obj$,filename$,name$)
              
              With Character(0)\part(id)
                \Selected = 1
                \w = w
                \h = h
                \Scale = scale
                \Hide = hide
                \Alpha = alpha
                \Clone$ = clone$
                \Miror = miror
                If \miror
                  CHG_SetCharacterPartImage(0,1)
                EndIf
                
                If version >=0.18
                  \Rotation = rotation
                  \Color = Color
                  \ColorType = ColorType
                  \Depth = Depth
                  \locked = locked
                  \name$ = name$
                  \filename$ = filename$
                  \obj$ = obj$
                  \x = x
                  \y = y
                  If \tx = 0
                    \tx = tx
                  EndIf
                  If \ty = 0
                    \ty = ty
                  EndIf
                  
                Else
                  If \depth=0
                    \Depth = id*10
                  EndIf
                EndIf
                \Selected = 0
              EndWith
              WindowCharacterEditor_updatecanvas()
              
          EndSelect
        Wend
        
      EndIf
      
      CloseFile(1)
      
      ;Message(Str(ArraySize(Character(1)\part())))
      ;Message(Str(Chg_NBPart))
      
      Chg_NBPart = ArraySize(Character(0)\part())
      ;Message(Str(Chg_NBPart))
      
      ; j'update les couleurs
     
      
      ; puis le canvas
      WindowInfos_Update(lang("Finish"))
      CHG_updateCanvasColors()
      WindowCharacterEditor_updatecanvas()
      ; CHG_UpdateAllColors()
      WindowInfos_Close()
    EndIf
  EndIf

EndProcedure
Procedure.s CHG_Doc_SaveImage(Filename$=#Empty$, automatic=1,index$="")
  
  ; automatic : to save automaticaly the image (when create character for example)
  
    With VD_camera(cameraId); CHG_Options\camera
      px = \x 
      py = \y 
      pw = \w ; -px 
      ph = \h ; -py 
    EndWith
  ; Debug ""+px+"/"+py+" | "+pw+"/"+ph
    
    Date$ = FormatDate("%yyyy%mm%dd%hh%ii%ss", Date()) 

  If CreateImage(#image_Export,pw,ph,32,#PB_Image_Transparent)
    If StartVectorDrawing(ImageVectorOutput(#image_Export))
      
      If CHG_Options\UseBG
        AddPathBox(0,0,pw,ph)
        VectorSourceColor(Character(0)\BG)
        FillPath()
    
        AddPathBox(0,0,pw,ph)
        ClipPath()
      EndIf
      
      CHG_DrawTheCharacter(0)
      StopVectorDrawing()
    EndIf
    
    If CHG_Options\pathexport$ =""
      CHG_Options\pathexport$ = GetCurrentDirectory()+"save\"
    EndIf
    If automatic =0
      If Filename$ = ""
        Filename$ = SaveFileRequester(lang("Save image"),CHG_Options\pathexport$,"*.png",1)
        If GetExtensionPart(Filename$) <> "png"
          Filename$+".png"
        EndIf
        
      EndIf
    Else
      Filename$ = CHG_Options\pathexport$+"Perso_"+Date$+index$+".png"
    EndIf
    
    ; unpremultiply, to fixe the PB bug eport with vectorlib
    CompilerIf #PB_Compiler_Backend = 0
      If StartDrawing(ImageOutput(#image_Export))
        Premultiply::UnpremultiplyPixels(DrawingBuffer(), (DrawingBufferPitch()*OutputHeight())>>2)
        StopDrawing()
      EndIf
    CompilerEndIf
    
    
    If SaveImage( #image_Export,Filename$,#PB_ImagePlugin_PNG )
    EndIf
    FreeImage(#image_Export)
    
  EndIf
  
  ProcedureReturn "Perso_"+Date$+index$

EndProcedure
Procedure CHG_SaveRandomExpressionfromCharacter()
  ; pour créer plusieurs attitudes et expressions
  ; à partir du même personnage (pour aller encore plus vite pour créer les bd :)
  
  ; je vérifie qu'on a bien un personnage de créer
  If CHG_NBPart>-1
    
    ; If CHG_Options\NBRandomExpressions<=0
      CHG_Options\NBRandomExpressions = Val(InputRequester(lang("Number of expressions"),lang("Define the number of expressions to create and save"),Str(CHG_Options\NBRandomExpressions)))
    ; EndIf
    
    
    ; ensuite, je ne vais modifier que les yeux et la bouche pour les expressions
    ; en changeant pour le moment uniquement les images (yeux, bouche)
    For k=0 To CHG_Options\NBRandomExpressions
      For i= 0 To ArraySize(Character(0)\part())
        With Character(0)\part(i)
          If \obj$ = "eye" Or \obj$ = "mouth"
            CHG_ObjID = i
            ; d'abord, je dois changer le dossier des images
            CHG_UpdateListImageFromFolder(\obj$)
            ; on change l'image sur l'element
            u = Random(ArraySize(BankImages()))
            CHG_SetCharacterPartImage(1,0,\obj$,BankImages(u)\Name$)
            ; Debug "ok "+Str(u)+" / "+ \obj$
          EndIf
        EndWith
      Next
      
      WindowCharacterEditor_updatecanvas()  

      ; save image / on sauve l'image créée
      ; et savefile : on sauve le fichier aussi
      ; save the character as image png
      filename$ = CHG_Doc_SaveImage("",1,Str(k))
      CHG_Doc_Save(GetCurrentDirectory()+"save\"+filename$)
      
    Next
    
    
    ; puis les bras pour les attitudes(type de bras, rotation)
    
  EndIf
  
  
EndProcedure
Procedure CHG_WinPreferences()
  
  ; to create a window preference, to change some preference
  
  If OpenWindow(#win_Chg_Preference, 0,0,600, 400, "",#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
    
    ComboBoxGadget(#G_WinPref_Lang, 10,20,200,30)
    GadgetToolTip(#G_WinPref_Lang, lang("Set the Langage"))
    dir$ = "data\lang\"
    ; Debug dir$
    n=-1
;     Dim LangName$(0)
    
    If ExamineDirectory(0, dir$, "*.*")
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = #PB_DirectoryEntry_File
          name$ = DirectoryEntryName(0)
          If name$<>"" And GetExtensionPart(dir$+name$) ="ini"
            n+1
            i = n
;             ReDim LangName$(i)
;             LangName$(i) = DirectoryEntryName(0) 
            ; Debug filename$
            AddGadgetItem(#G_WinPref_Lang, i, ReplaceString(name$,".ini", ""))
            If CHG_Options\newlang$ = ReplaceString(name$,".ini", "")
              langid = i
;               Debug CHG_Options\newlang$
            EndIf
            
          EndIf
        EndIf
      Wend
      FinishDirectory(0)
    EndIf
    SetGadgetState(#G_WinPref_Lang, langid)
    
    Repeat
      
      
      Event = WaitWindowEvent(1)
      EventGadget = EventGadget()
      Select event
          
        Case #PB_Event_Gadget
          Select EventGadget
            Case #G_WinPref_Lang
              pos = GetGadgetState(#G_WinPref_Lang)
              CHG_Options\NEwLang$ = GetGadgetItemText(#G_WinPref_Lang, pos)
              MessageRequester(lang("Infos"), lang("The changes will be used after restart the program."))
          EndSelect
          
        Case #PB_Event_CloseWindow
          quit = 2
      EndSelect
      
      
    Until quit >=1
    
  EndIf
  
  CloseWindow(#win_Chg_Preference)
  ; CHG_OptionsSave()
  
EndProcedure



; edit
Procedure CHG_SelectAll(Selected=1)
  For i=0 To ArraySize(Character(0)\part())
    If Character(0)\part(i)\Hide = 0 And Character(0)\part(i)\locked = 0
      Character(0)\part(i)\Selected = selected
    EndIf
  Next
  For i=0 To ArraySize(Character(1)\part())
    Character(1)\part(i)\Selected = selected
  Next
EndProcedure

; event menu main
Procedure CHG_EventMenuMain()
  
  z.d = CHG_Options\Zoom * 0.01
  vx = CHG_Options\viewx
  vy = CHG_Options\viewy
  
  EventMenu= EventMenu()
  
  Select EventMenu
      ;{ file
    Case #MenuCHG_FileNew
      CHG_Doc_New()
    Case #MenuCHG_FileNewCharacter
      
    Case #MenuCHG_FileNewProject
      
    Case #MenuCHG_FileOpen
      CHG_Doc_Open()
    Case #MenuCHG_FileSave
      CHG_Doc_Save("",1)
    Case #MenuCHG_FileSaveRandomExpressions
      CHG_SaveRandomExpressionfromCharacter()
    Case #MenuCHG_FileExportImage
      CHG_Doc_SaveImage()
    Case #MenuCHG_FileExportImageAs
      CHG_Doc_SaveImage("",0)
    Case #MenuCHG_FileOutputProperties
      OpenWindow_Sceneproperties()
    Case #MenuCHG_FilePreference
      CHG_WinPreferences()
      ;}
      ;{ Edit
    Case #MenuCHG_EditConvertchartotemplate
      CHG_ConvertCharacterToTemplate()
    Case #MenuCHG_EditSelectAll
      CHG_SelectAll() : WindowCharacterEditor_updatecanvas()
    Case #MenuCHG_EditDeSelectAll
      CHG_SelectAll(0) : WindowCharacterEditor_updatecanvas()
    Case #MenuCHG_EditHideAllexceptSelected
      For i=0 To ArraySize(Character(CHG_CharacterID)\part())
        With Character(CHG_CharacterID)\part(i)
          If \Selected = 0
            \hide = 1
          EndIf
        EndWith
      Next
      WindowCharacterEditor_updatecanvas()
    Case #MenuCHG_EditHideSelected
      CHG_SetCharacterPropertie(#CHGProp_Hide,1)
    Case #MenuCHG_EditUnHideAll
      For i=0 To ArraySize(Character(CHG_CharacterID)\part())
        Character(CHG_CharacterID)\part(i)\hide = 0
      Next
      WindowCharacterEditor_updatecanvas()
    Case #MenuCHG_EditCreateRandomCharacter
      CHG_CreateCharacter()
      ;}
      ;{ view
    Case #MenuCHG_ViewShowCameraBorder
      CHG_SetMenuState(eventmenu,CHG_Options\ShowCameraBorder)
    Case #MenuCHG_ViewShowRenderBorder
      CHG_SetMenuState(eventmenu,CHG_Options\ShowRenderingBorder)
    Case #MenuCHG_ViewShowCenter
      CHG_SetMenuState(eventmenu,CHG_Options\ShowCenter)
    Case #MenuCHG_ViewShowShapeBbox
      CHG_SetMenuState(eventmenu,CHG_Options\ShowBBox)
    Case #MenuCHG_ViewReset
      CHG_SetViewZoom(0,0) 
    Case #MenuCHG_ViewCenter
      CHG_SetViewZoom((GadgetWidth(#G_WinCHG_CanvasMain)-CHG_Options\camera\w)/2,
                      (GadgetHeight(#G_WinCHG_CanvasMain)-CHG_Options\camera\h)/2) 
    Case #MenuCHG_ViewZoom100
      CHG_SetViewZoom(CHG_Options\viewx,CHG_Options\viewy,100) 
    Case #MenuCHG_ViewZoom50
      CHG_SetViewZoom(CHG_Options\viewx,CHG_Options\viewy,50)
    Case #MenuCHG_ViewZoom150
      CHG_SetViewZoom(CHG_Options\viewx,CHG_Options\viewy,150)
    Case #MenuCHG_ViewZoom200
      CHG_SetViewZoom(CHG_Options\viewx,CHG_Options\viewy,200)
    Case #MenuCHG_ViewShowDebugInfos
      CHG_SetMenuState(eventmenu,CHG_Options\showdebuginfos)
    Case #MenuCHG_ViewUseClipping
      CHG_SetMenuState(eventmenu,CHG_Options\UseClipping)
      ;}
      ;{ Object
    Case #MenuCHG_ObjectSetToBack
      If CHG_ObjID >0
        Character(0)\part(CHG_ObjID)\depth = Character(0)\part(0)\Depth - 10
        CHG_SortCharacter()
         WindowCharacterEditor_updatecanvas()
      EndIf
      
    Case #MenuCHG_ObjectSetToFront
      n= ArraySize(Character(0)\part())
      If CHG_ObjID<n
        Character(0)\part(CHG_ObjID)\depth = Character(0)\part(n)\Depth + 10
        CHG_SortCharacter()
         WindowCharacterEditor_updatecanvas()
      EndIf
    
    Case #MenuCHG_ObjectMiror
      CHG_SetCharacterPropertie(#CHGProp_Miror,-1)
    Case #MenuCHG_ObjectAddObjet
      CHG_AddPart(1,mx-VD_camera(cameraId)\w/2-vx/z,my-VD_camera(cameraId)\h/2-vy/z)
    Case #MenuCHG_ObjectDelObjet
      CHG_AddPart(0)
      ;}
      ;{ Help
    Case #MenuCHG_HelpAbout
      Message(About$)
      ;}
    Default
      MessageRequester(lang("Infos"),lang("Not Implemented"))
  EndSelect
  
EndProcedure
;}

;{ window CHG

Procedure WindowInfoCreate(info$)
  Shared maininfo1$
  maininfo1$ = maininfo$
  ; a window to wait when load or save long things (export image or load a big file)
  w = 500
  h = 300
  
  If OpenWindow(#Win_CHG_InfosForwainting,0,0,w,h,lang("Info"),#PB_Window_SystemMenu,WindowID(#Win_CHG_CharacterEditor))
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
  EndIf

EndProcedure
Procedure WindowInfoUpdate(info$)
  
  Shared maininfo1$

  win = #Win_CHG_InfosForwainting
  
  ; count the number of line to draw
  info$ = maininfo1$+Chr(13)+info$
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
Procedure CloseWindowInfo()
  If IsWindow(#Win_CHG_InfosForwainting)
    CloseWindow(#Win_CHG_InfosForwainting)
  EndIf
  
EndProcedure


Procedure CHG_SetViewZoom(vx,vy,zoom=0)
  If zoom>0
    CHG_Options\Zoom = zoom
  EndIf
  CHG_Options\viewx = vx
  CHG_Options\viewy = vy
  WindowCharacterEditor_updatecanvas() 
EndProcedure

Procedure.a CHG_GetCHG_ObjIDIsOk()
  If CHG_ObjID >-1 And CHG_ObjID<= ArraySize(Character(CHG_CharacterID)\part())
    ProcedureReturn 1
  Else
    ProcedureReturn 0
  EndIf
EndProcedure
Procedure CHG_EventMainCanvas()
  
  Static wec_clic, wec_start.sPoint, wec_startscale
  Shared wec_vx, wec_vy, wec_startX, wec_startY, wec_Shift, wec_ctrl, wec_Space
  Shared wec_leftclic
  ; wec = window edit case
  
  z.d = CHG_Options\zoom * 0.01
  gad = #G_WinCHG_CanvasMain
  wec_vx = CHG_Options\viewx/z
  wec_vy = CHG_Options\viewy/z
  
  ; key down
  If EventType() = #PB_EventType_KeyDown ; Or EventType() = #PB_EventType_Focus          
    If GetGadgetAttribute(gad, #PB_Canvas_Modifiers) & #PB_Canvas_Shift                            
      wec_Shift = 1                          
    EndIf  
    If GetGadgetAttribute(gad, #PB_Canvas_Modifiers) & #PB_Canvas_Control                         
      wec_ctrl = 1                          
    EndIf                        
    If GetGadgetAttribute(gad, #PB_Canvas_Key) & #PB_Shortcut_Space                         
      wec_Space = 1                            
    EndIf
  EndIf
  
  If EventType() = #PB_EventType_LeftButtonDown Or 
     (EventType() = #PB_EventType_MouseMove And                         
      GetGadgetAttribute(gad, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton) 
    If wec_space = 1 ;And wec_leftclic
      ;{ space move canvas
      x = GetGadgetAttribute(gad, #PB_Canvas_MouseX) ; /z 
      y = GetGadgetAttribute(gad, #PB_Canvas_MouseY) ; /z
      If wec_clic=0
        wec_clic =1
        wec_startX = x - CHG_Options\viewx
        wec_startY = y - CHG_Options\viewy
      EndIf
      CHG_Options\viewx = x - wec_startX
      CHG_Options\viewy = y - wec_starty
      wec_vx = CHG_Options\viewx/z 
      wec_vy = CHG_Options\viewy/z
      WindowCharacterEditor_updatecanvas()
      ;}
    Else
      If EventType() = #PB_EventType_LeftButtonDown
        x = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/z 
        y = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/z
        mx = x
        my = y
         
        If wec_clic=0
          wec_clic =1
          If CHG_action= #CHG_ActionAdd
            CHG_AddPart(1,mx-VD_camera(cameraId)\w/2-wec_vx,my-VD_camera(cameraId)\h/2-wec_vy)
          Else
            
            wec_startX = x - CHG_Options\viewx
            wec_startY = y - CHG_Options\viewy
            ; Debug Str(wec_vx)+"/"+Str(wec_vy)
            ;If CHG_action= #CHG_ActionSelect
            With Character(0)
              ; select the image under the clic mouseleft
              oldCHG_ObjID = CHG_ObjID
              ; on déselectionne les autres part()
              CHG_ObjID = -1
              If wec_ctrl=0
                CHG_SelectAll(0)
              EndIf
              ; okbreak=0
              ; on vérifie si on a cliqué sur une part.
              For k=ArraySize(\part()) To 0 Step -1
                If \part(k)\hide = 0 Or CHG_Options\SetTemplate
                  
                  ; on stocke le start
                  \part(k)\startx = x - \part(k)\x
                  \part(k)\starty = y - \part(k)\y
                  \part(k)\StartScale = \part(k)\scale
                  \part(k)\StartRot = \part(k)\Rotation
                  ; puis, je définis la position à vérifier
                  s.d= \part(k)\scale * 0.01
                  xa = \part(k)\Finalx
                  ya = \part(k)\FinalY
                  
                  ;Debug "Position"+xa+" / "+ya+" | "+x+"/"+y
                  If \part(k)\rotation <> 0
                    cx.f = \part(k)\finalcx
                    cy.f = \part(k)\finalcy
                    x6 = xa +cx ;-wec_vx 
                    y6 = ya +cy ;-wec_vy
                    If GetClicOnImageRotated(x-wec_vx,y-wec_vy,x6,y6,cx,cy,\part(k)\rotation,\part(k)\w*s,\part(k)\h*s)
                      ; Debug "clic on the part "+\part(k)\name$
                      CHG_SelectPart(k)
                      okbreak = 1
                    EndIf
                    
                  Else
                    ;                     If \part(k)\obj$ = "_ref"
                    ;                       message(Str(k)+" : "+Str(xa)+"/"+Str(ya)+"/"+Str(x)+"/"+Str(y)+"/")
                    ;                     EndIf
                    
                    If x>=wec_vx+xa And x<=wec_vx+xa+(s * \part(k)\w) And y>=wec_vy+ya And y<=wec_vy+ya+(s * \part(k)\h)
                      
                      If ImageDepth(\part(k)\img) = 32
                        If StartDrawing(ImageOutput(\part(k)\img))
                          DrawingMode(#PB_2DDrawing_AllChannels)
                          x1 = x - wec_vx - \part(k)\Finalx
                          y1 = y - wec_vy - \part(k)\FinalY
                          ;Debug ""+x1+"/"+y1+" | "+ImageWidth(\part(k)\img)+"/"+ImageHeight(\part(k)\img)
                          If x1>=0 And y1>=0 And x1<ImageWidth(\part(k)\img) And y1<ImageHeight(\part(k)\img)
                            color.i=Point(x1,y1)
                            ;Debug "color : "+Str(color)+" / alpha : "+Str(alpha)
                            If Alpha(color)>0
                              CHG_SelectPart(k)
                              okbreak = 1
                            EndIf
                            ; ;                             If \part(k)\obj$ = "_ref"
                            ; ;                               message(Str(k)+" : "+Str(color)+"/"+Str(Alpha(color))+"/")
                            ; ;                             EndIf
                          EndIf
                          StopDrawing()
                        EndIf
                      Else
                        CHG_SelectPart(k)
                        
                        okbreak = 1
                      EndIf
                      
                    EndIf
                  EndIf
                  ; on va déplacer un element du template
                  If CHG_CharacterID =1
                    Character(1)\part(k)\startx = x - Character(1)\part(k)\x
                    Character(1)\part(k)\starty = y - Character(1)\part(k)\y
                  EndIf
                  If okbreak = 1 
                    CHG_UpdateListImageFromFolder(\part(k)\obj$)
                    Break
                  EndIf
                EndIf
              Next
              If CHG_ObjID >=0
                CHG_SetGadgetState()
              EndIf
              
              If oldCHG_ObjID <> CHG_ObjID  
                oldCHG_ObjID = CHG_ObjID
                WindowCharacterEditor_updatecanvas()
              EndIf
              ;               If CHG_GetCHG_ObjIDIsOk()
              ;                 wec_start\x = x - \part(CHG_ObjID)\x
              ;                 wec_start\y = y - \part(CHG_ObjID)\y
              ;                 wec_startscale = \part(CHG_ObjID)\scale
              ;               EndIf
            EndWith
            ;EndIf
        
           EndIf
         EndIf
         
      ElseIf EventType() = #PB_EventType_MouseMove
        x = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/z 
        y = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/z
        mx = x
        my = y
        If wec_clic ;And CHG_GetCHG_ObjIDIsOk()
          For i=0 To ArraySize(Character(CHG_CharacterID)\part())
            With Character(CHG_CharacterID)\part(i)
              If \Selected =1 Or i= CHG_ObjID
                If (\hide = 0 Or chg_options\SetTemplate =1) And \locked =0 
                  
                  If CHG_action= #CHG_ActionMove
                    ; move the selected object
                    If wec_shift=0 
                      \x = x - \startx
                      \y = y - \starty
                      If i = CHG_ObjID
                        SetGadgetState(#G_WinCHG_Edit_X,  \x)
                        SetGadgetState(#G_WinCHG_Edit_Y,  \y)
                      EndIf
                    Else
                      \scale = (x - \startx)/(\w*0.01) + \StartScale
                      If \scale<=0
                        \scale = 1
                      EndIf
                      If i = CHG_ObjID
                        SetGadgetState(#G_WinCHG_Edit_scale, \Scale)
                      EndIf
                    EndIf
                  ElseIf chg_action = #CHG_ActionRotate
                    \Rotation = \StartRot +(x - wec_startX) 
                    If i = CHG_ObjID
                      SetGadgetState(#G_WinCHG_Edit_Rotate, \Rotation)
                    EndIf
                  ElseIf chg_action = #CHG_ActionScale
                    \scale = (x - \startX)/(\w*0.01) + \StartScale
                    If \scale<=0
                      \scale = 1
                    EndIf
                    \finalcx = \cx * \scale * 0.01
                    \finalcx = \cy * \scale * 0.01
                    If i = CHG_ObjID
                      SetGadgetState(#G_WinCHG_Edit_scale, \Scale)
                    EndIf
                  EndIf
                  
                  If CHG_Options\SetTemplate = 1
                    CHG_SetCharacterPropFromTemplate()
                  EndIf
                  
                EndIf
              EndIf 
            EndWith
          Next
        EndIf
        WindowCharacterEditor_updatecanvas()
      EndIf
    EndIf
  ElseIf EventType() = #PB_EventType_MouseMove 
    x = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/z 
    y = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/z
    mx = x
    my = y
;     Debug "move : "+Str(mx)+"/"+Str(my)
  EndIf
  
  If EventType() = #PB_EventType_LeftButtonUp
    WEC_clic = 0
;     mx = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/z 
;     my = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/z
    ; Debug "clicup :"+Str(mx)+"/"+Str(my)
    
;   ElseIf EventType() = #PB_EventType_MouseMove
;     x = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/z 
;     y = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/z
;     mx = x
;     my = y
    
  ElseIf EventType() = #PB_EventType_MouseWheel
    ;{ zoom
    delta = GetGadgetAttribute(gad, #PB_Canvas_WheelDelta)
    If delta =1
      If CHG_Options\Zoom<30
        CHG_Options\Zoom + 1
      ElseIf CHG_Options\Zoom<100
        CHG_Options\Zoom + 10
      Else
        CHG_Options\Zoom + 20
      EndIf
      WindowCharacterEditor_updatecanvas()
    ElseIf delta = -1
      If CHG_Options\Zoom > 100
        CHG_Options\Zoom -20
      ElseIf CHG_Options\Zoom > 30
        CHG_Options\Zoom -10
      ElseIf CHG_Options\Zoom > 1
        CHG_Options\Zoom -1
      EndIf
      
      WindowCharacterEditor_updatecanvas()
    EndIf
    
    ;}
    
  ElseIf EventType() = #PB_EventType_KeyUp 
    ;{ key up
    If GetGadgetAttribute(gad, #PB_Canvas_Key) = #PB_Shortcut_Space 
      wec_space= 0                           
    EndIf                        
    If GetGadgetAttribute(gad, #PB_Canvas_Key)= 16 ; shift 
      wec_shift= 0                           
    EndIf  
    If GetGadgetAttribute(gad, #PB_Canvas_Key)= 17 ; ctrl 
     wec_ctrl= 0                           
    EndIf 
    ;}
  EndIf
  
  
EndProcedure
Procedure WindowCharacterEditor_updatecanvas()
  
  ; update the main canvas
  vx = CHG_Options\viewx
  vy = CHG_Options\viewy
  ; zoom
  If CHG_Options\Zoom<=0
    CHG_Options\Zoom=100
  EndIf
  
  z.d = CHG_Options\Zoom * 0.01
  
  With VD_camera(cameraid)
    px = \x 
    py = \y 
    pw = \w 
    ph = \h
  EndWith
  
  If StartVectorDrawing(CanvasVectorOutput(#G_WinCHG_CanvasMain))
    AddPathBox(0,0,GadgetWidth(#G_WinCHG_CanvasMain),GadgetHeight(#G_WinCHG_CanvasMain))
    VectorSourceColor(RGBA(100,100,100,255))
    FillPath()
    
    TranslateCoordinates(vx,vy)
    ScaleCoordinates(z,z)
    ; bg color
    If CHG_Options\UseBG
      AddPathBox(0,0,pw,ph)
      VectorSourceColor(Character(0)\BG)
      FillPath()
    EndIf
  
    If CHG_Options\useClipping
      AddPathBox(0,0,pw,ph)
      ClipPath()
    EndIf
  
    CHG_DrawTheCharacter()
    StopVectorDrawing()
  EndIf
  
EndProcedure

Procedure WindowCharacterEditor()
  Shared Folder$ 
  Shared wec_vx, wec_vy, CHG_BankImageID,wec_Shift, wec_ctrl, wec_Space
  Static Old_CHG_CharacterID
  
  ;{ on initialise ce qui est nécessaire
  CHG_OptionsLoad()
  InitLang()
  ; temporaire
  Folder$ =  CHG_options\FolderProject$ ; GetCurrentDirectory() +"data\projects\moyfys\"
  ; CHG_doc\FolderProject$ = Folder$
  ; Debug folder$
  CHG_PreLoadTemplatesBank()
  CHG_OpenObjectCenter()
  CHG_InitCharacter()
  winW = 1024
  winH = 600
  If ExamineDesktops()
    winW = DesktopWidth(0)
    winH = DesktopHeight(0)
  EndIf
  win = #Win_CHG_CharacterEditor
  ;}
  If OpenWindow(win, 0, 0, winw, winH, #CHG_ProgramName+" "+#CHG_ProgramVersion, #PB_Window_ScreenCentered|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget|#PB_Window_SizeGadget|#PB_Window_SystemMenu) ;, WindowID(#Win_CHG_main))
    ;{ init, menu, gadgets...
    OnErrorCall(@ErrorHandler()) 
    CHG_InitImages()
    ;{ menu
    CHG_CreateTheMenu(win)
    ;}
    ;{ Gadgets
    CHG_CreateTheGadgets()
    ;}
    ResizeWindow(win, #PB_Ignore , #PB_Ignore, winW ,winH)
    SetWindowState(win, #PB_Window_Maximize)
    WindowBounds(win, 750, 500, #PB_Ignore, #PB_Ignore)
    CreateOtherLangKeywords()
    SaveLang()
    ;}
    
    Repeat
      
      Event = WaitWindowEvent(1)
      EventGadget = EventGadget()
      
      z.d = CHG_Options\Zoom *0.01
      vx = CHG_Options\viewx
      vy = CHG_Options\viewy
      
      If Event = #PB_Event_Gadget And EventType() = #PB_EventType_DragStart
        Select EventGadget()
          Case #G_WinCHG_Bank_CanvasPreviewObject
            FreeImage2(#CHG_image_Drag)
            ImageFolder$ = folder$ +"images\"
            obj$ = GetGadgetText(#G_WinCHG_Bank_ListFolderImage)
            file$ = ImageFolder$+obj$+"\"+BankImages(CHG_BankImageID)\Name$
            If LoadImage(#CHG_image_Drag,file$)
              DragImage(ImageID(#CHG_image_Drag))
            EndIf
        EndSelect
        
      Else
        
        Select event
          Case #PB_Event_Menu
             CHG_EventMenuMain()
            
          Case #PB_Event_Gadget
           Select EventWindow()
            
             Case #Win_CHG_CharacterEditor 
               gad = 0
               ; on supprime les shortcut si on est sur un gadget type string ou spin
               If IsGadget(EventGadget)
                 result = GadgetType(EventGadget)
                 If result = #PB_GadgetType_Spin Or result = #PB_GadgetType_String          
                   If EventType() = #PB_EventType_LostFocus   
                     CHG_ChangeShortCut()
                   Else ; If EventType() = #PB_EventType_Focus Or EventType() =  #PB_EventType_Change          
                     CHG_ChangeShortCut(0)
                   EndIf
                 Else
                   CHG_ChangeShortCut()
                 EndIf
               EndIf
               
               If EventGadget< #G_WinCHG_TbLAST
                 ;{ toolbar event
                 If EventGadget>=#G_WinCHG_TbAdd
                   CHG_action = EventGadget-#G_WinCHG_TbAdd
                   For i= #G_WinCHG_TbAdd To #G_WinCHG_TbLAST-1
                     SetGadgetState(i,0)
                   Next
                   SetGadgetState(EventGadget,1)
                 Else
                   Select EventGadget
                     Case #G_WinCHG_TbNew
                       CHG_Doc_New() 
                     Case #G_WinCHG_TbOpen
                       CHG_Doc_Open() 
                     Case #G_WinCHG_TbSave
                       CHG_Doc_Save("",1)
                   EndSelect
                 EndIf
                 ;}
               ElseIf EventGadget>=#G_WinCHG_Edit_Name And EventGadget<=#G_WinCHG_Edit_locked
                 ;{ panel left tab edit event
                 value = GetGadgetState(EventGadget)
                 If GadgetType(EventGadget)=#PB_GadgetType_String
                   value$= GetGadgetText(EventGadget)
                 EndIf
                 CHG_SetCharacterPropertie(EventGadget-#G_WinCHG_Edit_Name,value,value$)
                 ;}
               Else  
                 ; other event gadgets
                 Select EventGadget
                   Case #G_WinCHG_CanvasMain
                     CHG_EventMainCanvas()
                     ;{ tab edit
                   Case #G_WinCHG_Edit_SelectPart
                     ;{ select part (list)
                     CHG_ObjID = GetGadgetState(EventGadget)
                     If wec_ctrl = 0
                       CHG_SelectAll(0)
                     EndIf
                     CHG_SetGadgetState()
                     WindowCharacterEditor_updatecanvas()
                     ;}
                   Case #G_WinCHG_Edit_SetTemplate
                     ;{ set template
                     CHG_Options\SetTemplate = GetGadgetState(EventGadget)
                     CHG_CharacterID =  CHG_Options\SetTemplate
                     CHG_UpdatePartlist()
                     CHG_SetGadgetState()
                     ;}
                     ;}
                     ;{ tab Bank
                   Case #G_WinCHG_Bank_ProjectFolder
                     CHG_UpdateProjectFolder(1, GetGadgetState(EventGadget))
                   Case #G_WinCHG_Bank_CanvasObjCenter
                      CHG_EventCanvasCenterImage()
                    Case #G_WinCHG_Bank_CanvasPreviewObject
                       CHG_EventCanvasImageObject()
                   Case #G_WinCHG_Bank_TemplateSelect
                     pos = GetGadgetState(EventGadget)
                     Character(0)\template$ = CHG_OpenTemplate("",pos,1)
                   Case #G_WinCHG_Bank_ListFolderImage
                     CHG_UpdateListImageFromFolder()
                   Case #G_WinCHG_Bank_AddObject
                     CHG_AddPart()
                   Case #G_WinCHG_Bank_TemplateSave 
                     CHG_SaveTemplate()
                     ;}
                     ;{ tab colors
                   Case #G_WinCHG_Color_TechnicUsed
                     CHG_Options\technicForColoring = GetGadgetState(#G_WinCHG_Color_TechnicUsed)
                     Debug CHG_Options\technicForColoring
                     i=CHG_ColorId
                     Character(0)\Color(i)\Saturation= GetGadgetState(#G_WinCHG_Color_Saturation)
                     Character(0)\Color(i)\luminosity= GetGadgetState(#G_WinCHG_Color_Luminosity)
                     Character(0)\SkinBrightness = Character(0)\Color(1)\luminosity
                     Character(0)\HairBrightness = Character(0)\Color(2)\luminosity
                     Character(0)\Color(i)\hue= GetGadgetState(#G_WinCHG_Color_Hue)
                     Character(0)\SkinHue = Character(0)\Color(1)\hue
                     Character(0)\HairHue = Character(0)\Color(2)\hue
                     CHG_updateCanvasColors()
                     WindowCharacterEditor_updatecanvas()
                   Case #G_WinCHG_Color_CanvasColor
                      CHG_EventCanvasColors()
                    Case #G_WinCHG_Color_Luminosity, #G_WinCHG_Color_Saturation
                      i=CHG_ColorId
                      Character(0)\Color(i)\Saturation= GetGadgetState(#G_WinCHG_Color_Saturation)
                      Character(0)\Color(i)\luminosity= GetGadgetState(#G_WinCHG_Color_Luminosity)
                      Character(0)\SkinBrightness = Character(0)\Color(1)\luminosity
                      Character(0)\HairBrightness = Character(0)\Color(2)\luminosity
                      CHG_updateCanvasColors()
                      WindowCharacterEditor_updatecanvas()
                       
                   Case #G_WinCHG_Color_Hue
                      ;c= Character(0)\Color(CHG_ColorId)
                      ;Color = ColorRequester(RGB(Red(c),Green(c),Blue(c)))
                      ;If color<>-1
                     i=CHG_ColorId
                     ; Debug i
                       Character(0)\Color(i)\hue= GetGadgetState(#G_WinCHG_Color_Hue)
                       Character(0)\SkinHue = Character(0)\Color(1)\hue
                       Character(0)\HairHue = Character(0)\Color(2)\hue
                       ; Debug "ok color"
                       ;color ; RGBA(Red(color),Green(color),Blue(color),255)
                       CHG_updateCanvasColors()
                       WindowCharacterEditor_updatecanvas()
                     ;EndIf
                   Case #G_WinCHG_Color_NewColor
                     ;Color = ColorRequester()
                     ;If color<>-1
                       Character(0)\NbColor+1
                       i=Character(0)\NbColor
                       ReDim Character(0)\Color(i)
                       Character(0)\Color(i)\hue= 100 ; RGBA(Red(color),Green(color),Blue(color),255)
                       Character(0)\Color(i)\Luminosity = 50 ; RGBA(Red(color),Green(color),Blue(color),255)
                       Character(0)\Color(i)\Saturation = 50 ; RGBA(Red(color),Green(color),Blue(color),255)
                       CHG_updateCanvasColors()
                       ;WindowCharacterEditor_updatecanvas()
                     ;EndIf
                   Case #G_WinCHG_Color_SetBG 
                     Color = ColorRequester(RGB(Red(Character(0)\BG),Green(Character(0)\BG),Blue(Character(0)\BG)))
                     If color<>-1
                       Character(0)\BG=RGBA(Red(color),Green(color),Blue(color),255)
                       WindowCharacterEditor_updatecanvas()
                     EndIf
                   Case #G_WinCHG_Color_UseBG 
                     CHG_Options\UseBG = GetGadgetState(#G_WinCHG_Color_UseBG)
                     WindowCharacterEditor_updatecanvas()
                     
                     ;}
                     ;{ other gadgets
                     ;             Case #G_Win_BtnOk
                     ;               quit = 1
                     ;               
                     ;             Case #G_Win_BtnCancel
                     ;               quit = 2
                     ;}
                 EndSelect 
               EndIf
           EndSelect          
           
          Case #PB_Event_GadgetDrop
           Select EventWindow()
             Case #Win_CHG_CharacterEditor 
               Select EventGadget()  
                 Case #G_WinCHG_CanvasMain
                   If EventDropImage(#CHG_image_Drag)
                     ; on ajoute un objet
                     mx = (WindowMouseX(win)-GadgetX(#G_WinCHG_CanvasMain))/z 
                     my = (WindowMouseY(win)-GadgetY(#G_WinCHG_CanvasMain))/z 
                     ; Debug Str(mx)+"/"+Str(my)
                     CHG_AddPart(1,mx-VD_camera(cameraId)\w/2-vx/z,my-VD_camera(cameraId)\h/2-vy/z)
                   EndIf
               EndSelect
           EndSelect   
           
          Case #PB_Event_SizeWindow
            WindowCharacterEditor_updatecanvas()
 
          Case #PB_Event_CloseWindow
            quit = 2
          
        EndSelect
      
      EndIf
    
    Until quit >= 1
    
    SaveLang()
    
    If  CHG_Options\NewLang$ <>  CHG_Options\Lang$
      CHG_Options\Lang$ = CHG_Options\NewLang$
    EndIf
    
    CHG_OptionsSave()
    CloseWindow(#Win_CHG_CharacterEditor)
    
  EndIf  
  
EndProcedure

;}
;}

WindowCharacterEditor()

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 4
; Folding = r-sDAgAQw0wjPAAAAAAA--xfQAAAgu0BAAAAAAAAAAAAMNAAAAofAAAAAgPQEAAAAAAAAAAACVPweAeAYAAAw-B8dNgAAAAAAAAAAJkRYAk-
; EnableAsm
; EnableXP
; EnableOnError
; UseIcon = generatoon.ico
; Executable = generatoon.exe
; DisableDebugger
; Warnings = Display
; EnablePurifier
; EnableCompileCount = 422
; EnableBuildCount = 3