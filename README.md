# 🚀 graxo's Dotfiles

This repository contains the configuration files (dotfiles) used to manage user environments across multiple servers — with support for automation via Ansible or manual setup using a `install.sh` script.

> Optimized for speed, portability, Zsh (with Powerlevel10k).

---

## ✨ Features

- ✅ Zsh configured with [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- ✅ Stow-based dotfile management (`bash`, `zsh`, `git`, `nano`, `aliases`)
- ✅ Git configuration with identity
- ✅ Hardened SSH client config
- ✅ Clean separation of Ansible-managed vs. manually-installable components

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

### 🖥️ Manual: Install manually using `install.sh`

On systems where Ansible isn’t available, use the manual bootstrap script:

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
- Optionally: Ansible with `community.general`, `community.crypto`

---

## 🤝 Contributing

This is a personal environment config repo, but improvements are welcome. Forks and ideas encouraged!

---

## 🧠 Inspiration

- [Mathias Bynens’ dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) (optional)

---

## 📬 Contact

For questions or suggestions, reach out via GitHub Issues or contact [graxo].
