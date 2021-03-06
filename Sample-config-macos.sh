#!/usr/bin/env bash
# Taken from many examples on GitHub.
# Thanks

killall System\ Preferences # Kill System Preferences. (i) Prevents System Preferences from overriding changes.

sudo -v # Ask for an administrator password.

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null & # Update sudo timestamp until the script is over.

sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
sudo spctl --master-disable
# (i) Set Allow apps downloaded from to anywhere. [i] Disables GateKeeper.
defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool FALSE # No, really, fuck you, Apple. (i) Disable GateKeeper autorearm.

defaults write com.apple.LaunchServices LSQuarantine -bool FALSE # Don't warn when opening an application.

#sudo pmset -a hibernatemode 0 # Disable hibernation mode. /!\ Apple laptop with SSD trick.

sudo pmset -a standbydelay 86400 # Set standby delay to 24 hours.

#sudo pmset -a sleep 0 # Disable sleep mode.
#sudo systemsetup -setcomputersleep off > /dev/null # Disable computer sleep mode.
#sudo rm /private/var/vm/sleepimage
#sudo touch /private/var/vm/sleepimage
#sudo chflags uchg /private/var/vm/sleepimage
# Remove the sleep image file, add zero-byte file instead and make it unrewritable. /!\ Apple computer with SSD trick.

sudo pmset -a disksleep 0 # Disable automatic HDD sleep. /!\ Apple computer without HDD trick. (i) Disable Put hard disks to sleep when possible.

sudo pmset -a sms 0 # Disable the sudden motion sensor. /!\ Apple laptop without HDD trick.

sudo systemsetup -setrestartfreeze on # Restart automatically if the computer freezes.

defaults write NSGlobalDomain AppleLanguages -array "en-US", he
defaults write NSGlobalDomain AppleLocale -string "en_US"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
#defaults write NSGlobalDomain AppleMetricUnits -bool TRUE
# Set language and text formats. [i] Sets format language as NA english and currency as euro.

systemsetup -settimezone "America/Los_Angeles" > /dev/null
# Set the timezone. (i) See `sudo systemsetup -listtimezones` for other values.

sudo systemsetup -setusingnetworktime on # Enable network time use.

sudo systemsetup -setnetworktimeserver "time.apple.com" # Set network time server.

echo 'Directory layout'

#sudo ln -s /usr/libexec/PlistBuddy /usr/bin/PlistBuddy
#sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
#sudo ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/bin/jsc
# Write system-wide custom symbolic links. (i) From OS X 10.11 El Capitan onwards, macOS' SIP prevents writing to /usr/, except /usr/local/.

# sudo osascript -e 'tell application "Finder" to make alias file to (POSIX file "/System/Library/CoreServices/Applications/Directory Utility.app") at (POSIX file "/Applications")'
# sudo osascript -e 'tell application "Finder" to make alias file to (POSIX file "/System/Library/CoreServices/Applications/Network Utility.app") at (POSIX file "/Applications")'
# sudo osascript -e 'tell application "Finder" to make alias file to (POSIX file "/System/Library/CoreServices/Finder.app") at (POSIX file "/Applications")'
# sudo osascript -e 'tell application "Finder" to make alias file to (POSIX file "/System/Library/CoreServices/Applications/Archive Utility.app") at (POSIX file "/Applications")'
# Write system-wide custom aliases. (i) From OS X 10.11 El Capitan onwards, macOS' SIP prevents writing to /usr/.

echo 'Network'

# echo "Which Mac is it?, eg ''Mac' Pro', ''Mac'Book', ''Mac'Book Air',"
# echo "''Mac'Book Pro' or ''Mac'intosh'."
# echo "NB: If 'e'Mac'', 'i'Mac'' or 'Power 'Mac'', enter blank."
# read computername
sudo scutil --set ComputerName "MattPad"
sudo scutil --set HostName "MattPad"
sudo scutil --set LocalHostName "MattPad"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "MattPad"

# echo 'Login Window & Screen Saver (NSGlobalDomain, com.apple.loginwindow, com.apple.HIToolbox.loginwindow, com.apple.screensaver)'

sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser "" # Disable automatic login.

# sudo /usr/libexec/PlistBuddy -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.US" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleCurrentKeyboardLayoutInputSourceID com.apple.keylayout.US" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox dict" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Delete :com.apple.HIToolbox:AppleDefaultAsciiInputSource" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleDefaultAsciiInputSource array" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleDefaultAsciiInputSource:InputSourceKind string Keyboard\ Layout" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleDefaultAsciiInputSource:InputSourceKind Keyboard\ Layout" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleDefaultAsciiInputSource:KeyboardLayout\ ID integer ${keyboardlayoutid}" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleDefaultAsciiInputSource:KeyboardLayout\ ID ${keyboardlayoutid}" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleDefaultAsciiInputSource:KeyboardLayout\ Name string U.S." "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleDefaultAsciiInputSource:KeyboardLayout\ Name U.S." "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Delete :com.apple.HIToolbox:AppleEnabledInputSources" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleEnabledInputSources array" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleEnabledInputSources:0 dict" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleEnabledInputSources:0:InputSourceKind string Keyboard\ Layout" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleEnabledInputSources:0:InputSourceKind Keyboard\ Layout" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleEnabledInputSources:0:KeyboardLayout\ ID integer ${keyboardlayoutid}" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleEnabledInputSources:0:KeyboardLayout\ ID ${keyboardlayoutid}" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleEnabledInputSources:0:KeyboardLayout\ Name string U.S." "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleEnabledInputSources:0:KeyboardLayout\ Name U.S." "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Delete :com.apple.HIToolbox:AppleSelectedInputSources" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleSelectedInputSources array" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleSelectedInputSources:0 dict" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleSelectedInputSources:0:InputSourceKind string Keyboard\ Layout" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleSelectedInputSources:0:InputSourceKind Keyboard\ Layout" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleSelectedInputSources:0:KeyboardLayout\ ID integer ${keyboardlayoutid}" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleSelectedInputSources:0:KeyboardLayout\ ID ${keyboardlayoutid}" "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :com.apple.HIToolbox:AppleSelectedInputSources:0:KeyboardLayout\ Name string U.S." "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :com.apple.HIToolbox:AppleSelectedInputSources:0:KeyboardLayout\ Name U.S." "/var/tmp/com.apple.HIToolbox.loginwindow.plist"
# Add and set login window input keyboard layout to US. [I'd rather do this the `defaults` way.]

sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool TRUE
#sudo defaults write /var/ard/Library/Preferences/com.apple.menuextra.textinput ModeNameVisible -bool TRUE
Vsudo chmod 777 /Library/Preferences/com.apple.loginwindow.plist
# Display Input keyboard layout menu in the login window.

sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName # Display IP address, hostname, OS version etc when clicking the clock in the login window.

#echo "What is this Mac's owner's phone number, with country code?,"
#echo "eg '+336XXXXXXXX' for french mobile phone numbers."
#read phonenumber
#echo "What is this Mac's owner's email address?"
#read emailaddress
#sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "${fullname}'s Mac${computername}.\nPlease contact ${phonenumber} or ${emailaddress} if found."
# Display set lock message. (i) `fullname` and `computername` variables have been set earlier, at Network: Computer name.
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Matt's MacBook Pro.\n"
# Display set lock message. (i) `computername` variable has been set earlier, at Network: Computer name.

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 10
# Require password immediately after sleep or screen saver begins. (i) Enable Require password immediately after sleep or screen saver begins.

echo 'Keyboard & Touch Bar (NSGlobalDomain, com.apple.HIToolbox, com.apple.universalaccess)'

