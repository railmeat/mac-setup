# mac-setup

This is setup instructions, scripts and configuration files for MacOS. It was last used on a new M1 MacBook Air with Big Sur.

I stand on the shoulders of giants.

1. Walk through Apples first use dialogs
> 1. Select English, then United State
> 1. Do not select any assistance 
> 1. Log into WiFi
> 1. "Continue" on data and privacy
> 1. Select not to transfer any information from other Macs or PCs. I will do it latter if needed.
> 1. Sign in with Apple ID. If it is an existing account a verification number will be sent to any other Apple device you have, so have that handy.
> 1. Create computer account. 
> 1. Don't use iCloud Keychain.
> 1. Accept "Find My," you don't have a choice
> 1. Choose the express settings.
> 1. Share crash and usage data with developers, I am nice that way.
> 1. "Set Up Later" for Screen Time. Where do I disable this?
> 1. Disable ask Siri.
> 1. Turn on FileVault and allow my iCloud account to unlock my disk.
> 1. Setup touch id
> 1. Set up Apple Pay.
> 1. Select "Light" on "Choose Your Look"
> 1. Select True Tone Display.
2. Allow Calendar to see location.
1. In finder select Go / Utilities and open a terminal, then:
> 1. xcode-select --install then click the appropriate buttons.
> 1. Prempetivly install rosseta 2: sudo softwareupdate --install-rosetta --agree-to-license
1. Down load the scripts from <https://github.com/railmeat/mac-setup>
> 1. Unzip them and change to the directory where they were unzipped.
> 1. Run ./setup-macos.sh and see what happens
> 1. Run ./config-macos.sh it will close a lot of applications.
> 1. Install Microsoft Office: account.microsoft.com
> 1. Install any software updates: sudo softwareupdate --install --all --agree-to-license
1. Restart and see what you have.
1. Enjoy
