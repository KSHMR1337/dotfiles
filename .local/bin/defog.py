#!/usr/bin/env python3

import re
import sys
import subprocess
from pathlib import Path
from typing import List, Tuple, Dict
import tempfile


# Hardcoded constant values that are typically not found in decompiled code
KNOWN_CONSTANTS = {
    "Byte.MAX_VALUE": "127",
    "Byte.MIN_VALUE": "-128",
}


def search_function_calls(function_name: str, source_folder: str) -> List[str]:
    try:
        # Search for lines containing the function name
        result = subprocess.run(
            ["rg", "--no-filename", function_name, source_folder],
            capture_output=True,
            text=True,
            check=True,
        )
        lines = result.stdout.strip().split("\n")

        # Filter to only lines that look like actual function calls with byte arrays
        full_lines = []
        for line in lines:
            # Must contain the function name followed by opening paren and new byte[]
            if f"{function_name}(" in line and "new byte[]" in line:
                full_lines.append(line)

        return full_lines
    except subprocess.CalledProcessError:
        print(f"Error: No matches found for function '{function_name}'")
        return []
    except FileNotFoundError:
        print("Error: ripgrep (rg) not found. Please install ripgrep.")
        sys.exit(1)


def extract_constants(lines: List[str]) -> List[str]:
    constants = set()

    # Pattern to match identifiers like org.apache.bcel.Constants.T_UNKNOWN
    # But only within byte array declarations
    pattern = r"[a-zA-Z$_][a-zA-Z0-9$_.]*\.[A-Z_][a-zA-Z0-9_]*"

    for line in lines:
        # Only search within byte array brackets
        byte_arrays = re.findall(r"new byte\[\]\{([^}]+)\}", line)
        for array_content in byte_arrays:
            matches = re.findall(pattern, array_content)
            constants.update(matches)

    return sorted(constants)


def resolve_constant(constant_name: str, source_folder: str) -> str:
    """Resolve a constant to its numeric value."""
    # Check if it's a known constant first
    if constant_name in KNOWN_CONSTANTS:
        return KNOWN_CONSTANTS[constant_name]

    try:
        # Extract the constant field name (last part after dot)
        field_name = constant_name.split(".")[-1]

        # Search for the constant definition
        result = subprocess.run(
            ["rg", "-N", f" {field_name} =", source_folder],
            capture_output=True,
            text=True,
        )

        if result.returncode == 0:
            # Parse the value from the first match
            for line in result.stdout.split("\n"):
                # Match patterns like: public static final byte T_UNKNOWN = 15;
                match = re.search(rf"{field_name}\s*=\s*(-?\d+)", line)
                if match:
                    return match.group(1)

        print(f"Warning: Could not resolve constant '{constant_name}'")
        return None

    except Exception as e:
        print(f"Error resolving constant '{constant_name}': {e}")
        return None


def replace_constants_in_text(text: str, replacements: Dict[str, str]) -> str:
    """Replace all constant references with their numeric values."""
    result = text
    for constant, value in replacements.items():
        if value is not None:
            # Escape dots in constant name for regex
            escaped_constant = re.escape(constant)
            result = re.sub(escaped_constant, value, result)
    return result


def parse_byte_array(array_str: str) -> List[int]:
    """Parse a byte array string into a list of integers."""
    # Extract content between braces
    match = re.search(r"\{([^}]+)\}", array_str)
    if not match:
        return []

    content = match.group(1)
    # Split by comma and parse each value
    values = []
    for val in content.split(","):
        val = val.strip()
        if val:
            try:
                values.append(int(val))
            except ValueError:
                print(f"Warning: Could not parse value '{val}' in array")

    return values


def extract_byte_arrays(line: str) -> Tuple[List[int], List[int]]:
    """Extract two byte arrays from a function call line."""
    # Find all byte array patterns: new byte[]{...}
    # Need to handle nested braces carefully
    pattern = r"new byte\[\]\{([^}]+)\}"
    matches = re.findall(pattern, line)

    if len(matches) < 2:
        # Debug: print what we found
        # print(f"Debug: Found only {len(matches)} arrays in line: {line[:100]}...")
        return None, None

    # Parse first two arrays
    array1 = parse_byte_array(f"{{{matches[0]}}}")
    array2 = parse_byte_array(f"{{{matches[1]}}}")

    if not array1 or not array2:
        return None, None

    return array1, array2


