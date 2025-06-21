# 📦 ServMods MC

A simple tool to automatically import your Minecraft server-side mods into the correct folder, hassle-free.

## 🚀 Features

- 📂 **Automatic import** of Minecraft mods into the correct directory (Only from modrinth modpack for now, but it will be improved to work with others later (maybe not curseforge, shitty metadatas)).
- 🛠️ **Compatible with Fabric, Forge, NeoForge...**.

## 🖥️ Installation & run
First clone the repo into your VPS with ;
```bash
git clone https://github.com/GaetanQu/ServModsMC
```
Then run this to make it executable
```bash
chmod +x ServModsMC/ServModsMC.sh
```
Then run the script using :
```bash
sudo ServModsMC/ServModsMC.sh --link [YOUR_MODPACK_LINK] --dir [YOUR_SERVER_DIRECTORY] --user [OFTEN_MINECRAFT]
```

### 📌 Requirements

- A VPS running Ubuntu (maybe it'll work with other distros, test yourself) (or your computer but for now it only works on Ubuntu) and a CLI acces to it
- Some dependencies such as curl, jq and unzip. You can download them by using :
```bash
sudo apt install curl jq unzip
``` 

## 📜 License

This project is licensed under **[GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.fr.html#license-text)**.
This means **you are free to use, modify, and share this program**. 

## 🤝 Contributing

Contributions are welcome!
If you want to improve the project or fix a bug:
- **Fork** the repository
- **Create a branch** (`feature/your-feature`)
- **Submit a Pull Request**

## 📩 Contact

If you have any questions or suggestions, open an issue or contact me on [Discord](#) (Anateg).

