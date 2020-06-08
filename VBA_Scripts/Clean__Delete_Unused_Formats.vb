' Removes empty cells (outside of the used range) that contain formats.

Sub DeleteUnusedFormats()
Dim lLastRow As Long, lLastColumn As Long
Dim lRealLastRow As Long, lRealLastColumn As Long

'Delete from used range rows & columns that have no data
'Detect end of used range including empty formatted cells

With Range("A1").SpecialCells(xlCellTypeLastCell)
    lLastRow = .Row
    lLastColumn = .Column
End With

'Find end of cells with data
lRealLastRow = Cells.Find("*", Range("A1"), xlFormulas, , xlByRows, xlPrevious).Row
lRealLastColumn = Cells.Find("*", Range("A1"), xlFormulas, , xlByColumns, xlPrevious).Column

'If used range exceeds data, delete unused rows & columns
If lRealLastRow < lLastRow Then
    Range(Cells(lRealLastRow + 1, 1), Cells(lLastRow, 1)).EntireRow.Delete
End If

If lRealLastColumn < lLastColumn Then
    Range(Cells(1, lRealLastColumn + 1), Cells(1, lLastColumn)).EntireColumn.Delete
End If

ActiveSheet.UsedRange 'Resets LastCell
End Sub
