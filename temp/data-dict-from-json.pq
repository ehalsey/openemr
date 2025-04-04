let
    // Load the JSON file
    Source = Json.Document(File.Contents("C:\source\openemr\temp\openemr_data_dictionary.json")),

    // Convert the JSON record into a table of tables (table name and its columns)
    TablesToTable = Table.FromList(
        Record.FieldNames(Source),
        (tableName) => {tableName, Record.Field(Source, tableName)},
        {"Table Name", "Columns"}
    ),

    // Expand the Columns record into a nested table
    ExpandColumns = Table.TransformColumns(
        TablesToTable,
        {"Columns", each Record.ToTable(_), type table [Name = text, Value = record]}
    ),

    // Expand the nested Columns table into rows
    ExpandColumnsTable = Table.ExpandTableColumn(
        ExpandColumns,
        "Columns",
        {"Name", "Value"},
        {"Column Name", "Column Details"}
    ),

    // Expand the Column Details record into individual columns (type, nullable, default)
    ExpandDetails = Table.ExpandRecordColumn(
        ExpandColumnsTable,
        "Column Details",
        {"type", "nullable", "default"},
        {"Type", "Nullable", "Default"}
    ),

    // Set column order and data types
    ReorderColumns = Table.ReorderColumns(
        ExpandDetails,
        {"Table Name", "Column Name", "Type", "Nullable", "Default"}
    ),
    SetTypes = Table.TransformColumnTypes(
        ReorderColumns,
        {
            {"Table Name", type text},
            {"Column Name", type text},
            {"Type", type text},
            {"Nullable", type text},
            {"Default", type any} // Handles null, strings, or other values
        }
    )
in
    SetTypes