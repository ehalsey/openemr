import re
from collections import OrderedDict
import json

def parse_schema(file_path):
    """
    Parse a MySQL schema.sql file and create a data dictionary.
    Returns a dictionary with table names as keys and column details as values.
    """
    # Initialize the data dictionary
    data_dict = OrderedDict()

    # Read the schema file
    with open(file_path, 'r') as f:
        schema_content = f.read()

    # Normalize line endings and remove excessive whitespace
    schema_content = re.sub(r'\n\s*', '\n', schema_content)

    # Regex to match CREATE TABLE statements (improved for MariaDB syntax)
    table_pattern = r'CREATE TABLE `(\w+)` \((.*?)\)\s*ENGINE=\w+.*?(?:COLLATE=\w+)?;'
    tables = re.findall(table_pattern, schema_content, re.DOTALL)

    # Regex to match column definitions (more flexible for OpenEMR/MariaDB)
    column_pattern = r'`(\w+)`\s+([A-Za-z0-9_]+\s*(?:\([^)]+\))?(?:\s+UNSIGNED)?(?:\s+ZEROFILL)?)\s*(NOT NULL|NULL)?(?:\s*DEFAULT\s*([^,\n]+(?:\s+ON\s+UPDATE\s+[^,\n]+)?))?(?:\s*AUTO_INCREMENT)?(?:\s*COMMENT\s*[\'"].*?[\'"])?'

    for table_name, columns_block in tables:
        # Remove non-column lines (PRIMARY KEY, KEY, etc.)
        columns_block = re.sub(r',\s*(?:PRIMARY\s+KEY|KEY|UNIQUE\s+KEY|CONSTRAINT).*?(,|$)', '', columns_block, flags=re.DOTALL)
        columns_block = columns_block.strip().rstrip(',')

        # Find all columns in the table
        columns = re.findall(column_pattern, columns_block, re.IGNORECASE)

        # Build the table entry in the data dictionary
        table_dict = OrderedDict()
        for col_name, col_type, nullability, default in columns:
            col_details = {
                'type': col_type.strip(),
                'nullable': 'YES' if nullability == 'NULL' or not nullability else 'NO',
            }
            if default:
                # Clean up default value (handle CURRENT_TIMESTAMP, quoted strings, etc.)
                default = default.strip()
                if default.startswith("'") or default.startswith('"'):
                    default = default.strip("'\"")
                elif default.upper() == 'CURRENT_TIMESTAMP':
                    default = 'CURRENT_TIMESTAMP'
                col_details['default'] = default if default != 'NULL' else None
            table_dict[col_name] = col_details

        if table_dict:  # Only add tables with parsed columns
            data_dict[table_name] = table_dict

    return data_dict

def save_data_dictionary(data_dict, output_format='json', output_file='data_dictionary'):
    """
    Save the data dictionary to a file in the specified format (json or txt).
    """
    if output_format == 'json':
        with open(f'{output_file}.json', 'w') as f:
            json.dump(data_dict, f, indent=4)
        print(f"Data dictionary saved as {output_file}.json")
    elif output_format == 'txt':
        with open(f'{output_file}.txt', 'w') as f:
            for table, columns in data_dict.items():
                f.write(f"Table: {table}\n")
                for col, details in columns.items():
                    f.write(f"  {col}:\n")
                    for key, value in details.items():
                        f.write(f"    {key}: {value}\n")
                f.write("\n")
        print(f"Data dictionary saved as {output_file}.txt")
    else:
        raise ValueError("Unsupported output format. Use 'json' or 'txt'.")

def main():
    # Path to your schema.sql file (adjust as needed)
    schema_file = 'schema.sql'

    try:
        # Parse the schema into a data dictionary
        data_dict = parse_schema(schema_file)

        # Print a sample (e.g., patient_data table) to console
        if 'patient_data' in data_dict:
            print("Sample: patient_data table")
            for col, details in data_dict['patient_data'].items():
                print(f"  {col}: {details}")
        else:
            print("patient_data table not found in schema. Here’s a sample table:")
            for table, columns in list(data_dict.items())[:1]:
                print(f"Table: {table}")
                for col, details in columns.items():
                    print(f"  {col}: {details}")

        # Save the full data dictionary
        save_data_dictionary(data_dict, output_format='json', output_file='openemr_data_dictionary')

    except FileNotFoundError:
        print(f"Error: {schema_file} not found. Please ensure the file exists in the current directory.")
    except Exception as e:
        print(f"Error parsing schema: {str(e)}")

if __name__ == "__main__":
    main()