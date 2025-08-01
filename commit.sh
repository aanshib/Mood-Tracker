#!/bin/bash

GITHUB_REPO="https://github.com/aanshib/Mood-Tracker" # ✅ This should be your own GitHub repo URL

# 🔄 Remove previous git history and start clean
rm -rf .git
git init
git remote add origin $GITHUB_REPO
git branch -M main

# 📂 Ordered folders for backdated commits
folders=(
  "app"
  "components"
  "hooks"
  "lib"
  "finaljournalb"
  "selfcarefinalb"
  "streamlit_app"
  "public"
)

# 📅 Backdated commit times
dates=(
  "2025-07-25T12:00:00"
  "2025-07-26T12:00:00"
  "2025-07-27T12:00:00"
  "2025-07-28T12:00:00"
  "2025-07-29T12:00:00"
  "2025-07-30T12:00:00"
  "2025-07-31T12:00:00"
  "2025-08-01T12:00:00"
)

# 🔁 Loop through folders and commit with fake dates
for i in "${!folders[@]}"; do
  folder="${folders[$i]}"
  commit_date="${dates[$i]}"

  if [ -d "$folder" ]; then
    git add "$folder"
    GIT_COMMITTER_DATE="$commit_date" git commit -m "Day $((i+1)): Add $folder" --date="$commit_date"
  else
    echo "⚠️ Warning: Folder '$folder' not found, skipping."
  fi
done

# 📦 Final commit for remaining config files
git add .gitignore styles/ tailwind.config.ts tsconfig.json package.json pnpm-lock.yaml postcss.config.js next.config.js next-env.d.ts test-db.ts start.bat requirements.txt
git commit -m "Add remaining config and setup files"

# 🚀 Push to your GitHub repo
git push -u origin main
