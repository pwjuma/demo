org=peterjuma
repo=octo
response=$(curl -sH "Authorization: token ${TOKEN}" https://api.github.com/repos/${org}/${repo}/releases/latest)
assets=$(echo "$response" | jq -r '.assets[] | "\(.url),\(.name)"')

echo $assets

for asset in $assets
do
	asset_name=$(echo $asset | cut -d, -f2)
	asset_url=$(echo $asset | cut -d, -f1)
	curl -vv -L -H "Authorization: token ${TOKEN}" -H 'Accept: application/octet-stream' $asset_url -o $asset_name
done
