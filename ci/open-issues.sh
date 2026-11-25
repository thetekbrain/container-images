#!/usr/bin/env bash
# Legt für jeden Befund aus ci/check-updates.sh ein GitHub-Issue an, sofern noch keins
# mit genau diesem Titel offen ist oder als „nicht geplant“ (not planned) geschlossen wurde.
# So bleibt ein bewusst abgelehnter Hinweis (z. B. eine neue LTS-Linie) geschlossen.
#
# Aufruf: ci/check-updates.sh | ci/open-issues.sh
# Braucht gh mit GH_TOKEN (Rechte: issues: write).
set -euo pipefail

label=wartung
gh label create "$label" --color FBCA04 --description "Automatischer Wartungs-Hinweis" --force >/dev/null

open_titles=$(gh issue list --state open --label "$label" --limit 200 --json title --jq '.[].title')
declined_titles=$(gh issue list --state closed --label "$label" --limit 500 --json title,stateReason \
	--jq '.[] | select(.stateReason == "NOT_PLANNED") | .title')
while IFS= read -r line; do
	[ -n "$line" ] || continue
	title=$(jq -r .title <<<"$line")
	if grep -Fxq -- "$title" <<<"$open_titles"; then
		echo "offen: $title"
		continue
	fi
	if grep -Fxq -- "$title" <<<"$declined_titles"; then
		echo "abgelehnt: $title"
		continue
	fi
	jq -r .body <<<"$line" | gh issue create --title "$title" --label "$label" --body-file -
	echo "neu:   $title"
done