# sudo /usr/libexec/PlistBuddy -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.US" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleCurrentKeyboardLayoutInputSourceID com.apple.keylayout.US" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Delete :AppleDefaultAsciiInputSource" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleDefaultAsciiInputSource:InputSourceKind string Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleDefaultAsciiInputSource:InputSourceKind Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleDefaultAsciiInputSource:KeyboardLayout\ ID integer 0" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleDefaultAsciiInputSource:KeyboardLayout\ ID 0" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleDefaultAsciiInputSource:KeyboardLayout\ Name string U.S." "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleDefaultAsciiInputSource:KeyboardLayout\ Name U.S." "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Delete :AppleEnabledInputSources" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0 dict" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0:InputSourceKind string Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleEnabledInputSources:0:InputSourceKind Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0:KeyboardLayout\ ID integer 0" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleEnabledInputSources:0:KeyboardLayout\ ID 0" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0:KeyboardLayout\ Name string U.S." "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleEnabledInputSources:0:KeyboardLayout\ U.S." "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Delete :AppleSelectedInputSources" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0 dict" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0:InputSourceKind string Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleSelectedInputSources:0:InputSourceKind Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0:KeyboardLayout\ ID integer 0" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleSelectedInputSources:0:KeyboardLayout\ ID 0" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0:KeyboardLayout\ Name string U.S." "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Set :AppleSelectedInputSources:0:KeyboardLayout\ Name U.S." "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo chown root:admin "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo chmod 644 "/Library/Preferences/com.apple.HIToolbox.plist"
# Add and set system input keyboard layout to US. [I'd rather do this the `defaults` way.]
# sudo /usr/libexec/PlistBuddy -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.UnicodeHexInput" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleDefaultAsciiInputSource:InputSourceKind string Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleDefaultAsciiInputSource:KeyboardLayout\ ID integer -1" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleDefaultAsciiInputSource:KeyboardLayout\ Name string Unicode\ Hex\ Input" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0 dict" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0:InputSourceKind string Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0:KeyboardLayout\ ID integer -1" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleEnabledInputSources:0:KeyboardLayout\ Name string Unicode\ Hex\ Input" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0 dict" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0:InputSourceKind string Keyboard\ Layout" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0:KeyboardLayout\ ID integer -1" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo /usr/libexec/PlistBuddy -c "Add :AppleSelectedInputSources:0:KeyboardLayout\ Name string Unicode\ Hex\ Input" "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo chown root:admin "/Library/Preferences/com.apple.HIToolbox.plist"
# sudo chmod 644 "/Library/Preferences/com.apple.HIToolbox.plist"
# Add Unicode hex input system input keyboard layout. [I'd rather do this the `defaults` way.]

defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # Enable full keyboard access for all controls.

#defaults write -g NSUserKeyEquivalents '{Zoom = "@$m";}'
# Add Shift-Command-M 'Maximize window' keyboard app shortcut. [It doesn't work so well, eg in Chrome, it fully expands a window resized to 50% of the desktop's width to fill the desktop, but it doesn't just refit the window to Chrome's default size which is a bit larger.]

#defaults write com.apple.universalaccess slowKey -bool FALSE # Disable Slow Keys. (i) Required from macOS 10.12 Sierra onwards to set faster key repeat rates.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool FALSE # Disable press-and-hold for keys.
defaults write NSGlobalDomain InitialKeyRepeat -int 10 # Set key repeat triggering delay to even shorter. /!\ Too fast: ≤10 (i) GUI fastest: 15
#defaults write com.apple.universalaccess slowKeyDelay -int 5
# defaults write NSGlobalDomain KeyRepeat -int 0 # Set key repeat rate to fastest. [i] Enables key repeat. /i\ From macOS 10.12 Sierra onwards, Apple modified the scales, making 0 too fast for some, also making 3 a reasonable value. [But I don't give a shit because I've got quite a pair of balls. Also, just set the triggering delay to 10 minimum --- end of story. Also: I'm a crazy fucker.]

# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool TRUE
# defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Use scroll gesture with Strg (⌃) modifier key to zoom.
# defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool TRUE # Follow the keyboard focus while zoomed in.

# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool FALSE # Disable automatic spell correction.

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool FALSE
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool FALSE
# Disable smart quotes and dashes; set smart double and single quotes to defaults.

echo 'Mouse & Trackpad (NSGlobalDomain, com.apple.driver.AppleHIDMouse, com.apple.driver.AppleBluetoothMultitouch.trackpad, com.apple.dock)'

defaults write com.apple.driver.AppleHIDMouse.plist Button2 -int 2 # Enable mouse secondary click.

defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehaviour -int 1
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool TRUE
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool TRUE
# Enable trackpad secondary click and set it as click or tap with two fingers. (i) `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2` to map bottom-right click to secondary click.

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool TRUE
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable trackpad tap to click for current user and login screen.

defaults write NSGlobalDomain com.apple.mouse.scaling -int 3 # Set mouse tracking speed to fast. (i) 0: slow; 3: fast.
#defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 1.7 # Set mouse scroll wheel scrolling speed to fast. (i) 0: slow; 1.7: fast. /!\ This seems to cause drag and drop in Finder to become slow to unresponsive.
#defaults write NSGlobalDomain com.apple.mouse.doubleClickThreshold -float 3.8625 # Set mouse double click needed speed to 75%. /!\ This seems to cause drag and drop in Finder to become slow to unresponsive.

defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3 # Set trackpad tracking speed to fast. (i) 0: slow; 3: fast.

defaults write NSGlobalDomain com.apple.swipescrolldirection -bool TRUE # Enable natural (OS X Lion-style) scroll direction. (i) Enable System preferences: TrackPad: Scroll & zoom: Scroll direction: natural.

defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool TRUE
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1
# (i) Enable System preferences: TrackPad: More gestures: Swipe between pages. Set Swipe between pages to Scroll left or right with two fingers.

defaults write com.apple.dock showLaunchpadGestureEnabled -int 0 # Disable trackpad Launchpad gesture (pinch with thumb and three fingers).

#echo 'Ink (Inkwell)'

echo "'Displays' & Display Server (NSGlobalDomain, com.apple.windowserver)"

sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool TRUE # Enable Hi-DPI display modes. /!\ Restart required.

defaults write NSGlobalDomain AppleFontSmoothing -int 2 # Enable medium subpixel font rendering on non-Apple LCD displays. (i) Enable Use LCD font smoothing when available.

echo "'Printers' (com.apple.print.PrintingPrefs)"

defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool TRUE # Automatically quit printer app when printing is over.

#echo "Airplay ('Displays' & Display server)"

echo 'AirPort (Network, or Ethernet & Wi-Fi)'

networksetup -setairportpower en0 on # Enable Wi-Fi.

echo 'Bluetooth & Bluetooth Setup Assistant (com.apple.Bluetooth, com.apple.BluetoothAudioAgent)'

defaults write /Library/Preferences/com.apple.Bluetooth BluetoothAutoSeekKeyboard '1' # Launch Bluetooth setup assistant at startup if no keyboard is detected.

sudo defaults write /Library/Preferences/com.apple.Bluetooth BluetoothAutoSeekPointingDevice '1' # Launch Bluetooth setup assistant at startup if no mouse or trackpad is detected.

defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40 # Improve overall bluetooth headphones or headsets sound quality.

osascript -e 'tell application "System Events" to tell process "SystemUIServer" to tell (menu bar item 1 of menu bar 1 whose description is "bluetooth") to {click, click (menu item 2 of menu 1)}' # Enable Bluetooth. [?] I'd prefer a non AppleScript & non kext unload way to do this, with defaults instead.

echo 'Data Storage Devices'

sudo nvram boot-args="mbasd=1" # Enable the MacBook Air SuperDrive on any Mac.

#echo "AppleScript & Script Editor"

#echo 'Dwell Control (Universal Access)'

echo 'Time Machine'

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool TRUE # Disable local Time Machine prompting to use new drives as backup volumes.

hash tmutil &> /dev/null && sudo tmutil disablelocal # Disable local Time Machine snapshots. [i] Apple laptop with SSD trick. (i) Enter `sudo tmutil enablelocal` to reenable local Time Machine snapshots.

#echo 'Siri'

echo 'UX, Aqua (GUI), SUI & VUI (NSGlobalDomain, com.apple.systempreferences, com.apple.CrashReporter, com.apple.helpviewer, com.apple.systemuiserver)'

