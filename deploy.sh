#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
# hugo -t <your theme>
hugo -t PaperMod

# Go to public folder, submodule 'publish' commit
cd public

# Add changes to git.
git add .

# Check for changes and commit if there are any
if ! git diff-index --quiet HEAD; then
  msg="rebuilding site `date`"
  if [ $# -eq 1 ]; then
    msg="$1"
  fi
  git commit -m "$msg"
  
  # Push source and build repos.
  git push origin publish
else
  echo "No changes to commit in 'public' directory."
fi

# Come back up to the project root
cd ..

# Add changes to git.
git add .

# Check for changes and commit if there are any
if ! git diff-index --quiet HEAD; then
  msg="rebuilding site `date`"
  if [ $# -eq 1 ]; then
    msg="$1"
  fi
  git commit -m "$msg"
  
  # Push source and build repos.
  git push origin post
else
  echo "No changes to commit in the project root directory."
fi
