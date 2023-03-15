BRANCH="$(cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g')"

git checkout -b $BRANCH

./commits.sh 1

git push --set-upstream origin $BRANCH

subject=`lipsum -w 2`
body=`lipsum -n 1`
reponame=$(gh repo view --json nameWithOwner -q ".nameWithOwner")
URL=$(gh issue create --title "$subject" --body "$body" --repo ${reponame} | grep -oE "https://github.com/[a-zA-Z0-9./?=_-]*/issues/[0-9]*")
ISSUE=$(echo "$URL" | cut -d/ -f 7)

# gh api \
# --method POST \
# -H "Accept: application/vnd.github+json" \
# /repos/peterjuma/miniature-octo-tribble/pulls \
# -f title="$subject" \
# -f body="Closes #$ISSUE" \
# -f head="$BRANCH" \
# -f base='master'

curl \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $TOKEN" \
  https://api.github.com/repos/${reponame}/pulls \
  -d '{"title":"'"$SUBJECT"'","body":"Closes #'"$ISSUE"'","head":"'"$BRANCH"'","base":"master"}'

open -a "/Applications/Google Chrome.app" "$URL"