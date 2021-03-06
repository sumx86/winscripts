'SETUP PAYDAY THE HEIST
'xinput     - http://download.game155.com/zip/xinput1_3.dll.zip
'd3dx9_40   - http://download.game155.com/zip/d3dx9_40.dll.zip

Option Explicit

dim url: url = "http://download.game155.com/zip/"
dim gameFolder: gameFolder = "C:\Program Files (x86)\Steam\steamapps\common\PAYDAY The Heist\"
dim xhttp: set xhttp = CreateObject("Microsoft.XMLHTTP")
dim adodb: set adodb = CreateObject("Adodb.Stream")

dim count: count = 0
dim zip: zip = "xinput1_3.dll.zip"
if downloadFile(url & zip, gameFolder) = 200 then
	if MsgBox(zip & " will be extracted to " & "[ " & gameFolder & " ]. " & "Do you want to proceed? ",_
			vbYesNo, "Confirmation required") = vbYes then
		Extract gameFolder & zip, gameFolder
		count = count + 1
	end if
else
	MsgBox "Error downloading" & zip & "! [Code " & xhttp.Status & "]"
end if

zip = "d3dx9_40.dll.zip"
if downloadFile(url & zip, gameFolder) = 200 then
	if MsgBox(zip & " will be extracted to " & "[ " & gameFolder & " ]. " & "Do you want to proceed? ",_
			vbYesNo, "Confirmation required") = vbYes then
		Extract gameFolder & zip, gameFolder
		count = count + 1
	end if
else
	MsgBox "Error downloading" & zip & "! [Code " & xhttp.Status & "]"
end if

MsgBox count & " files extracted.", vbOKOnly + vbInformation, "Ready"

function downloadFile(ByVal url, ByVal filepath)
	xhttp.Open "GET", url, False
	xhttp.Send
	if xhttp.Status = 200 then
		with adodb
			.type = 1
			.open
			.write xhttp.responseBody
			.savetofile filepath & basename(url), 2
			.close
		end with
	end if
	downloadFile = xhttp.Status
end function

function Extract(ByVal archivepath, ByVal targetpath)
	dim oshell: set oshell = CreateObject("Shell.Application")
	dim source, target

	set source = oshell.NameSpace(archivepath).Items()
	set target = oshell.Namespace(targetpath)
	target.CopyHere source

	set oshell = Nothing
	set source = Nothing
end function

function basename(ByVal filepath)
	dim separator: separator = "/"
	dim items: items = split(filepath, separator): basename = items(ubound(items))
end function

set xhttp = Nothing
set adodb = Nothing
