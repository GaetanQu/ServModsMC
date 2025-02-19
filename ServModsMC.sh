#!/bin/bash 

source "$(dirname "$0")/partials/modrinth.sh"

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --link|-l) 
            modpack_url="$2"
            shift 2
            ;;
        --dir|-d)
            server_dir="$2"
            shift 2
            ;;
        *)
            echo "❌ Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check that the arguments are set
if [[ -z "$modpack_url" || -z "$server_dir" ]]; then
    echo "❌ Arguments modpack_url (--link or -l) and server_dir (--dir or -d) must be set."
    exit 1
fi

# Check that the server folder is properly set
if ! ls "$server_dir"/*.jar &>/dev/null; then
    echo "❌ The server folder seems not to be properly set, no jar file found. Aborting.."
    exit 1
fi

# Create a temp folder for the full modpack
mkdir -p temp_folder/mods

# Download and unzip the modpack from the given link
echo -ne "📥 Downloading modpack...\r"
curl -L -s "$modpack_url" -o "temp_folder/temp_modpack.zip"
echo "📥 Modpack downloaded !"
echo -ne "🗜️ Extracting modpack...\r"
unzip -q "temp_folder/temp_modpack.zip" -d "temp_folder/temp_modpack_folder"
echo "🗜️ Modpack Extracted !"

# Test from which app the modpack has been downloaded
if [[ -f "temp_folder/temp_modpack_folder/modrinth.index.json" ]]; then # Modrinth folders contain a modrinth.index.json file, which is useful to determine if it's a modrinth modpack
    echo "🟢 Found Modrinth modpack."
    # Call the partials/modrinth.sh file
    handle_modrinth
elif [[ -f "temp_folder/temp_modpack_folder/manifest.json" ]]; then
    echo "🟠 Found CurseForge modpack."
    #curseforge, later
else
    echo "No platform found"
fi

# Delete the previous mod folder, avoiding duplicatas
if [[ -d "$server_dir/mods" ]]; then
rm -r "$server_dir/mods"
fi

# Move the mods to the right folder
mv "temp_folder/mods/" "$server_dir/mods"
echo "✅ Modpack successfully installed in $server_dir/mods !!!"

# Clean the mess
rm -r ./temp_folder

## That's it ! You can now run your server !