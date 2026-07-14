#!/usr/bin/env bash

# Capture a Taskwarrior task via yad form with project and tag selection.
# If the clipboard contains a URI, annotate the created task with it.

set -o errexit
set -o pipefail

URI=$(wl-paste)

# Gather existing projects and strip trailing newlines directly into pipe-delimited format
EXISTING_PROJECTS=$(task rc.verbose=nothing _projects | grep -v '^$' | tr '\n' '|' | sed 's/|$//')
PROJECT_DROPDOWN="${EXISTING_PROJECTS:- }"

# Gather existing tags and strip trailing newlines directly into pipe-delimited format
EXISTING_TAGS=$(task rc.verbose=nothing _tags | grep -v '^$' | tr '\n' '|' | sed 's/|$//')
TAG_DROPDOWN="${EXISTING_TAGS:- }"

if ! FORM_DATA=$(yad --form \
                    --title="⚡ Taskwarrior Capture" \
                    --text="Fill out the task details below:" \
                    --field="Description" "" \
                    --field="Project:CE" "$PROJECT_DROPDOWN" \
                    --field="Tags:CE" "$TAG_DROPDOWN" \
                    --width=450 \
                    --item-separator="|" \
                    --separator="|") || [ -z "$FORM_DATA" ]; then
  exit 0
fi

# Parsing the data out securely using the pipe separator
USER_INPUT=$(echo "$FORM_DATA" | cut -d'|' -f1)
CHOSEN_PROJECT=$(echo "$FORM_DATA" | cut -d'|' -f2)
CHOSEN_TAGS=$(echo "$FORM_DATA" | cut -d'|' -f3)

# If they clicked OK but left the description empty, bail out
if [ -z "$USER_INPUT" ]; then
  exit 0
fi

# Build array for Taskwarrior execution
TASK_ARGS=("$USER_INPUT")

if [ -n "$CHOSEN_PROJECT" ] && [ "$CHOSEN_PROJECT" != " " ]; then
  TASK_ARGS+=("project:$CHOSEN_PROJECT")
fi

if [ -n "$CHOSEN_TAGS" ] && [ "$CHOSEN_TAGS" != " " ]; then
  # Split tags cleanly if multiple tags were selected or written out
  IFS=' ' read -r -a tag_array <<< "$CHOSEN_TAGS"
  for tag in "${tag_array[@]}"; do
    clean_tag=$(echo "$tag" | sed 's/^+//')
    TASK_ARGS+=("+$clean_tag")
  done
fi

OUTPUT=$(task add "${TASK_ARGS[@]}")
echo "$OUTPUT"

# Extract the newly created Task ID from the output string
TASK_ID=$(echo "$OUTPUT" | grep -oE 'Created task [0-9]+' | grep -oE '[0-9]+' || true)

# Annotate if a valid ID was found and the clipboard contains a valid URI
if [ -n "$TASK_ID" ] && [[ "$URI" =~ ^[a-zA-Z][a-zA-Z0-9+.-]*:// ]]; then
  task "$TASK_ID" annotate "$URI" || true
fi
