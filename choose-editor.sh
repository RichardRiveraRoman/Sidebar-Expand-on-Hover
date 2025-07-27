#!/usr/bin/env bash

# --- Helper Functions ---

# Checks if an element exists in an array.
# Usage: contains_element "element_to_find" "${array[@]}"
contains_element() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

# Finds and changes to the Zen profile directory.
# It checks for standard, user flatpak, and system flatpak installations.
find_and_cd_to_profile_dir() {
  # Check for standard package manager installation path
  if [ -d "$HOME/.zen" ]; then
    cd "$HOME/.zen" ||
      return 0
  # Check for user Flatpak installation path
  elif [ -d "$HOME/.var/app/app.zen_browser.zen/.zen" ]; then
    cd "$HOME/.var/app/app.zen_browser.zen/.zen" ||
      return 0
  # Check for system Flatpak installation path
  elif [ -d "/var/lib/flatpak/app/app.zen_browser.zen/.zen" ]; then
    cd "/var/lib/flatpak/app/app.zen_browser.zen/.zen" ||
      return 0
  fi
  # If no directory is found, return an error
  return 1
}

# --- Main Script ---

if ! find_and_cd_to_profile_dir; then
  echo "Error: Zen Browser profile directory not found." >&2
  echo "Checked for ~/.zen, ~/.var/app/..., and /var/lib/flatpak/..." >&2
  exit 1
fi

# Find the default profile directory (e.g., xxxxxxxx.default-release)
DEFAULT_PROFILE=$(find . -maxdepth 1 -type d -regex ".*(release)" | sed "s:^./::")

if [ -z "$DEFAULT_PROFILE" ]; then
  echo "Error: Could not determine the default profile directory within $(pwd)." >&2
  exit 1
fi

echo "Found Zen profile in: $(pwd)/$DEFAULT_PROFILE"
echo

# --- Build Unique Editor List ---
# Ensures $EDITOR is prioritized avoids creating duplicates.
editor_options=()
common_editors=("nano" "nvim" "vim" "vi" "micro" "code" "edit" "xdg-open")

# Add the user's preferred editor first, if it's set.
if [ -n "$EDITOR" ]; then
  editor_options+=("$EDITOR")
fi

# Add other common editors if they aren't already in the list.
for editor in "${common_editors[@]}"; do
  if ! contains_element "$editor" "${editor_options[@]}"; then
    editor_options+=("$editor")
  fi
done

# Add the Cancel option last.
editor_options+=("Cancel")

# --- Present Selection Menu ---
PS3="Select an editor to open zen-themes.json: "

select editor in "${editor_options[@]}"; do
  case $editor in
  "Cancel")
    echo "Edit cancelled."
    break
    ;;
  *)
    FILE_PATH="$(pwd)/$DEFAULT_PROFILE/zen-themes.json"

    # Check if the chosen editor command exists, otherwise fall back to xdg-open
    if ! command -v "$editor" &>/dev/null; then
      echo "Editor '$editor' not found. Falling back to xdg-open."
      editor="xdg-open"
    fi

    echo "Opening with $editor..."
    if [ "$editor" = "xdg-open" ]; then
      xdg-open "$FILE_PATH" || echo "Failed to open with xdg-open."
    else
      "$editor" "$FILE_PATH"
    fi
    break
    ;;
  esac
done
