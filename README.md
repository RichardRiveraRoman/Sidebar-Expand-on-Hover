# How to install

> **Disclaimer:** This project is not actively maintained. This repository was
> created for personal use and is shared "as is" in case others find it
> useful. There is no guarantee of future updates or support.

<!--toc:start-->

- [How to install](#how-to-install)
  - [Script (Recommended)](#script-recommended)
  - [Package Manager](#package-manager)
  - [Flatpak](#flatpak)
  - [Acknowledgements](#acknowledgements)
  <!--toc:end-->

## Script (Recommended)

This script automates finding your `zen-themes.json` file and opening it for
editing.

1. First, copy the theme's JSON data from the
   [Package Manager](#package-manager) section below.
2. Run the script. It will prompt you to select from a list of numerous editors
   (e.g., `code`, `nano`, `vim`, etc.).
3. Once the file opens, follow the editing instructions in
   [Step 2: Edit zen-themes.json](#step-2-edit-zen-themesjson) to paste the
   theme data.

```bash
bash -c "$(curl -sS https://raw.githubusercontent.com/RichardRiveraRoman/Sidebar-Expand-on-Hover/main/choose-editor.sh)"
```

---

## Package Manager

This method is for standard installations of Zen (e.g., via `pacman`, `apt`,
`rpm`, etc.).

### Step 1: Copy the Theme JSON

Copy the entire JSON object from the raw file link below. You will paste this
into your `zen-themes.json` file.

- **[zen-themes.json](https://raw.githubusercontent.com/RichardRiveraRoman/zen-themes.json)**

> **Note:** The content from the raw link will be a single, unformatted line of
> text. A formatted version is provided below for reference.

**Formatted Version:**

```json
{
  "f3c680b9-07a8-4f02-b43f-9def3b81bfa9": {
    "id": "f3c680b9-07a8-4f02-b43f-9def3b81bfa9",
    "name": "Sidebar Expand on Hover",
    "description": "Adds the expand on hover feature to Zen with a few extra features.",
    "homepage": "https://github.com/RichardRiveraRoman/Sidebar-Expand-On-Hover",
    "style": "https://raw.githubusercontent.com/RichardRiveraRoman/Sidebar-Expand-on-Hover/main/f3c680b9-07a8-4f02-b43f-9def3b81bfa9/chrome.css",
    "readme": "https://raw.githubusercontent.com/RichardRiveraRoman/Sidebar-Expand-on-Hover/main/f3c680b9-07a8-4f02-b43f-9def3b81bfa9/readme.md",
    "image": "https://raw.githubusercontent.com/RichardRiveraRoman/Sidebar-Expand-on-Hover/main/f3c680b9-07a8-4f02-b43f-9def3b81bfa9/image.png",
    "author": "Richard",
    "version": "2.0.1",
    "tags": [],
    "createdAt": "2024-12-10",
    "updatedAt": "2025-07-27",
    "preferences": "https://raw.githubusercontent.com/RichardRiveraRoman/Sidebar-Expand-on-Hover/main/f3c680b9-07a8-4f02-b43f-9def3b81bfa9/preferences.json",
    "enabled": false
  }
}
```

### Step 2: Edit zen-themes.json

1. Navigate to `about:profiles` in Zen's address bar.

   ```bash
   zen-browser --new-tab "about:profiles"
   ```

2. Find your current profile (it's the one where **Default Profile** is set to
   **Yes**).
3. Click the **Open Directory** button for that profile.
4. In the folder that opens, find the `zen-themes.json` file and open it with a
   text editor. If it doesn't exist, create it.
5. You need to merge the JSON you copied in Step 1.
   - **If the file is new or empty**, paste the content directly.

   - **If the file already has other themes**, add a comma after the last
     theme's closing brace `}` and then paste the new theme's _content_ (the
     `"f3c680b9...": { ... }` part) after the comma.

     _Before:_

     ```json
     {
       "some-other-theme-id": {
         "name": "Some Other Theme"
       }
     }
     ```

     _After:_

     ```json
     {
       "some-other-theme-id": {
         "name": "Some Other Theme"
       },
       "f3c680b9-07a8-4f02-b43f-9def3b81bfa9": {
         "id": "f3c680b9-07a8-4f02-b43f-9def3b81bfa9",
         "name": "Sidebar Expand on Hover"
         // ... rest of the theme data
       }
     }
     ```

### Step 3: Restart Zen

Save the `zen-themes.json` file and restart the browser. The mod will now be
installed.

---

## Flatpak

If you installed Zen via Flatpak, your profile directory is in a different
location.

1. First, copy the theme's JSON data from
   [Step 1 in the Package Manager section](#step-1-copy-the-theme-json).
2. Next, locate and open your `zen-themes.json` file. You can use the commands
   below to find your profile and open the file automatically.

   ```bash
   # Navigate to the correct Flatpak config directory
   cd ~/.var/app/app.zen_browser.zen/.zen/ || cd /var/lib/flatpak/app/app.zen_browser.zen/.zen/

   # Find the default profile name (e.g., xxxxxxxx.default-release)
   DEFAULT_PROFILE=$(find . -maxdepth 1 -type d -regex ".*(release)" | sed "s:^./::")

   # Open the themes file in your default editor
   xdg-open "$DEFAULT_PROFILE/zen-themes.json"
   ```

3. If you prefer to navigate manually, your profile folder is located in either:
   - **User Install:** `~/.var/app/app.zen_browser.zen/.zen/`
   - **System Install:** `/var/lib/flatpak/app/app.zen_browser.zen/.zen/`

   Inside that directory, find your profile (e.g., `xxxxxxxx.default-release`)
   and open `zen-themes.json`.

4. With the file open, follow the instructions in
   [Step 2: Edit zen-themes.json](#step-2-edit-zen-themesjson) to add the new
   theme data correctly.
5. Save the file and restart Zen to apply the changes.

---

## Acknowledgements

This theme is a modification based on the `zen-mods` project. A big thanks to
the maintainer, [Qoup](https://github.com/qoup/zen-mods/tree/main), for their
foundational work.
