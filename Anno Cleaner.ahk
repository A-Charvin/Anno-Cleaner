#Requires AutoHotkey v2.0

; --- Variables ---
Documents := A_MyDocuments
BasePath := Documents "\Anno 1800\accounts"
SaveFolders := []
AutosavesToKeep := 5

; --- Function to detect folders ---
DetectFolders() {
    global BasePath, SaveFolders
    SaveFolders := []
    
    if !DirExist(BasePath) {
        return
    }
    
    try {
        Loop Files, BasePath "\*.a7s", "R"
        {
            Folder := A_LoopFileDir
            AlreadyExists := false
            for ExistingFolder in SaveFolders {
                if ExistingFolder = Folder {
                    AlreadyExists := true
                    break
                }
            }
            if !AlreadyExists
                SaveFolders.Push(Folder)
        }
    } catch {
        ; Handle errors silently
    }
}

; --- Initialize ---
DetectFolders()

; --- GUI ---
MyGui := Gui(, "Anno 1800 Autosave Cleaner")
MyGui.Add("Text", , "Select Save Folder:")
FolderCombo := MyGui.Add("ComboBox", "w400")

if SaveFolders.Length > 0 {
    for FullPath in SaveFolders {
        FolderName := ""
        SplitPath(FullPath, &FolderName)
        FolderCombo.Add([FolderName])
    }
}

BrowseBtn := MyGui.Add("Button", "w100", "Browse...")
MyGui.Add("Text", , "Autosaves to keep:")
KeepEdit := MyGui.Add("Edit", "Number w100", AutosavesToKeep)
CleanBtn := MyGui.Add("Button", "w100", "Clean Autosaves")
Output := MyGui.Add("Edit", "ReadOnly w400 h100")

BrowseBtn.OnEvent("Click", BrowseFolder)
CleanBtn.OnEvent("Click", CleanAutosaves)

MyGui.Show("w450 h390")

; --- Functions ---
BrowseFolder(*) {
    global FolderCombo
    SelectedFolder := FileSelect("D", , "Select Anno 1800 Save Folder")
    if SelectedFolder {
        FolderCombo.Text := SelectedFolder
    }
}

CleanAutosaves(*) {
    global FolderCombo, KeepEdit, Output, SaveFolders
    SelectedName := FolderCombo.Text
    Keep := Integer(KeepEdit.Text)

    if SelectedName = "" {
        Output.Text := "❌ Please select a folder!"
        return
    }
    
    Folder := ""
    for FullPath in SaveFolders {
        FolderName := ""
        SplitPath(FullPath, &FolderName)
        if FolderName = SelectedName {
            Folder := FullPath
            break
        }
    }
    
    if Folder = "" {
        Folder := SelectedName
    }
    
    if !DirExist(Folder) {
        Output.Text := "❌ Selected folder does not exist!"
        return
    }

    if Keep <= 0 {
        Output.Text := "❌ Number of autosaves to keep must be greater than 0!"
        return
    }

    Autosaves := []
    
    try {
        Loop Files, Folder "\Autosave*.a7s"
        {
            Autosaves.Push({
                Path: A_LoopFileFullPath,
                ModTime: A_LoopFileTimeModified
            })
        }
    } catch {
        Output.Text := "❌ Error reading files from folder!"
        return
    }

    if Autosaves.Length = 0 {
        Output.Text := "ℹ️ No autosave files found in selected folder."
        return
    }

    ; Simple bubble sort by modification time (newest first)
    if Autosaves.Length > 1 {
        for i in Range(Autosaves.Length - 1) {
            for j in Range(Autosaves.Length - i) {
                if Autosaves[j].ModTime < Autosaves[j + 1].ModTime {
                    temp := Autosaves[j]
                    Autosaves[j] := Autosaves[j + 1]
                    Autosaves[j + 1] := temp
                }
            }
        }
    }

    DeletedCount := 0
    for Index, FileObj in Autosaves {
        if Index > Keep {
            try {
                FileDelete(FileObj.Path)
                DeletedCount++
            } catch {
                Output.Text := "❌ Error deleting file: " . FileObj.Path
                return
            }
        }
    }

    if DeletedCount > 0
        Output.Text := "✅ Deleted " . DeletedCount . " old autosave files from " . SelectedName
    else
        Output.Text := "ℹ️ No files needed to be deleted. Found " . Autosaves.Length . " autosaves, keeping " . Keep
}

Range(n) {
    result := []
    Loop n {
        result.Push(A_Index)
    }
    return result
}

MyGui.OnEvent("Close", (*) => ExitApp())