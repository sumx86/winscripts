'Run this script after building the application!
Option Explicit

dim hkey: hkey = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run\"
dim bdir: bdir = "\build\Debug\"
dim exe: exe = "s-arp.exe"
dim wsh: set wsh = CreateObject("WScript.Shell")
dim fso: set fso = CreateObject("Scripting.FileSystemObject")

wsh.RegWrite hkey & exe, fso.GetParentFolderName(WScript.ScriptFullName) & bdir & exe, "REG_SZ"

set wsh = Nothing
set fso = Nothing
