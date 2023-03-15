CUR_HEAD=`git rev-parse --symbolic-full-name --abbrev-ref HEAD`
git pull --all

if [[ "$CUR_HEAD" == "master" || "$CUR_HEAD" == "main" ]]; then
	NEW_HEAD=`cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g'`
	git checkout -b ${NEW_HEAD}
	./commits.sh 1 "${NEW_HEAD}.md"
	git checkout ${CUR_HEAD}
	./commits.sh 1 "${NEW_HEAD}.md"
	git checkout ${NEW_HEAD}
	git push --set-upstream origin ${NEW_HEAD}
fi

git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null && git push origin ${CUR_HEAD} || git push --set-upstream origin ${CUR_HEAD}

subject=`lipsum -w 2`
body=`lipsum -n 1`
URL=`gh pr create --title "$subject" --body "$body" 2>&1  | tail -n 1`
open -a "/Applications/Google Chrome.app" "$URL"

if [[ "$CUR_HEAD" == "master" || "$CUR_HEAD" == "main" ]]
then
	git switch "$CUR_HEAD"
fi