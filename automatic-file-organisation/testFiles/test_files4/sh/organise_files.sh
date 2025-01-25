#!/bin/bash

# A simple Bash script that will organise files into folders by their extensions.

# Use the current directory as the target
directory="."

# List all files in the current directory (excluding subdirectories)
find "$directory" -maxdepth 1 -type f

# Loop through all entries in the current directory, process only files (skip directories),
# extract the file's extension and base name, handle cases where files have no extension
# or an empty extension, and print the results for each file.
for file in * .*; do
	# Skip special entries . and ..
	[[ "$file" == "." || "$file" == ".." ]] && continue

	# Skip Directories
	[ -d "$file" ] && continue
	
	# Extract extension and base name
	extension=$(echo "${file##*.}" | tr '[:upper:]' '[:lower:]')
	base_name="${file%.*}"

	# Handle files without extensions
	if [[ "$file" == "$extension" ]]; then
		extension="no-extension"
	fi

	# Handle empty extensions
	if [[ -z "$extension" ]]; then
		extension="no-extension"
	fi

	# Check if a subdirectory exists with the extension's name
	if [ ! -d "$extension" ]; then
		mkdir "$extension"
		echo "Created subdirectory with name '$extension'."
	else
		echo "Subdirectory with name '$extension' already exists."
	fi

	# Move file to the directory that shares a name with the file's extension.
	mv "$file" "$extension"

	# Print out full file name, base name and extension
	echo "File: $file"
	echo "Base Name: $base_name"
	echo "Extension: $extension"
done
