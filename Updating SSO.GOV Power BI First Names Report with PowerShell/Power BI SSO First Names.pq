/*
Power BI Queries within Power BI SSO First Names.pbix
Query organization:
Transform File from namesByZip
    + Helper Queries
        - Sample File
        - Parameter1 (Sample File)
        - Transform File
        - Transform Sample File
    + Other Queries
        - NameByZip

*/

// Transform File from namesByZip > Helper Queries > Sample File 
let
    Source = Folder.Files("C:\Temp\NamesByZip"),
    #"Filtered Rows" = Table.SelectRows(Source, each ([Extension] = ".TXT")),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows",{"Extension", "Date accessed", "Date modified", "Date created", "Attributes", "Folder Path"}),
    Navigation1 = #"Removed Columns"{0}[Content]
in
    Navigation1

// Transform File from namesByZip > Helper Queries > Parameter1 (Sample File)
#"Sample File" meta [IsParameterQuery=true, BinaryIdentifier=#"Sample File", Type="Binary", IsParameterQueryRequired=true]

// Transform File from namesByZip > Helper Queries > Transform File
let
    Source = (Parameter1) => let
        Source = Csv.Document(Parameter1,[Delimiter=",", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None])
    in
        Source
in
    Source

// Transform File from namesByZip > Helper Queries > Transform Sample File
let
    Source = Csv.Document(Parameter1,[Delimiter=",", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None])
in
    Source


/*
Transform File from namesByZip > Other Queries > NamesByZip

This Power Query script uses the traditional method of loading a folder of files with the TXT files from SSO.GOV.
*/
let
    Source = Folder.Files("C:\Temp\NamesByZip"),
    #"Filtered Rows" = Table.SelectRows(Source, each ([Extension] = ".TXT")),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows",{"Extension", "Date accessed", "Date modified", "Date created", "Attributes", "Folder Path"}),
    #"Filtered Hidden Files1" = Table.SelectRows(#"Removed Columns", each [Attributes]?[Hidden]? <> true),
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File", each #"Transform File"([Content])),
    #"Removed Other Columns1" = Table.SelectColumns(#"Invoke Custom Function1",{"Name", "Transform File"}),
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File", Table.ColumnNames(#"Transform File"(#"Sample File"))),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Table Column1",{{"Column1", type text}, {"Column2", type text}, {"Column3", Int64.Type}, {"Column4", type text}, {"Column5", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Name", "File Name"}, {"Column1", "State"}, {"Column2", "Gender"}, {"Column3", "Year"}, {"Column4", "First Name"}, {"Column5", "Occurrences"}})
in
    #"Renamed Columns"