#defaults write -g _HIEnableThemeSwitchHotKey -bool TRUE
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool TRUE
# Enable dark theme switch hotkey —- PRESS [CONTROL] + [OPTION] + [COMMAND] + [T] TO START!

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool FALSE # Disable save to iCloud by default.

defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool FALSE # Disable resume on restart. (i) Disable Reopen windows when logging back in (Resume).

defaults write NSGlobalDomain NSDisableAutomaticTermination -bool TRUE # Disable automatic termination of inactive applications.

#defaults write com.apple.CrashReporter DialogType -string "none" # Disable the crash reporter.

defaults write com.apple.helpviewer DevMode -bool TRUE # (i) Set Help viewer to non floating mode.

/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user # Remove duplicates in Open with menu.

defaults write NSGlobalDomain NSWindowResizeTime -float 0.001 # Increase window resizing and fullscreen mode animation speed.

defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"
# Display volume menu bar item.defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.user" -bool FALSE
defaults delete com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/User.menu"
# Hide fast user switching menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.dwellcontrol" -bool FALSE
#defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/DwellControl.menu"
# Disable Dwell Control (Universal Access) menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.universalaccess" -bool FALSE
defaults delete com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/UniversalAccess.menu"
# Disable Universal Access menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
# Display Bluetooth (Bluetooth & Bluetooth Setup Assistant) menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airport" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/AirPort.menu"
# Display AirPort (network, or Wi-Fi) menu bar item.
#defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.ppp" -bool TRUE
#defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/PPP.menu"
# Display PPP menu bar item.
#defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.pppoe" -bool TRUE
#defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/PPPoE.menu"
# Display PPPoE menu bar item.
#defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.vpn" -bool TRUE
#defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/VPN.menu"
# Display VPN menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.TimeMachine" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
# Display Time Machine menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.scriptmenu" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Script Menu.menu"
# Display Script Menu (AppleScript & Script Editor) menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.clock" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Clock.menu"
defaults write com.apple.menuextra.clock IsAnalog -bool FALSE
# Display clock menu bar item, and display the clock as digital.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.battery" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Battery.menu"
defaults write com.apple.menuextra.battery ShowPercent -bool TRUE
# Display battery menu bar item, and display the battery percentage.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.textinput" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/TextInput.menu"
# Display text input (Keyboard & Touch Bar) menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.ink" -bool FALSE
#defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Ink.menu"
# Disable Ink (Inkwell) menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airplay" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Displays.menu"
# Display AirPlay ('Displays' & Display Server) menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.iChat" -bool FALSE
#defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/iChat.menu"
# Disable iChat menu bar item.
defaults write com.apple.Siri StatusMenuVisible -bool FALSE
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool FALSE
# Disable Siri menu bar item.
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.eject" -bool TRUE
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Eject.menu"
# Display eject (Menu Bar & Touch Bar (UX, Aqua (GUI), SUI & VUI)) menu bar item.

defaults write NSGlobalDomain NSTextShowsControlCharacters -bool TRUE # Display ASCII control characters using caret notation in plain text view.

defaults write NSGlobalDomain AppleICUForce12HourTime -bool FALSE # Enable 24h time format. (i) Enable System preferences: Date & time: Clock: Time options: Use a 24-hour clock.

#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool FALSE # Disable smooth scrolling. [i] Old-Mac-that-mess-the-animation-up trick.

defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic" # Display scroll bars automatically. (i) Other values are `WhenScrolling` and `Always`.

defaults write com.apple.universalaccess reduceTransparency -bool FALSE # (i) Enable Translucent menu bar.

defaults write NSGlobalDomain AppleHighlightColor -string '1.000000 0.749020 0.823529' # (i) Set Highlight color to OS X Yosemite's Pink.

sudo nvram SystemAudioVolume=" " # Disable the startup sound. [i] Enter `sudo nvram -d SystemAudioVolume` to reenable the startup sound.

echo 'Finder & AirDrop (NSGlobalDomain, com.apple.desktopservices, com.apple.finder, com.apple.frameworks.diskimages, com.apple.NetworkBrowser)'

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE # Disable .DS_Store files writing on network volumes.

defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool TRUE # Enable AirDrop with Ethernet and on unsupported Mac running Mac OS X Lion.

defaults write com.apple.finder QuitMenuItem -bool TRUE # Enable Quit Finder  ⌘ Q.

#defaults write com.apple.finder WarnOnEmptyTrash -bool FALSE # Disable the trash emptying warning.

defaults write com.apple.frameworks.diskimages skip-verify -bool TRUE
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool TRUE
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool TRUE
# Disable disk images verification.

defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool TRUE
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool TRUE
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool TRUE
# Autoopen a new Finder window when a new volume is mounted.

defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
# Set home as new windows directory. (i) Use "PfDe" and "file://${HOME}/Desktop" for desktop or "PfLo" and "file:///path" for other paths.

defaults write NSGlobalDomain com.apple.springing.enabled -bool TRUE # Enable spring loading for directories.
defaults write NSGlobalDomain com.apple.springing.delay -float 0 # Set spring loading delay to null.

defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # Set Finder search to search the current folder.

defaults write com.apple.finder FXArrangeGroupViewBy -string Kind # Sort files by kind.

defaults write com.apple.finder ShowStatusBar -bool TRUE # Display status bar.

defaults write com.apple.finder ShowPathbar -bool TRUE # Display path bar.

defaults write com.apple.finder _FXShowPosixPathInTitle -bool TRUE # Display full POSIX path as window title.

defaults write com.apple.finder FXInfoPanesExpanded -dict \
                                                          General -bool TRUE \
                                                          OpenWith -bool TRUE \
                                                          Privileges -bool TRUE
# Expand General, Open with and Sharing & permissions file info panes by default.

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool TRUE
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool TRUE
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool TRUE
# Expand save pane by default.

#rm -rf ${HOME}/Library/Application\ Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s ${picturefile} /System/Library/CoreServices/DefaultDesktop.jpg
# Set wallpaper. (i) `DefaultDesktop.jpg` is a symlink. (i) Wallpapers are at `/Library/Desktop Pictures`; default wallpaper is `Wave.jpg`.
#defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture "${picturefilepath}.jpg"
#defaults write com.apple.desktop Background '{default = {ImageFilePath = "${picturefilepath}.jpg"; };}'
# Set wallpaper. /!\ Deprecated from OS X 10.9.5 Mavericks onwards.
#osascript -e 'tell application "Finder" to set desktop picture to "${picturefilepath}.jpg" as POSIX file' # Set Desktop wallpaper.

defaults write com.apple.finder FXPreferredViewStyle -string "clmv" # Set default view to columns. (i) Other viewing modes are 'icnv' for icons, 'Nlsv' for newlines and 'Flwv' for Cover flow.

/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo TRUE" ${HOME}/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo TRUE" ${HOME}/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo TRUE" ${HOME}/Library/Preferences/com.apple.finder.plist
# Show item info near icons on the desktop and in other icon views.

/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom FALSE" ${HOME}/Library/Preferences/com.apple.finder.plist # Display desktop items infos to their icons' right.

defaults write com.apple.finder ShowHardDrivesOnDesktop -bool TRUE # Display internal drives on the desktop. [i] Enable Hard disks.

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool TRUE # Display external drives on the desktop. [i] Enable External disks.

defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool TRUE # Display removable media on the desktop. [i] Enable CD, DVD and iPod.

defaults write com.apple.finder ShowMountedServersOnDesktop -bool TRUE # Display mounted servers on the desktop. [i] Enable Connected servers.

defaults write NSGlobalDomain AppleShowAllExtensions -bool TRUE # Display filename extensions. [i] Enable Show all filename extensions.

defaults write com.apple.finder AppleShowAllFiles -bool TRUE # Display hidden files.

defaults write com.apple.finder DisableAllAnimations -bool TRUE # Disable Finder window & Get info pane animations.

