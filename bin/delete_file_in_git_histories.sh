# git filter-branch --force --index-filter \
#   'git rm --cached --ignore-unmatch {files}' \
#   --prune-empty --tag-name-filter cat -- --all
# 
# git for-each-ref --format 'delete %(refname)' refs/original | git update-ref --stdin
# 
# git push origin --force --all
