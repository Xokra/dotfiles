# ZedOcean's Dotfiles

Cross-platform dotfiles with automated preboot backup and postboot setup for WSL, macOS, and Arch Linux (i3).

---

## PREBOOT: Before Leaving Your Old System

Copy and paste these commands on your current system:

### 1. Backup Everything

```bash
cd ~/dotfiles
./cross-platform-inventory.sh
```

### 2. Push Backups and Dotfiles

```bash
git add .
git commit -m "System backup: $(date)"
git push origin main
```

**✅ PREBOOT COMPLETE**

---

## POSTBOOT: Fresh System Setup

### One Command Setup

Copy and paste this on your brand new system:

```bash
curl -fsSL https://raw.githubusercontent.com/Xokra/dotfiles/main/.local/bin/cross-platform-master-backup.sh | bash
```

### Configure Git (Only Manual Step)

```bash

git config --global user.name "Your Name"

git config --global user.email "your_email@example.com"
```

**✅ POSTBOOT COMPLETE**

---

## Manual Setup (If Automated Fails)

### WSL Setup

```powershell
# Windows PowerShell (Run as Administrator)
winget install --id Google.Chrome; winget install --id Mozilla.Firefox; winget install --id Brave.Brave; winget install --id Spotify.Spotify; winget install --id GIMP.GIMP; Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L/DZ/Regular/MesloLGLDZNerdFont-Regular.ttf" -OutFile "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\MesloLGLDZNerdFont-Regular.ttf"; dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart; dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

```powershell
# After restart
wsl --set-default-version 2

```

```bash
# Inside WSL
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install git wget curl stow -y
```

### macOS Setup

```bash
# Terminal
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && brew update && brew upgrade && brew install git wget curl stow alacritty --cask google-chrome font-meslo-lg-nerd-font firefox brave-browser spotify

```

### Arch Linux Setup

```bash

# Terminal
sudo pacman -Syu git wget curl stow alacritty --noconfirm
```

```bash
# Install AUR helper
sudo pacman -S --needed base-devel git --noconfirm
git clone https://aur.archlinux.org/yay.git

cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay
```

```bash
# Install all applications (same as other platforms)
yay -S google-chrome firefox brave-bin spotify gimp nerd-fonts-meslo-lg --noconfirm
```

### SSH Key Setup (All Platforms)

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

```bash
# macOS only
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

```bash
# Display public key
cat ~/.ssh/id_ed25519.pub

```

**Copy the output and add to GitHub:**

1. Go to https://github.com/settings/keys

2. Click "New SSH key"

3. Paste the key
4. Click "Add SSH key"

### Manual Dotfiles Setup

```bash
mkdir ~/dotfiles
cd ~/dotfiles

git clone git@github.com:Xokra/dotfiles.git .
chmod +x .local/bin/*
./cross-platform-setup-dotfiles.sh
```

### Final Steps

```bash
source ~/.zshrc
```
