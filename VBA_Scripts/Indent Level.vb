Sub PutColAIndentsinColB() 
    Dim c As Range 
    For Each c In Range(Cells(1, 1), Cells(Rows.Count, 1).End(xlUp)) 
        c.Offset(0, 1) = c.IndentLevel 
    Next c 
End Sub 

IndentLevel

LEN(A47)-LEN(SUBSTITUTE(A47," ",""))
