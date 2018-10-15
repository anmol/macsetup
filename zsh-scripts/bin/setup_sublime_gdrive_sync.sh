#!/bin/sh
#Drive location/Can be Google Drive or Dropbox sync location
GDRIVE="$HOME/Google Drive"
#Sync destination: where to sync settings"
SYNC_FOLDER="${GDRIVE}/SublimeText"

if [ `uname` = "Darwin" ];then
    SOURCE="$HOME/Library/Application Support/Sublime Text 3"
else
    echo "OS not supported"
    exit -1
fi

# Check that settings really exist on this computer
if [ ! -e "$SOURCE/Packages/" ]; then
        echo "Could not find $SOURCE/Settings/"
        exit -1
fi

# Avoid syncing again
if [ -L "$SOURCE/Packages" ] ; then
        echo "settings already symlinked"
        exit -1
fi

# Sync ONLY if SublimeText has not been synced to GoogleDrive before
if [ ! -e "$SYNC_FOLDER" ] ; then
        echo "Setting up sync folder"
        
        # Creating the folders in separated categories
        mkdir -p "$SYNC_FOLDER/Installed Packages"
        mkdir -p "$SYNC_FOLDER/Packages"
        
        # Copy the files into their respective folder
        cp -r "$SOURCE/Installed Packages/" "$SYNC_FOLDER/Installed Packages"
        cp -r "$SOURCE/Packages/" "$SYNC_FOLDER/Packages"
fi

# Now when settings are in Drive delete existing files
rm -rf "$SOURCE/Installed Packages"
rm -rf "$SOURCE/Packages"

# Symlink settings folders from GDrive
ln -s "$SYNC_FOLDER/Installed Packages" "$SOURCE/Installed Packages"
ln -s "$SYNC_FOLDER/Packages" "$SOURCE/Packages"