def xor_arrays_old(arr1: List[int], arr2: List[int]) -> Tuple[List[int], str]:
    """
    OLD IMPLEMENTATION - XOR two byte arrays and return both numeric and ASCII representation.
    This implementation was incorrect - it didn't wrap arr2 when shorter than arr1.
    """
    if not arr1 or not arr2:
        return [], ""

    # XOR corresponding elements
    max_len = max(len(arr1), len(arr2))
    result = []

    for i in range(max_len):
        val1 = arr1[i] if i < len(arr1) else 0
        val2 = arr2[i] if i < len(arr2) else 0

        # Convert to signed byte range (-128 to 127)
        if val1 > 127:
            val1 = val1 - 256
        if val2 > 127:
            val2 = val2 - 256

        xor_val = val1 ^ val2
        result.append(xor_val)

    # Convert to ASCII string
    ascii_result = ""
    for val in result:
        # Convert back to unsigned byte for ASCII
        byte_val = val if val >= 0 else val + 256
        if 32 <= byte_val <= 126:  # Printable ASCII
            ascii_result += chr(byte_val)
        else:
            ascii_result += chr(byte_val) if byte_val < 256 else "?"

    return result, ascii_result


def xor_arrays(arr1: List[int], arr2: List[int]) -> Tuple[List[int], str]:
    if not arr1 or not arr2:
        return [], ""

    length1 = len(arr1)
    length2 = len(arr2)
    result = []

    i2 = 0
    for i in range(length1):
        if i2 >= length2:
            i2 = 0

        val1 = arr1[i]
        val2 = arr2[i2]

        if val1 > 127:
            val1 = val1 - 256
        if val2 > 127:
            val2 = val2 - 256

        xor_val = val1 ^ val2
        result.append(xor_val)

        i2 += 1

    byte_values = []
    for val in result:
        byte_val = val if val >= 0 else val + 256
        byte_values.append(byte_val)

    try:
        ascii_result = bytes(byte_values).decode("utf-8", errors="replace")
    except Exception:
        ascii_result = "".join(chr(b) if b < 128 else "?" for b in byte_values)

    return result, ascii_result


def main():
    if len(sys.argv) != 3:
        print("Usage: python process_data.py <source_folder> <function_name>")
        print("\nExample:")
        print("    python process_data.py ./sources AbstractC9535xD1.m16982implements")
        sys.exit(1)

    source_folder = sys.argv[1]
    function_name = sys.argv[2]

    # Validate source folder
    if not Path(source_folder).exists():
        print(f"Error: Source folder '{source_folder}' does not exist")
        sys.exit(1)

    print(f"[1] Searching for function calls: {function_name}")
    lines = search_function_calls(function_name, source_folder)

    if not lines:
        print("No function calls found.")
        sys.exit(1)

    print(f"    Found {len(lines)} function calls")

    # Save original lines to temporary file
    with tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".txt") as tmp:
        tmp_file = tmp.name
        for line in lines:
            if ":" in line:
                func_pos = line.find(function_name)
                if func_pos != -1:
                    line = line[func_pos:]
            tmp.write(line + "\n")

    print(f"[2] Extracting constant references")

    with open(tmp_file, "r") as f:
        cleaned_lines = f.readlines()

    constants = extract_constants(cleaned_lines)
    print(f"    Found {len(constants)} unique constants")

    if constants:
        print(f"[3] Resolving constant values")
        replacements = {}
        for const in constants:
            value = resolve_constant(const, source_folder)
            if value:
                replacements[const] = value
                print(f"    {const} = {value}")

        print(f"[4] Replacing constants in arrays")
        with open(tmp_file, "r") as f:
            content = f.read()

        content = replace_constants_in_text(content, replacements)

        # Write back
        with open(tmp_file, "w") as f:
            f.write(content)

        # Read updated lines
        with open(tmp_file, "r") as f:
            cleaned_lines = f.readlines()

    print(f"[5] XORing byte arrays and generating output")

    output_lines = []
    xor_only_lines = []
    skipped = 0

    for line in cleaned_lines:
        arr1, arr2 = extract_byte_arrays(line)

        if arr1 and arr2:
            xor_result, ascii_result = xor_arrays(arr1, arr2)

            arr1_str = "{" + ", ".join(map(str, arr1)) + "}"
            arr2_str = "{" + ", ".join(map(str, arr2)) + "}"

            output_line = f"{arr1_str}, {arr2_str}, {ascii_result}"
            output_lines.append(output_line)

            xor_only_lines.append(ascii_result)
        else:
            skipped += 1

    if skipped > 0:
        print(f"    Skipped {skipped} lines (couldn't extract 2 byte arrays)")

    output_file = "processed.txt"
    with open(output_file, "w", encoding="utf-8") as f:
        for line in output_lines:
            f.write(line + "\n")

    xor_output_file = "xor_output.txt"
    with open(xor_output_file, "w", encoding="utf-8") as f:
        for line in xor_only_lines:
            f.write(line + "\n")

    Path(tmp_file).unlink()

    print(f"\n✓ Processing complete!")
    print(f"  Full output saved to: {output_file}")
    print(f"  XOR-only output saved to: {xor_output_file}")
    print(f"  Processed {len(output_lines)} byte array pairs")


if __name__ == "__main__":
    main()
