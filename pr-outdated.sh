CUR_HEAD=`git rev-parse --symbolic-full-name --abbrev-ref HEAD`

DEFAULT_BRANCH=`git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`

git pull --all

if [[ "$CUR_HEAD" == "master" || "$CUR_HEAD" == "main" ]]; then
	NEW_HEAD=`cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g'`
	git checkout -b ${NEW_HEAD}
	./commits.sh 1 
	git push --set-upstream origin ${NEW_HEAD}
fi

git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null && git push origin ${CUR_HEAD} || git push --set-upstream origin ${CUR_HEAD}

subject=`lipsum -w 2`
body=`lipsum -n 1`
URL=`gh pr create --title "$subject" --body "$body" 2>&1  | tail -n 1`


NWO=`gh repo view --json nameWithOwner -q ".nameWithOwner"`
owner=$(echo $NWO | cut -d"/" -f1)
name=$(echo $NWO | cut -d"/" -f2)

# gh api repos/$owner/$name/branches/$DEFAULT_BRANCH/protection &> /dev/null 

# if [ $? -ne 0 ]; then
# 	repositoryId="$(gh api graphql -f query='{repository(owner:"'$owner'",name:"'$name'"){id}}' -q .data.repository.id)"
# 	gh api graphql -f query='
# 	mutation($repositoryId:ID!,$branch:String!) {
# 	 createBranchProtectionRule(input: {
# 	 repositoryId: $repositoryId
# 	 pattern: $branch
# 	 requiresStatusChecks: true
# 	 requiresStrictStatusChecks: true
# 	}) { clientMutationId }
# 	}' -f repositoryId="$repositoryId" -f branch="$DEFAULT_BRANCH" 
# else
# 	# gh api repos/$owner/$name/branches/$DEFAULT_BRANCH/protection -q ".required_status_checks.strict" &> /dev/null 
# 	repositoryId="$(gh api graphql -f query='{repository(owner:"'$owner'",name:"'$name'"){id}}' -q .data.repository.id)"
# 	gh api graphql -f query='
# 	mutation($repositoryId:ID!,$branch:String!) {
# 	 UpdateBranchProtectionRule(input: {
# 	 repositoryId: $repositoryId
# 	 pattern: $branch
# 	 requiresStatusChecks: true
# 	 requiresStrictStatusChecks: true
# 	}) { clientMutationId }
# 	}' -f repositoryId="$repositoryId" -f branch="$DEFAULT_BRANCH" 
# fi


git switch "$DEFAULT_BRANCH"
./commits.sh 1
git push origin ${DEFAULT_BRANCH}


if [[ "$*" == *"merge"* ]]
then
	# COMMITMSG=$(python3 commitmsg.py)
	COMMITMSG=$(curl -s http://whatthecommit.com/ | grep -A2 '<div id="content">' | awk -F: 'NR==2 {sub(/<p>/,"");print $1}')
	gh pr merge "$URL" --merge --admin --body ${COMMITMSG}
fi

open -a "/Applications/Google Chrome.app" "$URL"