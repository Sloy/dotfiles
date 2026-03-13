# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Also a lot of defaults were taken from https://mths.be/macos
#
# Run ./set-defaults.sh and you'll be good to go.

confirm() {
  read -r -p "$1 [Y/n] " response
  [[ "$response" =~ ^([nN])$ ]] && return 1 || return 0
}

# Ask for the administrator password upfront
sudo -v

# Set computer name (as done via System Preferences → Sharing)
CURRENT_COMPUTER_NAME=$(scutil --get ComputerName)
read -p "Computer name (current: '$CURRENT_COMPUTER_NAME', empty to ignore): " COMPUTER_NAME
if [[ ! (-z "$COMPUTER_NAME") ]]; then
	sudo scutil --set ComputerName "$COMPUTER_NAME"
	sudo scutil --set HostName "$COMPUTER_NAME"
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"
fi

confirm "Use AirDrop over every interface" && \
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

confirm "Show the ~/Library folder" && \
chflags nohidden ~/Library

if confirm "Show external drives and removable media on the Desktop"; then
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
fi

if confirm "Run screensaver on bottom-left hot corner"; then
  defaults write com.apple.dock wvous-bl-corner -int 5
  defaults write com.apple.dock wvous-bl-modifier -int 0
fi

confirm "Disable rearrange of spaces based on most recent use" && \
defaults write com.apple.dock mru-spaces -int 0

if confirm "Expand save panel by default"; then
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
fi

confirm "Save to disk (not to iCloud) by default" && \
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

confirm "Automatically quit printer app once the print jobs complete" && \
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

confirm "Set Help Viewer windows to non-floating mode" && \
defaults write com.apple.helpviewer DevMode -bool true

confirm "Reveal IP address, hostname, OS version when clicking the clock in the login window" && \
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

if confirm "Disable smart quotes and smart dashes"; then
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
fi

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

if confirm "Trackpad: enable tap to click"; then
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
fi

confirm "Swipe between full-screen apps with 4 fingers" && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0

confirm "Mission Control with 4 fingers" && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0

confirm "Enable full keyboard access for all controls (e.g. Tab in modal dialogs)" && \
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

confirm "Disable press-and-hold for keys in favor of key repeat" && \
defaults write -g ApplePressAndHoldEnabled -bool false

if confirm "Set a fast keyboard repeat rate"; then
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  defaults write NSGlobalDomain KeyRepeat -float 2
  defaults write NSGlobalDomain com.apple.keyboard.fnState -int 1
fi

confirm "Disable auto-correct" && \
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Screen                                                                      #
###############################################################################

confirm "Change screenshots location to Downloads folder" && \
defaults write com.apple.screencapture location -string "~/Downloads"

###############################################################################
# Finder                                                                      #
###############################################################################

if confirm "Set Home as the default location for new Finder windows"; then
  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
fi

if confirm "Show icons for hard drives, servers, and removable media on the desktop"; then
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
fi

confirm "Finder: show all filename extensions" && \
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

confirm "Finder: show status bar" && \
defaults write com.apple.finder ShowStatusBar -bool true

confirm "Finder: show path bar" && \
defaults write com.apple.finder ShowPathbar -bool true

confirm "Display full POSIX path as Finder window title" && \
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

confirm "When performing a search, search the current folder by default" && \
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

confirm "Disable the warning when changing a file extension" && \
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

if confirm "Enable spring loading for directories (with no delay)"; then
  defaults write NSGlobalDomain com.apple.springing.enabled -bool true
  defaults write NSGlobalDomain com.apple.springing.delay -float 0
fi

confirm "Avoid creating .DS_Store files on network volumes" && \
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

confirm "Use list view in all Finder windows by default" && \
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

confirm "Expand General and Open With panes in File Info" && \
defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true

if confirm "Enable snap-to-grid for icons on the desktop and in other icon views"; then
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
fi

###############################################################################
# Dock                                                                        #
###############################################################################

confirm "Enable highlight hover effect for the grid view of a stack (Dock)" && \
defaults write com.apple.dock mouse-over-hilite-stack -bool true

confirm "Set the icon size of Dock items to 32 pixels" && \
defaults write com.apple.dock tilesize -int 32

confirm "Wipe all default app icons from the Dock" && \
defaults write com.apple.dock persistent-apps -array

confirm "Don't show recently used applications in the Dock" && \
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
## DOESN'T WORK IN MOJAVE

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
#Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
#sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
## DOESN'T WORK IN MOJAVE

if confirm "Configure Spotlight indexing order (apps, system prefs, folders, calculators only)"; then
  defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "PDF";}' \
    '{"enabled" = 0;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
  killall mds > /dev/null 2>&1
  sudo mdutil -i on / > /dev/null
  sudo mdutil -E / > /dev/null
fi

confirm "Enable Secure Keyboard Entry in Terminal.app" && \
defaults write com.apple.terminal SecureKeyboardEntry -bool true

###############################################################################
# Time Machine                                                                #
###############################################################################

confirm "Prevent Time Machine from prompting to use new hard drives as backup volume" && \
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

if confirm "Configure Activity Monitor (show all processes, sort by CPU)"; then
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
  defaults write com.apple.ActivityMonitor IconType -int 5
  defaults write com.apple.ActivityMonitor ShowCategory -int 0
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0
fi

###############################################################################
# Photos                                                                      #
###############################################################################

confirm "Prevent Photos from opening automatically when devices are plugged in" && \
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

for app in "Address Book" "Calendar" "Contacts" "Dock" "Finder" "Mail" "Safari" "SystemUIServer" "iCal"; do
  killall "${app}" &> /dev/null
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
