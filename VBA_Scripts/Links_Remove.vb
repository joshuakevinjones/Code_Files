Sub RemoveLinks()

Dim Link As Variant
    For Each Link In ActiveWorkbook.LinkSources
        ActiveWorkbook.BreakLink Name:=Link, Type:=xlLinkTypeExcelLinks
    Next
'*** Delete the following lines if you don't want to delete 
'*** PrintArea and PrintTitleRows
    ActiveSheet.PageSetup.PrintArea = ""
    ActiveSheet.PageSetup.PrintTitleRows = ""

End Sub
________________________________________
All hyperlinks, internal and external links, and formulae are deleted from the worksheet, but all values are retained…

Option Explicit 
 
Sub DeleteHyperlinks() 
    Dim Query As VbMsgBoxResult 
    Query = MsgBox("CAUTION: Every single link, formula " & _ 
    "& hyperlink on this " & vbLf & _ 
    "sheet will be deleted - Do you " & _ 
    "still want to proceed?", vbYesNo, _ 
    "Sever All Links?") 
    If Query = vbNo Then Exit Sub 
     
     '****remove formulae & external links****
    With Cells 
        .Select 
        .Copy 
        Selection.PasteSpecial Paste:=xlValues 
        Application.CutCopyMode = False 
    End With 
     '**********************************
     '**********************************
     'Remove Hyperlinks
    Cells.Hyperlinks.Delete 
     '**********************************
     
    [A1].Select 
End Sub

________________________________________

Sub Remove_External_Links_in_Cells()

Dim LinkCell
Dim FormulaCells As Range
Dim SheetsInWorkbook As Object

For Each SheetsInWorkbook In Sheets
    SheetsInWorkbook.Activate
    '*** Error trapping if no formulacells found
    On Error Resume Next
    '*** Select only formula cells
    Set FormulaCells = Cells.SpecialCells(xlFormulas)
    '*** Loop every formulacell in sheet
    For Each LinkCell In FormulaCells
        '*** If you want paste linked value as "normal value"
        If InStr(1, LinkCell.Value, ".xls]") = 0 Then
            LinkCell.Value = LinkCell
        End If
    Next
Next
End Sub