echo 'Spotlight (com.apple.spotlight)'

defaults write com.apple.spotlight orderedItems -array \
                                                       '{"enabled" = 1;"name" = "APPLICATIONS";}' \
                                                       '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
                                                       '{"enabled" = 1;"name" = "DIRECTORIES";}' \
                                                       '{"enabled" = 0;"name" = "DOCUMENTS";}' \
                                                       '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
                                                       '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
                                                       '{"enabled" = 0;"name" = "PDF";}' \
                                                       '{"enabled" = 0;"name" = "MESSAGES";}' \
                                                       '{"enabled" = 0;"name" = "CONTACT";}' \
                                                       '{"enabled" = 0;"name" = "EVENT_TODO";}' \
                                                       '{"enabled" = 0;"name" = "IMAGES";}' \
                                                       '{"enabled" = 0;"name" = "BOOKMARKS";}' \
                                                       '{"enabled" = 0;"name" = "MUSIC";}' \
                                                       '{"enabled" = 0;"name" = "MOVIES";}' \
                                                       '{"enabled" = 0;"name" = "FONTS";}' \
                                                       '{"enabled" = 0;"name" = "SOURCE";}' \
                                                       '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
                                                       '{"enabled" = 0;"name" = "MENU_OTHER";}' \
                                                       '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
                                                       '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
                                                       '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
                                                       '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Change indexing order and disable some Spotlight search results. [i] MENU_DEFINITION, MENU_CONVERSION, MENU_EXPRESSION, MENU_SPOTLIGHT_SUGGESTIONS [send search queries to Apple], MENU_WEBSEARCH [send search queries to Apple] and MENU_OTHER are OS X 10.10 Yosemite+ search results.
killall mds > /dev/null 2>&1 # Load new settings before rebuilding the index.
sudo mdutil -i on / > /dev/null # Ensure indexing is enabled for the main volume.
sudo mdutil -E / > /dev/null # Rebuild index from scratch.

sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes" # Disable Spotlight indexing for never indexed mounted volumes.

#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search # Disable Spotlight menu bar icon.

echo "'Screenshooter' (com.apple.screencapture)"

defaults write com.apple.screencapture type -string 'png' # Set screenshots format to PNG. (i) Other options are `bmp` for Windows Bitmap, `gif` for GIF, `jpg` for JPEG, `jp2` for JPEG2000, `tif` for TIFF, `pict` for Macintosh PICT and `tga` for TARGA.

defaults write com.apple.screencapture name -string 'Screenshot' # Set screenshots filename as 'Screenshot ${YYYY}-${MM}-${DD} at ${h}.${mn}.${s}.${ext}'. (i) default option: 'Screen Shot'; custom options: '', and '\b' lead to a whitespace at the filename start [that the latter cannot erase]. [I didn't find any delete escape character or how to send hex code with `-data`.]
#sudo cp /System/Library/CoreServices/SystemUIServer.app/Contents/Resources/English.lproj/ScreenCapture.strings ${HOME}/Desktop/ScreenCapture.strings
#sudo plutil -convert xml1 /System/Library/CoreServices/SystemUIServer.app/Contents/Resources/English.lproj/ScreenCapture.strings
#sed -i -e \
#          's/<string>%@\ %@<\/string>/<string>%@%@<\/string>/g' \
#          's/<string>%@\ %@\ at\ %@<\/string>/<string>%@%@%@<\/string>/g' \
#          's/<string>%@\ %@\(%@\)<\/string>/<string>%@%@%@<\/string>/g' \
#          's/<string>%@\ \(%@\)<\/string>/<string>%@%@<\/string>/g' \
#          /System/Library/CoreServices/SystemUIServer.app/Contents/Resources/English.lproj/ScreenCapture.strings ${HOME}/Desktop/ScreenCapture.strings
# sudo plutil -convert binary1 /System/Library/CoreServices/SystemUIServer.app/Contents/Resources/English.lproj/ScreenCapture.strings ${HOME}/Desktop/ScreenCapture.strings
# Copy ScreenCapture.strings to Desktop/, convert ScreenCapture.strings to XML plist version 1, edit content then convert ScreenCapture.strings back to binary plist version 1. /!\ Bad practice: XML editing with sed & System/ content editing [probably prevented by OS X El Capitan's SIP].

#defaults write com.apple.screencapture include-date -bool FALSE # Disable date in screenshot filename.

#defaults write com.apple.screencapture location -string "${HOME}/Desktop" # Set screenshot writing location to Desktop/.

#defaults write com.apple.screencapture disable-shadow -bool TRUE # Disable shadows in screenshots.

echo 'QuickLook (com.apple.finder)'

#echo -n "0x08000100:0x0" > ${HOME}/.CFUserTextEncoding # Fix the ancient UTF-8 bug in QuickLook. /!\ Causes issues with Adobe Illustrator CS5.

defaults write com.apple.finder QLEnableTextSelection -bool TRUE # Enable text selection in QuickLook.

echo 'Dock (com.apple.dock)'

#defaults write com.apple.dock single-app -bool FALSE # Disable Single app mode.

defaults write com.apple.dock minimize-to-application -bool TRUE # Enable window's title bar double-clicking to minimize.

defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool TRUE # Enable spring loading for all items.

defaults write com.apple.dock scroll-to-open -bool TRUE # Enable scroll gestures.

defaults write com.apple.dock mouse-over-hilite-stack -bool TRUE # Enable highlight when hovering for the grid view of a stack.

defaults write com.apple.dock show-process-indicators -bool TRUE # Display indicator lights for open applications.

defaults write com.apple.dock showhidden -bool TRUE # Enable translucent items for hidden apps.

defaults write com.apple.dock pinning -string start # Set position to the left or top.

defaults write com.apple.dock orientation left # Set alignment to the left or top.

defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
# Remove any and all item.

defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Activity Monitor.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/App Store.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Calendar.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Contacts.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Dropbox.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Microsoft Office 2011/Microsoft Excel.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Goofy.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Jumpcut.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Adobe Lightroom/Adobe Lightroom.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Mail.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Adobe Photoshop CS6/Adobe Photoshop CS6.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Preview.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
#defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Script Editor.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>' # (i) AppleScript Editor is named Script Editor from OS X Yosemite onwards.
#defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Server.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/SizeUp.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
#defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Sketch.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/TextEdit.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/VLC.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/VMware Fusion.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/WhatsApp.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
#defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Xcode.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>arrangement</key><integer>1</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Applications</string><key>file-type</key><integer>2</integer><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>2</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>arrangement</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/kvpb/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Downloads</string><key>file-type</key><integer>2</integer><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>2</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>arrangement</key><integer>5</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/kvpb/Dropbox/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Dropbox</string><key>file-type</key><integer>2</integer><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>2</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"#defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Users/kvpb/misc</string><key>_CFURLStringType</key><integer>0</integer></dict><key>file-label</key><string>Miscellaneous</string><key>file-type</key><integer>18</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
defaults delete com.apple.dock mod-count
# Add Activity Monitor, App Store, Calendar, Chrome, Contacts, Dropbox, Excel, Goofy, iTerm2, Jumpcut, Photoshop Lightroom, Mail, Photoshop Extended, Preview, Script Editor, Server, SizeUp, Sketch, TextEdit, VLC, WhatsApp & Xcode app items, a Recent items stack and the Applications, Downloads & Dropbox folders.

defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the app items area.

defaults write com.apple.dock mineffect -string "scale" # Set window minimaximazation effect to scale. /!\ Do not set to hidden 'suck' which, you know, sucks.

defaults write com.apple.dock hide-mirror -bool TRUE # Disable mirror effect.

defaults write com.apple.dock no-glass -bool YES # Disable glass effect.

defaults write com.apple.dock launchanim -bool FALSE # Disable opening applications animation.

defaults write com.apple.dock autohide -bool TRUE # Enable autohiding.
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
# Speed autohiding animation up.

echo 'Mission Control (com.apple.dock)' # (i) Mission Control has been substituted to Exposé.

