# 🚀 Graxo's Dotfiles

This repository contains the configuration files (dotfiles) used to manage user environments across multiple servers.
> Optimized for speed, portability, Zsh (with Powerlevel10k).

Preview:

![screenshot](https://koper.cloud/dotfiles_example.png)
---

## ✨ Features

- ✅ Zsh configured with [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- ✅ Stow-based dotfile management (`bash`, `zsh`, `git`, `nano`, `aliases`)
- ✅ Clean separation of files

---

## 📁 Folder Structure

```
.dotfiles/
├── bash/            → .bashrc, .bash_profile
├── zsh/             → .zshrc, .p10k.zsh (Powerlevel10k theme)
├── git/             → .gitconfig
├── nano/            → .nanorc
├── aliases/         → .aliases
├── install.sh       → Manual install script (non-Ansible systems)
└── README.md
```

---

## ⚙️ Setup Instructions

### 🖥️ Install manually using `install.sh`

```bash
git clone git@github.com:Graxo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

This:
- Installs required packages
- Clones dotfiles and stows them
- Installs Powerlevel10k
- Sets Zsh as default shell

---

## 🖌 Terminal Appearance

Make sure your terminal uses a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) (e.g. `MesloLGS NF`) to properly render Powerlevel10k icons.

---

## 📦 Requirements

- `git`, `zsh`, `stow`, `curl`
---

## 🤝 Contributing

This is a personal environment config repo, but improvements are welcome. Forks and ideas encouraged!

---

## 🧠 Inspiration

- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

---

## 📬 Contact

For questions or suggestions, reach out via GitHub Issues or contact [graxo].
