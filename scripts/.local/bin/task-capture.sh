#!/usr/bin/env bash

# Capture a Taskwarrior task via a zenity form with project selection.
# If the clipboard contains a URI, annotate the created task with it.

set -o errexit
set -o pipefail

URI=$(wl-paste)

EXISTING_PROJECTS=$(task rc.verbose=nothing _projects | grep -v '^$')

if [ -z "$EXISTING_PROJECTS" ]; then
  DROPDOWN_LIST=" "
else
  DROPDOWN_LIST=" |$(echo "$EXISTING_PROJECTS" | tr '\n' '|' | sed 's/|$//')"
fi

if ! FORM_DATA=$(zenity --forms \
                   --title="⚡ Taskwarrior Capture" \
                   --text="Fill out the task details below:" \
                   --add-entry="description" \
                   --add-combo="project" --combo-values="$DROPDOWN_LIST" \
                   --width=450) || [ -z "$FORM_DATA" ]; then
  exit 0
fi

USER_INPUT=$(echo "$FORM_DATA" | cut -d'|' -f1)
CHOSEN_PROJECT=$(echo "$FORM_DATA" | cut -d'|' -f2)

if [ -z "$USER_INPUT" ]; then
  exit 0
fi

read -r -a TASK_ARGS <<< "$USER_INPUT"

if [ -n "$CHOSEN_PROJECT" ] && [ "$CHOSEN_PROJECT" != "None" ]; then
  TASK_ARGS+=("project:$CHOSEN_PROJECT")
fi

OUTPUT=$(task add "${TASK_ARGS[@]}")
echo "$OUTPUT"

# Extract the newly created Task ID from the output string
TASK_ID=$(echo "$OUTPUT" | grep -oE '[0-9]+' | head -1)
echo "$TASK_ID"

if [ -n "$TASK_ID" ] && [[ "$URI" =~ ^[a-zA-Z][a-zA-Z0-9+.-]*:// ]]; then
  task "$TASK_ID" annotate "$URI" || true
fi