defaults write com.apple.dock mru-spaces -bool FALSE # Disable automatic spaces rearranging based on most recent use.

#defaults write com.apple.dock expose-group-by-app -bool FALSE # Set Mission control's behavior as Exposé's. [i] Disable Group windows by application.

defaults write com.apple.dock expose-animation-duration -float 0.1 # Speed animations up.

echo 'Dashboard (com.apple.dock, com.apple.dashboard)'

defaults write com.apple.dock dashboard-in-overlay -bool TRUE # Hide dashboard as a space.

defaults write com.apple.dashboard mcx-disabled -bool TRUE # Disable the dashboard.

defaults write com.apple.dashboard devmode -bool TRUE # Enable dashboard dev mode. (i) Allows to keep widgets on the desktop.

echo 'Launchpad (com.apple.dock)'

#find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete # Reset Launchpad keeping the desktop wallpaper intact.
defaults write com.apple.dock ResetLaunchPad -bool TRUE # Reset Launchpad organization to defaults.

sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/iOS Simulator.app" "/Applications/iOS Simulator.app" # Add iOS simulator to Launchpad.

defaults write com.apple.dock showLaunchpadGestureEnabled -int 0 # Disable the pinch with thumb and three fingers trackpad gesture. (i) Launchpad: Trackpad -> System preferences: TrackPad: More gestures.

#echo 'Notification Center'

#launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null # Disable the notification center and remove its menu bar. [i] 'Fixed' by Apple on macOS 10.13 High Sierra, but hey 'it's not a bug, it's a feature'.

echo 'Software Update & App Store (com.apple.SoftwareUpdate, com.apple.commerce, com.apple.appstore)'

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool TRUE # Enable the automatic update check.

defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 # Set software updates check frequency to daily.

defaults write com.apple.SoftwareUpdate AutomaticDownload -int 0 # Disable available updates background automatic download.

defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 0 # Disable system data files and security updates automatic installation.

defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 0 # Disable automatic download of apps purchased on other Apple computers.

defaults write com.apple.commerce AutoUpdate -bool FALSE # Disable app autoupdate.

defaults write com.apple.commerce AutoUpdateRestartRequired -bool TRUE # Block the App store to reboot the machine on OS X updates.

defaults write com.apple.appstore ShowDebugMenu -bool TRUE # Enable the App store's debug menu.
defaults write com.apple.appstore WebKitDeveloperExtras -bool TRUE # Enable the App store's WebKit dev tools.

#echo 'Xcode'

#xcode-select --install
#xcodebuild -license accept
# Install Xcode and accept the Xcode EULA.

echo 'Terminal & X11 (com.apple.terminal, org.x.X11, com.apple.x11)'

defaults write com.apple.terminal StringEncodings -array 4 # Set Terminal encoding to UTF-8.

defaults write com.apple.terminal ApplePressAndHoldEnabled -bool FALSE # Disable Terminal press-and-hold for keys.

defaults write com.apple.terminal SecureKeyboardEntry -bool TRUE # Enable Terminal secure keyboard entry.

defaults write com.apple.terminal FocusFollowsMouse -bool TRUE
defaults write com.apple.x11 wm_ffm -bool TRUE # (i) Enter `defaults write org.x.X11 wm_ffm -bool TRUE` on Mac OS X Snow Leopard.
# Enable focus follows mouse (point-to-focus) for Terminal and X11 apps.

defaults write com.apple.terminal StartAtLogin -bool TRUE # Launch Terminal at startup.

echo 'TextEdit (com.apple.TextEdit, com.apple.LaunchServices)'

defaults write com.apple.TextEdit NSUserKeyEquivalents \
'{ \
	"\033Format\033Font\033Baseline\033Subscript" = "@$-"; \
	"\033Format\033Font\033Baseline\033Superscript" = "@$6"; \
	Justify = "@~$["; \
}';
# Add TextEdit keyboard app shortcuts:
# 	Shift-Command-6 (Command-^ on US Mac keyboard layout) 'Superscript'
# 	Shift-Command-- (Command-_ on US Mac keyboard layout) 'Subscript'
# 	Alt-Shift-Command-[ (Option-Command-{ on US Mac keyboard layout) 'Justify'

defaults write com.apple.TextEdit ShowRuler -bool FALSE # Display ruler. (i) Enable Show ruler.
defaults write com.apple.TextEdit SmartCopyPaste -bool FALSE # (i) Disable Smart copypaste.
defaults write com.apple.TextEdit SmartQuotes -bool FALSE # (i) Disable Smart quotes.
defaults write com.apple.TextEdit SmartDashes -bool FALSE # (i) Disable Smart dashes.
defaults write com.apple.TextEdit SmartLinks -bool FALSE # (i) Disable Smart links.
defaults write com.apple.TextEdit TextReplacement -bool FALSE # (i) Disable Text replacement.
defaults write com.apple.TextEdit CorrectSpellingAutomatically -bool FALSE # (i) Disable Correct spelling automatically.
defaults write com.apple.TextEdit CheckSpellingWhileTyping -bool FALSE # (i) Disable Check spelling as you type.
defaults write com.apple.TextEdit CheckGrammarWithSpelling -bool FALSE # (i) Disable Check grammar with spelling.
defaults write com.apple.TextEdit DataDetectors -bool FALSE # (i) Disable Data detectors.

defaults write com.apple.TextEdit PlainTextEncoding -int 4 # (i) Set TextEdit: Preferences: Open and save: Plain text encoding: Opening files to Unicode (UTF-8).
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4 # (i) Set TextEdit: Preferences: Open and save: Plain text encoding: Saving files to Unicode (UTF-8).

defaults write com.apple.TextEdit NSFixedPitchFont -string "Menlo-Regular"
defaults write com.apple.TextEdit NSFixedPitchFontSize -int "10"
# Set plain text font to Apple Menlo 10pt. (i) OS X's default fixed-width font.
#defaults write com.apple.TextEdit NSFixedPitchFont -string "HelveticaMonospacedPro-Rg"
#defaults write com.apple.TextEdit NSFixedPitchFontSize -int "11"
# Set plain text font to Helvetica Monospaced 11pt. [Menlo's close enough to Helvetica to look coherent. I'd rather use Helvetica Monospaced. I may try Pragmata someday.]
#defaults write com.apple.TextEdit NSFont -string "Times-Roman"
#defaults write com.apple.TextEdit NSFontSize -int "12"
# Set rich text font to Linotype Times Roman 12pt. (?) I's 'start small' preferred serif typeface, kinda chosen retrogradually from APA Style's. /!\ Prefer pro to standard fonts versions. [I'm keeping that one 'til L3. I'll ditch it for Times New Roman 12pt from M1 on.]
#defaults write com.apple.TextEdit NSFont -string "TimesNewRomanPSMT"
#defaults write com.apple.TextEdit NSFontSize -int "12"
# Set rich text font to Monotype Times New Roman 12pt. (i) I and APA Style's preferred serif typeface. http://blog.apastyle.org/apastyle/2013/03/fonts-of-knowledge.html /!\ Prefer pro to standard fonts versions.
#defaults write com.apple.TextEdit NSFont -string "ArialMT"
#defaults write com.apple.TextEdit NSFontSize -int "11"
# Set rich text font to Monotype Arial 11pt. (i) APA Style & Paris Descartes University's preferred serif typeface.
#defaults write com.apple.TextEdit NSFont -string "Helvetica"
#defaults write com.apple.TextEdit NSFontSize -int "11"
# Set rich text font to Linotype Helvetica 11pt. (i) APA Style's preferred sans serif typefaces and I's 'start small' one. /!\ Prefer pro to standard fonts versions. [I intend to ditch it for Helvetica Neue 11pt by the M1 beginning too.]
defaults write com.apple.TextEdit NSFont -string "HelveticaNeue"
defaults write com.apple.TextEdit NSFontSize -int "11"
# Set rich text font to Linotype Helvetica Neue 11pt. (i) I's preferred sans serif typeface. /!\ Prefer pro to standard fonts versions. [Fuck Akzidenz Grotesk --- long live Neue Haas Grotesk. I'll still keep using that one for personal writings only since Paris 5 asks for Arial.]

