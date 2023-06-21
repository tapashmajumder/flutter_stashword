#!/bin/zsh

# Deduce the project directory dynamically
project="$(dirname $0)/.."

# Define the source and destination file paths
source_file="$project/lib/main_actual.dart"
destination_file="$project/lib/main.dart"

# Copy the source file to the destination
cp "$source_file" "$destination_file"
