#!/usr/bin/env sh

# Get the absolute path of the local Git repository
repo_path=$(git rev-parse --show-toplevel)

# Define the pattern to search for
PATTERN='^Copyright.+NAME HERE.+$'

# Print the directory and pattern being searched
echo "Searching for files containing the pattern: [$PATTERN] in directory [$repo_path]"

# Use grep to find files containing the pattern and store the result in a variable
matching_files=$(grep -rEl "$PATTERN" "$repo_path")

# Check if matching_files is empty and print appropriate message
if [ -z "$matching_files" ]; then
  echo "No matching files found."
else
    # Iterate over each matching file and replace the line
    for file in $matching_files; do
      echo "Processing file: $file"
      sed -i.bak -E "/$PATTERN/d" "$file"
      rm -f "$file.bak"
    done
    echo "Deletion complete."
fi