defaults write com.apple.TextEdit RichText -int 0 # Set new document text format to plain text.
defaults write com.apple.TextEdit ShowPageBreaks -bool TRUE # (i) Disable Wrap to page.
defaults write com.apple.TextEdit WidthInChars -int 80 # Set new document window width to 80 chars (or columns).
defaults write com.apple.TextEdit HeightInChars -int 24 # Set new document window height to 24 chars (or lines).
defaults write com.apple.TextEdit TabWidth -int 4 # Set tab width to 4 chars.
defaults write com.apple.TextEdit AddExtensionToNewPlainTextFiles -bool FALSE # Disable .txt extension autoadding at save to extensionless new plain text files. (i) Disable Add '.txt' extension to plain text files.

defaults write com.apple.TextEdit author -string "Karl Bertin" # Set new document author name to KVPB's.
defaults write com.apple.TextEdit company -string "" # Set new document company name.
defaults write com.apple.TextEdit copyright -string "" # Set new document copyright.

defaults write com.apple.TextEdit IgnoreHTML -bool TRUE # Display HTML files as code. (i) Enable Display HTML files as HTML code instead of formatted text.
defaults write com.apple.TextEdit IgnoreRichText -bool FALSE # Display RTF files as formatted text. (i) Disable Display RTF files as RTF code instead of formatted text.

defaults write com.apple.TextEdit HTMLEncoding -int 20 # (i) Set TextEdit: Preferences: Open and save: HTML saving options: Encoding to Unicode (UTF-8).
defaults write com.apple.TextEdit UseXHTMLDocType -bool FALSE
defaults write com.apple.TextEdit UseTransitionalDocType -bool TRUE
# Set new HTML document type to HTML 4.01 transitional. (i) Both are crossed attributes (eg enter `UseXHTMLDocType -bool FALSE` and `UseTransitionalDocType -bool FALSE` to set document type to HTML 4.01 strict).
defaults write com.apple.TextEdit UseEmbeddedCSS -bool FALSE
defaults write com.apple.TextEdit UseInlineCSS -bool FALSE
# Set new HTML document styling to embedded CSS. (i) Both are crossed attributes (eg enter `UseEmbeddedCSS -bool FALSE` and `UseInlineCSS -bool FALSE` to set styling to no CSS).

defaults write com.apple.TextEdit PreserveWhitespace -bool TRUE # (i) Enable Preserve whitespace.

#defaults write com.apple.LaunchServices LSHandlers -array-add '{LSHandlerContentType=org.openxmlformats.wordprocessingml.document;LSHandlerRoleAll=com.apple.textedit;}'
# Set TextEdit as default Office Open XML Document editor.

echo 'Disk Utility (com.apple.DiskUtility)'

defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool TRUE
defaults write com.apple.DiskUtility advanced-image-options -bool TRUE
# Enable the debug menu.

echo 'Activity Monitor (com.apple.ActivityMonitor)'

defaults write com.apple.ActivityMonitor OpenMainWindow -bool TRUE # Display the main window when launching.

defaults write com.apple.ActivityMonitor ShowCategory -int 0 # Display all processes.

defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
# Display results sorted by CPU usage.

defaults write com.apple.ActivityMonitor IconType -int 5 # Display CPU usage icon in the Dock.

echo 'Safari & WebKit (com.apple.safari)'
# This section is experimental. I wrote Safari settings all by myself, based on
# my research. Basically, this section is the example of how I want this script
# to configure ACOS: in case of emergency on a clean install, what would I need
# most [or what I hold close to my heart] is set first.

defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool TRUE
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool TRUE
# Enable [Tab] to highlight webpages items. (i) Enable Press Tab to highlight each item on a webpage.
defaults write com.apple.Safari CommandClickMakesTabs -int 1 # Enable Command + Right click to open links in new tabs. (i) Enable ⌘ -click opens a link in a new tab.

defaults write com.apple.Safari WebKitDefaultTextEncodingName -string "utf-8" # Set default encoding to UTF-8. (i) Set Default encoding to Unicode (UTF-8).
defaults write com.apple.Safari HistoryAgeInDaysLimit -int 2147483647 # 'Disable' history automatic removal. (i) Set Remove history items to 'After Int32'.
defaults write com.apple.Safari LocalFileRestrictionsEnabled -bool TRUE # Disable local files access. (i) Disable Disable local file restrictions.
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool TRUE # (i) Enable Warn when visiting a fraudulent website.

defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool TRUE
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool TRUE
# Enable the web inspector.

defaults write com.apple.Safari WebKitMinimumFontSize -int 0
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2MinimumFontSize -int 0
# Disable font sizes smaller than 9 use. (i) Enable Never use font sizes smaller than N. Set Never use font sizes smaller than to 9.
defaults write com.apple.Safari UserStyleSheetEnabled -int 0 # (i) Set Style sheet to None selected.

defaults write com.apple.Safari DownloadsPath -string "${HOME}/Downloads" # Set downloads storage path to `${HOME}/Downloads`. (i) Set Save downloaded files to to Downloads/.
defaults write com.apple.Safari AutoOpenSafeDownloads -bool FALSE # Disable downloaded 'safe' files automatic opening. (i) Disable Open “safe” files after downloading.

defaults write com.apple.Safari HomePage -string "about:blank" # Set homepage URL to `about:blank`. (i) Set Homepage to `about:blank`.
defaults write com.apple.Safari NewWindowBehavior -int 0 # Set new windows to open at homepage. (i) Set New windows open with to Homepage.
defaults write com.apple.Safari NewTabBehavior -int 0 # Set new tabs to open at homepage. (i) Set New tabs open with to Homepage.

defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool TRUE # Enable Safari sessions restoration at launch. (i) Set Safari opens with to All windows from last session.
defaults write com.apple.Safari OpenNewTabsInFront -bool FALSE # Disable new tabs automatic activation. (i) 'Activation' is when a window is brought to foreground.
defaults write com.apple.Safari TabCreationPolicy -int 1 # Set pages to automatically open in tabs instead of windows. (i) Set Open pages in tabs instead of windows to Automatically.

defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool FALSE
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool FALSE
# Block popup windows.

defaults write com.apple.Safari WebKitStorageBlockingPolicy -int 1
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2StorageBlockingPolicy -int 1
# Block cookies and other website data from third parties and advertisers. (i) Set Block cookies and other website data to From third parties and advertisers.

defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 0 # 'Disable' location services access. (i) Set Limit website access to location services to Deny without prompting.
defaults write com.apple.Safari SuppressSearchSuggestions -bool TRUE # Block search engines suggestions providing. (i) Enable Prevent search engine from providing suggestions.
defaults write com.apple.Safari PreloadTopHit -bool FALSE # Disable top hit preloading. (i) Enable Do not preload Top hit in the background.
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool TRUE # Enable Do not track. (i) Enable Ask websites not to track me.

defaults write com.apple.Safari CanPromptForPushNotifications -bool FALSE # 'Disable' push notifications for websites. (i) Disable Allow websites to ask for permission to send push notifications.

defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PlugInSnapshottingEnabled -bool FALSE # (i) Enable Stop plugins to save power.
defaults write com.apple.Safari WebKitPluginsEnabled -bool FALSE
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool FALSE
# Disable plugins.

defaults write com.apple.Safari WebKitJavaEnabled -bool FALSE
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool FALSE
# Disable Java.

defaults write com.apple.Safari WebKitJavaScriptEnabled -bool TRUE
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptEnabled -bool TRUE
# Enable JavaScript.

defaults write com.apple.Safari ExtensionsEnabled -bool FALSE # Enable Safari extensions. (i) Enable Extensions.
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool TRUE # Enable automatic extensions updates. (i) Enable Install updates automatically.

