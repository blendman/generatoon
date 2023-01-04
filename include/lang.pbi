
Structure sLang
  Key$
  Value$
  type.a
EndStructure

; Create the list() for the langage file // on créé la list() pour le fichier de lang
Global NewList LangOk.SLang()
Global NewMap CopyLangOk$()
Global LangExt$=".ini", about$

Procedure LoadLAng()
  
;   Debug CHG_Options\Lang$
  
  ; je charge la langue, pour conserver tous les mots-clefs et commentaire de mon programme.
  If OpenFile(0,"data\lang\"+CHG_Options\Lang$+LangExt$)
    
    s_$ = " = " ; attention, j'utilise les + avec espace lorsque je crée le fichier pref, donc je dois aussi les utiliser icic
    
    While Eof(0)=0
      line$ = ReadString(0)
      If line$ <> ""
        If FindString(line$,s_$)=0
          ; comment
          AddMapElement(CopyLangOk$(), line$)
          CopyLangOk$() = line$
        Else
          ; clef et valeur
          key$ = StringField(line$,1,s_$)
          value$ = StringField(line$,2,s_$)
          AddMapElement(CopyLangOk$(), key$)
          CopyLangOk$() = value$
        EndIf
      EndIf
    Wend
    CloseFile(0)
  EndIf 
EndProcedure

Procedure SaveLang()
  
  ; pour enregistrer le mot ou la phrase dans le dossier de langue
  
  file$  ="data\lang\"+CHG_Options\Lang$+LangExt$
  
  If CreatePreferences(file$)
    ForEach LangOk()
      If LangOk()\type = 0
        WritePreferenceString(LangOk()\Key$, LangOk()\Value$)
      Else
        PreferenceComment(LangOk()\Value$)
      EndIf
    Next
    ClosePreferences()
  EndIf
  
  ; puis, j'enregistre le reste de la map CopyLangOk$()
  If OpenFile(0,file$,#PB_File_Append)
    ForEach CopyLangOk$()
      key$ = MapKey(CopyLangOk$())
      value$ = CopyLangOk$()
      If key$ <> ""
        If key$ <> value$
          ; c'est une clef
          txt$ = key$+ " = "+value$
        Else
          ; commentaire
          txt$ = value$
        EndIf
        WriteStringN(0, txt$)
      EndIf
    Next
    CloseFile(0)
  EndIf
EndProcedure

Procedure AddLangComment(Comment$)
  If comment$ <> ""
    AddElement(LangOk())
    LangOk()\type = 1
    LangOk()\Value$ = Comment$
    LangOk()\Key$ = Comment$
    ; je vérifie dans la map si on a le commentaire, et je le supprime si je le trouve (pour ne pas le réécrire 2 fois si je fais savelang())
    If FindMapElement(CopyLangOk$(), "; "+comment$)
      DeleteMapElement(CopyLangOk$(), "; "+comment$)
    EndIf
  EndIf
EndProcedure

Procedure.s Lang(keyword$, comment$="")
  
  Protected word$
  ; TO define the word by default, if the ini file does'nt have it 
  ; pour définir le mot par défaut, si le fichier ini de langue ne le contient pas.
  
  ; add the comments
  AddLangComment(comment$)
  
  ; d'abord, on va vérifier s'il n'y a pas des charactère interdits :
  Repeat 
    char.s = Mid(keyword$, Len(keyword$)) 
    ; Debug "dernier character : "+char
    If char = " " Or char = "=" Or char = Chr(13) Or char=Chr(10)
      keyword$ = Left(keyword$, Len(keyword$)-1)
    Else
      Break
    EndIf
  ForEver 
  
  ; on vérifie si on le mot dans notre fichier
  file$ = "data\lang\"+CHG_Options\Lang$+LangExt$
  ; puis, on vérifie si on a déjà le mot dans notre fichier
  If OpenPreferences(file$)
    word$ = ReadPreferenceString(keyword$,"")
    ClosePreferences()
    ; To change char # by chr(13)
    If word$ <> #Empty$
      ; then read the word$ with the keyword$ ok
      word$ = ReplaceString(word$,"#",Chr(13))
    EndIf
  EndIf
  
  ; puis, on ajoute le mot à notre liste
  ForEach LangOk()
    If LangOk()\Key$ = keyword$
      LangOk()\Value$ = word$
      find = 1
      Break
    EndIf
  Next
  
  ; on ne l'a pas trouvé, on l'ajoute
  If find=0
    AddElement(LangOk())
    LangOk()\key$ = keyword$
    LangOk()\Value$ = word$
  EndIf
  
  ;  enfin, je vérifie si on a aussi le mot-clef et je le supprime si je le trouve
  If FindMapElement(CopyLangOk$(), keyword$)
    DeleteMapElement(CopyLangOk$(), keyword$)
  EndIf
  
    ; on retourne le mot-clef
  If word$ <> ""
    ProcedureReturn word$
  EndIf
  
  ProcedureReturn keyword$
EndProcedure

Procedure InitLang()
  
  If CHG_Options\Lang$ = ""
    CHG_Options\Lang$ = "eng"
  EndIf
  CHG_Options\NewLang$ = CHG_Options\Lang$
  ; CHG_Options\Lang$ = "fr"
  
  LoadLang()
EndProcedure  

Procedure CreateOtherLangKeywords()
  ; on ajoute les textes pour l'interface
  AddLangComment(" **** Messages ****")
  txt$ = #CHG_ProgramName+" "+lang("is a program to generate (randomly) or create characters, or to create any other 2D assets, like backgrounds, level or maps for games, case of comics or any other cool stuffs.")+Chr(13)
  txt$ + lang("This program is coded in Purebasic, by") +" Blendman, "+lang("since 27 september 2021.")+Chr(13)+Chr(13)
  txt$ + lang("This program is free and open-source (under MIT licence). Please read the licence before to use it.")+Chr(13)+Chr(13)
  txt$ + Lang("Version :")+" "+#CHG_ProgramVersion+Chr(13)
  txt$ + Lang("Build :")+" "+#PB_editor_BuildCount+" ("+#PB_editor_CompileCount+")" +Chr(13)
  txt$ + Lang("Date :")+" "+FormatDate("%yyyy/%mm/%dd (%hh:%ii:%ss)",#PB_Compiler_Date)
  about$ = txt$
  ; autre
  AddLangComment(" **** Other keywords ****")
  lang("Infos")
  lang("Not Implemented")

EndProcedure

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 160
; Folding = c-t-v
; EnableXP