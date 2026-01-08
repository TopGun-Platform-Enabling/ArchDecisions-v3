#!/bin/bash

TARGET_DIR="./sciensano_data"
OUTPUT="file_mtime.csv"

# Ensure target directory exists
mkdir -p "$TARGET_DIR"

# Move into it
cd "$TARGET_DIR" || { echo "❌ Could not enter $TARGET_DIR"; exit 1; }

# Write header for mtime CSV
echo "filename,mtime" > "$OUTPUT"

# Sciensano datasets
declare -A datasets=(
  ["COVID19BE_CASES"]="https://epistat.sciensano.be/Data/COVID19BE_CASES.csv"
  ["COVID19BE_DEATHS"]="https://epistat.sciensano.be/Data/COVID19BE_DEATHS.csv"
  ["COVID19BE_HOSP"]="https://epistat.sciensano.be/Data/COVID19BE_HOSP.csv"
  ["COVID19BE_TESTS"]="https://epistat.sciensano.be/Data/COVID19BE_TESTS.csv"
  ["COVID19BE_VACC"]="https://epistat.sciensano.be/Data/COVID19BE_VACC.csv"
)

# Loop through datasets
for name in "${!datasets[@]}"; do
  url="${datasets[$name]}"
  file="$name.csv"

  # If file exists, check modification time
  if [ -f "$file" ]; then
    # Get modification time in seconds
    mtime=$(stat -c %Y "$file")
    now=$(date +%s)
    age=$(( (now - mtime) / 86400 ))  # age in days

    if [ "$age" -le 2 ]; then
      echo "⏩ Skipping $file (modified $age days ago)"
      # Record mtime
      MTIME=$(date -r "$file" +"%Y-%m-%d %H:%M:%S")
      echo "$file,$MTIME" >> "$OUTPUT"
      continue
    fi
  fi

  # Otherwise fetch fresh copy
  echo "⬇️ Fetching $name from $url..."
  curl -s -o "$file" "$url"

  # Record new mtime
  MTIME=$(date -r "$file" +"%Y-%m-%d %H:%M:%S")
  echo "$file,$MTIME" >> "$OUTPUT"
done

echo "✅ Updated datasets in $TARGET_DIR"