defaults write com.apple.Safari AutoFillPasswords -bool FALSE # (i) Disable AutoFill user names and passwords.
defaults write com.apple.Safari AutoFillCreditCardData -bool FALSE # (i) Disable Credit cards.
defaults write com.apple.Safari AutoFillFromAddressBook -bool FALSE # (i) Disable Using info from my Contacts card.
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool FALSE # (i) Disable Other forms.
# Disable autofill.

defaults write com.apple.Safari IncludeDevelopMenu -bool TRUE # Display develop menu in the menu bar. (i) Enable Show Develop menu in menu bar.
defaults write com.apple.Safari ShowStatusBar -bool TRUE # Display the status bar. (i) Enable Show status bar  ⌘ /.

defaults write com.apple.Safari BookmarksMenuIncludesRendezvous -bool FALSE # Disable bookmarks Bonjour menu.
defaults write com.apple.Safari ProxiesInBookmarksBar "()" # Clear favorite bookmarks bar. (i) Remove Reading list and Top sites from the bookmarks bar.
defaults write com.apple.Safari ShowFavoritesBar -bool FALSE # Hide favorite bookmarks bar. (i) Hide Favorites bar  ⇧ ⌘ B.

defaults write com.apple.Safari SidebarViewModeIdentifier -string "Bookmarks" # Display bookmarks sidebar.
defaults write com.apple.Safari ShowSidebarInNewWindows -bool FALSE # Hide sidebar in new windows.

defaults write com.apple.Safari TopSitesGridArrangement -int 0 # Display as few top sites as possible. (i) Set Top sites show to 6 sites.

echo 'Mail (com.apple.mail)'

defaults write com.apple.mail DisableInlineAttachmentViewing -bool TRUE # Disable inline attachments. (i) Only show the icons.

defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool FALSE # Copy email addresses as `{ first }.{ last }@{ domain }.{ sx }` instead of '{ First } { Last } <{ first }.{ last }@{ domain }.{ sx }>'. [i] Disable Use smart addresses.

defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedAscending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
# Display emails in threaded mode and sort them as newest at the top. (i) Enable Show most recent message at the top.

defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled" # Disable automatic spell checking. [i] Set Check spelling to Never.

echo 'Calendar (com.apple.iCal)' # (i) Calendar was formerly iCal.

#defaults write com.apple.iCal IncludeDebugMenu -bool TRUE # Enable the debug menu. /!\ Deprecated from OS X 10.8 Mountain Lion onwards.

defaults write com.apple.iCal "scroll by weeks in week view" -int 2 # (i) Set Scroll in week view by to Week, stop on today.

defaults write com.apple.iCal "first day of week" -int 1 # Set week start to monday.

defaults write com.apple.iCal "Show Week Numbers" -bool TRUE # Display week numbers. /!\ OS X 10.8 Mountain Lion trick.

defaults write com.apple.iCal "Show time in Month View" -bool TRUE # Display events time in month view.

defaults write com.apple.iCal "n days of week" -int 7 # Display 7 days.

echo 'Contacts (com.apple.addressbook)' # (i) Contacts was formerly named Address Book.

#defaults write com.apple.addressbook ABShowDebugMenu -bool TRUE # Enable the debug menu in Address Book. [i] Deprecated from OS X 10.9 Mavericks onwards.

#echo 'iChat'

echo 'Messages (com.apple.messageshelper.MessageController)'

defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool FALSE # Disable automatic emoji substitution.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool FALSE # Disable smart quotes.

defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool FALSE # Disable continuous spell checking.

cecho 'Second-Party Settings: User-Specific Filesystem Customs' $yellow

#cd && git clone https://github.com/kvpb/.files.git
# Change working directory to ${HOME}/ and clone my .files/ from GitHub.

if [ -d "${HOME}/{kbs,misc,ops}" ]; then # if [ -d "${HOME}/{kbs,.files,misc,ops}" ]; then
	if [ -L "${HOME}/{kbs,misc,ops}" ]; then # if [ -L "${HOME}/{kbs,.files,misc,ops}" ]; then
		mv ${HOME}/{kbs,misc,ops} ${HOME}/.Trash/ # rm ${HOME}/{kbs,.files,misc,ops}
		mkdir ${HOME}/{kbs,misc,ops} # mkdir ${HOME}/{kbs,.files,misc,ops}
	fi
else
	mkdir -p ${HOME}/{kbs,misc,ops} # mkdir -p ${HOME}/{kbs,.files,misc,ops}
fi
# If kbs, .files, misc and ops aren't directories in ${HOME}/ then substitute symlinks by or add these directories.
if [ -d "${HOME}/Downloads/{misc,doc,pic,mus,mov}" ]; then
	if [ -L "${HOME}/Downloads/{misc,doc,pic,mus,mov}" ]; then
		mv ${HOME}/Downloads/{misc,doc,pic,mus,mov} ${HOME}/.Trash/
		mkdir ${HOME}/Downloads/{misc,doc,pic,mus,mov}
	fi
else
	mkdir -p ${HOME}/Downloads/{misc,doc,pic,mus,mov}
fi
# If misc, doc, pic, mus and mov aren't directories in ${HOME}/Downloads/ then substitute symlinks by or add these directories.
if [ -d "${HOME}/{DCIM,Camera}" ]; then
	if [ -L "${HOME}/{DCIM,Camera}" ]; then
		mv ${HOME}/{DCIM,Camera} ${HOME}/.Trash/
		mkdir ${HOME}/{DCIM,Camera}
	fi
else
	mkdir -p ${HOME}/{DCIM,Camera}
fi
# If DCIM and Camera aren't directories in ${HOME}/ then substitute symlinks by or add these directories.

ln -s ${HOME}/.files/.inputrc ${HOME}/.inputrc
#ln -s ${HOME}/.files/.shrc ${HOME}/.shrc
#ln -s ${HOME}/.files/.shinit ${HOME}/.shinit
#ln -s ${HOME}/.files/.profile ${HOME}/.profile
ln -s ${HOME}/.files/.exports ${HOME}/.exports
ln -s ${HOME}/.files/.functions ${HOME}/.functions
ln -s ${HOME}/.files/.aliases ${HOME}/.aliases
ln -s ${HOME}/.files/.bashrc ${HOME}/.bashrc
ln -s ${HOME}/.files/.bash_login ${HOME}/.bash_login
ln -s ${HOME}/.files/.bash_profile ${HOME}/.bash_profile
ln -s ${HOME}/.files/.bash_logout ${HOME}/.bash_logout
ln -s ${HOME}/.files/.bash_prompt ${HOME}/.bash_prompt
ln -s ${HOME}/.files/.zshrc ${HOME}/.zshrc
ln -s ${HOME}/.files/.zprofile ${HOME}/.zprofile
#ln -s ${HOME}/.files/.ssh ${HOME}/.ssh # ln -s ${HOME}/.files/.ssh/config ${HOME}/.ssh/config
ln -s ${HOME}/.files/.vimrc ${HOME}/.vimrc
ln -s ${HOME}/.files/.vim ${HOME}/.vim
ln -s ${HOME}/.files/.gitconfig ${HOME}/.gitconfig
ln -s ${HOME}/.files/.gitignore_global ${HOME}/.gitignore_global
ln -s ${HOME}/.files/lib/AppleScripts ${HOME}/Library/Scripts
ln -s ${HOME}/Downloads/misc ${HOME}/misc/dld
ln -s ${HOME}/Downloads/doc ${HOME}/Documents/dld
ln -s ${HOME}/Downloads/pic ${HOME}/Pictures/dld
ln -s ${HOME}/Downloads/mov ${HOME}/Movies/dld
ln -s ${HOME}/Downloads/mus ${HOME}/Music/dld
ln -s ${HOME}/DCIM ${HOME}/Pictures/DCIM
ln -s ${HOME}/Camera ${HOME}/Pictures/Camera
# Add user-specific custom symlinks.

