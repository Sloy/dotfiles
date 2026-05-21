#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Talkback Toggle
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ♿
# @raycast.packageName com.rafavs.talkback

# Documentation:
# @raycast.description Toggles the talkback feature on/off in the connected Android device
# @raycast.author Rafa Vázquez
# @raycast.authorURL rafavs.com

ADB=/Users/rafa.vazquez/Library/Android/sdk/platform-tools/adb

output=$($ADB shell settings get secure enabled_accessibility_services)
if [[ "$output" == "null" ]]; then
  $ADB shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService
  echo "TalkBack turned on"
else
  $ADB shell settings put secure enabled_accessibility_services null
  echo "TalkBack turned off"
fi
