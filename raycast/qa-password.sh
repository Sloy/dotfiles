#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title QA Password
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔑
# @raycast.packageName com.rafavs.talkback

# Documentation:
# @raycast.description Pastes the QA password on the connected Android device
# @raycast.author Rafa Vázquez
# @raycast.authorURL rafavs.com

ADB=/Users/rafa.vazquez/Library/Android/sdk/platform-tools/adb

[[ -f "$HOME/.localrc" ]] && source "$HOME/.localrc"

$ADB shell input text "$QA_PASSWORD"
echo "QA password pasted"
