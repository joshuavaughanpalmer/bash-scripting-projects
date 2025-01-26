#!/bin/bash

# A simple Bash script that will organise files into folders by their extensions.

# Take the first argument as the target directory
directory=${1:-.}

# Check if the directory exists
if [ ! -d "$directory" ]; then
	echo "Error: Directory '$directory' does not exist."
	exit 1
fi

# Loop through all entries in the specified directory, process only files (skip directories),
# extract the file's extension and base name, handle cases where files have no extension
# or an empty extension, and print the results for each file.
for file in "$directory"/* "$directory"/.*; do

	# Skip special entries . and ..
	if [[ "$file" == "$directory/." || "$file" == "$directory/.." ]]; then
		echo "Skipping special entry: $file"
		continue
	fi

	# Skip Directories
	if [ -d "$file" ]; then
		echo "Skipping directory: $file"
		 continue
	fi

	# Extract the filename from the full path
	filename=$(basename "$file")
	echo "Processing file: $filename"

	# Extract extension and base name
	extension=$(echo "${filename##*.}" | tr '[:upper:]' '[:lower:]')
	base_name="${filename%.*}"

	# Handle files without extensions
	if [[ "$filename" != *.* ]]; then
		extension="no-extension"
	fi

	# Handle empty extensions
	if [[ -z "$extension" ]]; then
		extension="no-extension"
	fi

	# Check if a subdirectory exists with the extension's name
	if [ ! -d "$directory/$extension" ]; then
		mkdir "$directory/$extension"
		echo "Created subdirectory '$directory/$extension'."
	else
		echo "Subdirectory with name '$directory/$extension' already exists."
	fi

	# Move file and provide confirmation.
	if mv "$file" "$directory/$extension/"; then
		echo "Moved '$filename' to '$directory/$extension/'"
	else
		echo "Error: Failed to move '$filename' to '$directory/$extension/'"
	fi
done
