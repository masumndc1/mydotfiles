awk '
BEGIN {
    # 1. Install Terminus font via Homebrew
    print "==> Installing Terminus font via Homebrew...";
    system("brew install --cask font-terminus");

    # 2. Locate Firefox profile directory on macOS
    home = ENVIRON["HOME"];
    profile_dir = home "/Library/Application Support/Firefox/Profiles";

    cmd = "find \"" profile_dir "\" -maxdepth 1 -type d -name \"*default*\" | head -n 1";
    cmd | getline profile_path;
    close(cmd);

    if (profile_path == "") {
        print "Error: Could not locate a default Firefox profile folder." > "/dev/stderr";
        exit 1;
    }
    print "Found profile: " profile_path;

    # 3. Create chrome directory and userChrome.css for UI styling
    chrome_dir = profile_path "/chrome";
    system("mkdir -p \"" chrome_dir "\"");

    css_file = chrome_dir "/userChrome.css";
    print "/* Apply Terminus TTF to Firefox UI */" > css_file;
    print "* {" > css_file;
    print "    font-family: \"Terminus (TTF)\", \"Terminus\", monospace !important;" > css_file;
    print "    font-size: 13px !important;" > css_file;
    print "}" > css_file;
    close(css_file);

    # 4. Configure prefs.js for UI custom stylesheets, global font overrides, and disabling document fonts
    prefs_file = profile_path "/prefs.js";

    keys[1] = "toolkit.legacyUserProfileCustomizations.stylesheets";
    vals[1] = "user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);";

    keys[2] = "browser.display.use_document_fonts";
    vals[2] = "user_pref(\"browser.display.use_document_fonts\", 0);";

    keys[3] = "font.name.monospace.x-western";
    vals[3] = "user_pref(\"font.name.monospace.x-western\", \"Terminus (TTF)\");";

    keys[4] = "font.name.sans-serif.x-western";
    vals[4] = "user_pref(\"font.name.sans-serif.x-western\", \"Terminus (TTF)\");";

    keys[5] = "font.name.serif.x-western";
    vals[5] = "user_pref(\"font.name.serif.x-western\", \"Terminus (TTF)\");";

    # Read existing prefs.js into memory while filtering out old versions of these keys to prevent duplicates
    n = 0;
    while ((getline line < prefs_file) > 0) {
        skip = 0;
        for (k = 1; k <= 5; k++) {
            if (index(line, keys[k]) > 0) {
                skip = 1;
                break;
            }
        }
        if (!skip) {
            lines[++n] = line;
        }
    }
    close(prefs_file);

    # Append the new preferences
    for (k = 1; k <= 5; k++) {
        lines[++n] = vals[k];
    }

    # Write everything back to prefs.js
    for (i = 1; i <= n; i++) {
        print lines[i] > prefs_file;
    }
    close(prefs_file);

    print "==> Done! Completely restart Firefox (Cmd + Q) to see Terminus everywhere.";
}'
