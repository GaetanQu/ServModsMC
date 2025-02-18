#!/bin/bash

handle_modrinth() {

    # Download mods from the modrinth.index.json file
    jq -r '.files[] | select(.path | startswith("mods/")) | .downloads[0]' "temp_folder/temp_modpack_folder/modrinth.index.json" | while read -r downloadUrl; do

        file_name=$(basename "$downloadUrl")

        echo -ne "🔍 Checking if $file_name is a server-side mod...\r"
        
        # Check if the mod is server side with modrinth API.
        # IT COULD BE DIFFERENT IF MOD DEVELOPPERS DID FILL THE fabric.mod.json PROPERLY. IF YOUR MODPACK ISN'T MEANT TO BE RAN INTO A SERVER, THE ENV SECTION SHOULD BE "client", NOT "*"

        # - First, find the project id into the download link in the modrinth.index.json file
        project_id=$(echo "$downloadUrl" | sed -E 's|https://cdn.modrinth.com/data/([^/]+)/.*|\1|')

        # - Then ask the API for its json of the mod
        response=$(curl -s "https://api.modrinth.com/v2/project/$project_id")

        # - That's where I find the "server_side" key and its calue, either "required", "optionnal" or "unsupported"
        server_side=$(echo "$response" | jq -r '.server_side')

        # - If it is a server-side mod, then we download it using the download link
        if [[ $server_side == "required" || $server_side == "optional" ]]; then
            echo -ne "📥 Downloading $file_name...\r"
            # Sometimes it works
            if curl -s -L "$downloadUrl" -o "temp_folder/mods/$file_name"; then
                echo "✅ $file_name is server-side ! It has been downloaded" 
            # Sometimes it doesn't
            else
                echo "❌ $file_name couldn't be downloaded, check if your mod pack is up to date"
            fi
        # Ignore the client site mods
        else
            echo "⏩ $file_name is a client-side mod. Ignored"
        fi        
    done
}