cd ~ && touch .hushlogin # Add .hushlogin file to current user's home directory. /?\ Speeds terminal emulator opening up ? (https://news.ycombinator.com/item?id=3879833)

#chflags nohidden ${HOME}/Library # Display the hidden ${HOME}/Library/. (i) This script also enables hidden files display, which overrides this.

#dscl . delete /Users/kvpb Picture
#sudo dscl . create /Users/kvpb Picture "/Users/kvpb/Pictures/usrpic/Kabe.tif"
# Set kvpb's user picture. (i) Cf https://support.apple.com/kb/PH25797?locale=en_US.

cecho 'Third-Party: System-wide & User-specific Xenogenetic Software & Preferences' $yellow

echo 'Homebrew'

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # Download & install Homebrew.

brew tap Homebrew/bundle # Download & install homebrew-bundle.

echo 'iTerm2 (com.googlecode.iterm2)'

defaults write com.googlecode.iterm2 HideFromDockAndAppSwitcher -int 1 # Hide app from Dock [but not its shortcut] and Application Switcher, as done via, as of october 2016 v3.1.2, iTerm->Preferences (Command-Comma)->Appearance [tab]->Exclude from Dock and ⌘-Tab Application Switcher [checkbox]. [Finally what I've been waiting for for terminal emulators and important-to-me-like apps! Whoop-dee-doo!]

defaults write com.googlecode.iterm2 PromptOnQuit -bool FALSE # Hide quit prompt.

echo 'Hyper (co.zeit.hyper, co.zeit.hyper.helper)'

#/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc ${HOME}/.files/lib/scpt/InstallHyper.js # Install Hyper.

ln -s ${HOME}/.files/.hyper.js ${HOME}/.hyper.js # Configure Hyper.

echo 'Jumpcut (net.sf.Jumpcut)'

defaults write net.sf.Jumpcut SUCheckAtStartup -bool TRUE # Check for updated on launch.

defaults write net.sf.Jumpcut "ShortcutRecorder mainHotkey" -array '{keyCode = 9;modifierFlags = 786432;}' # Set Control-Option-V (⌃⌥V) as main hotkey.

defaults write net.sf.Jumpcut bezelAlpha -float 0.2501524448394775 # Set bezel transparency to default.

defaults write net.sf.Jumpcut displayNum -int 10 # Display 10 clippings in menu.

defaults write net.sf.Jumpcut lastRun -int 0.6

defaults write net.sf.Jumpcut loadOnStartup -bool TRUE # Load Jumpcut on startup?

defaults write net.sf.Jumpcut menuIcon -int 0 # Set Jumpcut icon as menu item icon.

defaults write net.sf.Jumpcut menuSelectionPastes -bool TRUE # Menu selection pastes. ('Selecting a clipping from the menu causes it to be pasted instead of copied back onto the pasteboard.')

defaults write net.sf.Jumpcut rememberNum -int 99 # Remember 99 clippings. ('Controls how many clippings Jumpcut stores in its stack'.)

defaults write net.sf.Jumpcut savePreference -int 2 # Save after each clip.

defaults write net.sf.Jumpcut stickyBezel -bool FALSE # No sticky bezel. ('The bezel must be manually dismissed using the "escape" of "return" keys.')

defaults write net.sf.Jumpcut wraparoundBezel -bool TRUE # Wraparoud bezel. ('In the bezel, moving down from the last item takes you to the top and moving up from the first item takes you to the bottom.')

echo 'SizeUp (com.irradiatedsoftware.SizeUp)'

defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool TRUE # Launch SizeUp at login.

defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool FALSE # Hide the preferences window at launch.

echo 'Chrome (com.google.Chrome)'

#defaults write com.apple.LaunchServices LSHandlers -array-add \
#                                                              '{LSHandlerRoleAll=com.google.chrome;LSHandlerURLScheme=http;}'
#                                                              '{LSHandlerRoleAll=com.google.chrome;LSHandlerURLScheme=https;}'
#                                                              '{LSHandlerContentType=public.html;LSHandlerRoleViewer=com.google.chrome;}'
#                                                              '{LSHandlerContentType=public.url;LSHandlerRoleViewer=com.google.chrome;}'
# Set default web browser to Chrome.

defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE # Disable trackpad backswipe gesture.

defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool FALSE # Disable magic mouse backswipe gesture.

defaults write com.google.Chrome DisablePrintPreview -bool TRUE # Disable Chrome print preview dialog. [i] Enables operating system native print preview dialog.

defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool TRUE # Set print preview dialog expanding to expanded.

echo 'Transmission (org.m0k.transmission)'

defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool TRUE
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Transmission"
# Set incomplete downloads path to `${HOME}/Downloads/Transmission`.

#defaults write org.m0k.transmission DeleteOriginalTorrent -bool TRUE # Move original torrent files to trash.

defaults write org.m0k.transmission DownloadAsk -bool FALSE
defaults write org.m0k.transmission MagnetOpenAsk -bool FALSE
# Disable confirmation prompt before downloading.

defaults write org.m0k.transmission WarningDonate -bool FALSE # Hide the donate message.
defaults write org.m0k.transmission WarningLegal -bool FALSE # Hide the legal disclaimer.

defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz" # Enable IP blocking and set IP blocklist to John Tyree's.
defaults write org.m0k.transmission BlocklistAutoUpdate -bool TRUE # Enable IP blocklist autoupdate.

echo 'VMware Fusion 8 (com.vmware.fusion)'

defaults write com.vmware.fusion showStartMenu3 -int 0 # Hide menu bar icon. (i) Set VMware Fusion 8: Preferences: General: Applications menu: Show in menu bar to Never.

echo 'Photoshop Lightroom 6 (com.adobe.Lightroom6)'

defaults write com.adobe.Lightroom6 prefsWindow_currentTab -integer 1

defaults write com.adobe.Lightroom6 AgLibrary_libraryPanel_Enabled -boolean FALSE
defaults write com.adobe.Lightroom6 AgLibrary_collectionsPanel_Enabled -boolean FALSE
defaults write com.adobe.Lightroom6 AgLibrary_publishServicesPanel_Enabled -boolean FALSE
defaults write com.adobe.Lightroom6 AgLibrary_filterBarVisible -boolean FALSE

defaults write com.adobe.Lightroom6 Lightroom_hideAppActivity -boolean YES
defaults write com.adobe.Lightroom6 Lightroom_userIdentityPlateMode -string "app_version"
defaults write com.adobe.Lightroom6 HasClickedOnIdentityPlate -boolean YES

defaults write com.adobe.Lightroom6 ModulePicker_hideModule_com.adobe.ag.layout.book -boolean TRUE
defaults write com.adobe.Lightroom6 ModulePicker_hideModule_com.adobe.ag.location -boolean TRUE
defaults write com.adobe.Lightroom6 ModulePicker_hideModule_com.adobe.ag.print -boolean TRUE
defaults write com.adobe.Lightroom6 ModulePicker_hideModule_com.adobe.ag.slideshow -boolean TRUE
defaults write com.adobe.Lightroom6 ModulePicker_hideModule_com.adobe.ag.wpg -boolean TRUE

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" "Disk Utility" "Dock" "Finder" "iCal" "Mail" "Messages" "Safari" "System Preferences" "SystemUIServer" "TextEdit" "Xcode"; do
	killall "${app}" > /dev/null 2>&1
done
# Kill all affected applications.

echo ''
cecho 'Some changes require a reboot to take effect. Reboot?' $litgreen
cecho "['y', 'yes', 'yeah', 'n', 'no', 'reboot', 'ok' or 'okay'.]" $litgreen
read -r answer
if [[ $answer =~ ^([yY]|[yY][eE][sS]|[yY][eE][aA][hH]|[rR][eE][bB][oO][oO][tT]|[oO][kK]|[oO][kK][aA][yY])$ ]]; then
	killall Terminal
	osascript -e 'tell app "System Events" to restart' # restart without showing a confirmation dialog
else
	cecho 'OS X 10.10.5 Yosemite has been configured.' $lityellow
	exit
fi
