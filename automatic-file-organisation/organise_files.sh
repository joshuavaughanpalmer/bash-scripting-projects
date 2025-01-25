#!/bin/bash

# A simple Bash script that will organise files into folders by their extensions.

# Use the current directory as the target
DIRECTORY="."

# List all files in the current directory (excluding subdirectories)
find "$DIRECTORY" -maxdepth 1 -type f
