set -e
  git fetch --all --prune
  # Remove local fully merged branches
git branch --merged master | sed 's/^[ *]\+//' | grep -v '^master$' | xargs -r -d'\n' git
  branch -D
  # Remove origin/ fully merged branches, except for master
git branch --remotes --merged master | sed 's/^[ *]\+//' | grep '^origin/' | grep -v
           '/master$|' | sed 's/^origin\///' | xargs -r -d'\n' git push --delete origin
git fetch --all --prune

# Remove remote fully merged branches into release.
git branch --merged master| egrep -v "(^\*|master|release)" | sed 's/origin\///' | xargs -n 1 git push origin
