# Nvim config

## Install fonts

This configuration uses a modified version of the Fira Code font
provided by the [nerd font project](https://github.com/ryanoasis/nerd-fonts).

If you using this configuration using iterm2, this font needs to be configuration
for ascii and non-ascii characters (otherwise you'll see weird looking glyphs).

## Usage

### Clone the repo

```sh
mkdir ~/.config/nvim
cd ~/config/nvim
git clone git@github.com:bobylito/nvim-config.git 
```

### Install the plugins

Open nvim and run:

```vim
:PlugInstall
```

This should install all the necessary plugins.

## Thanks

This configuration is based on the blog post from Nerditya:
[a guide to Neovim](http://nerditya.com/code/guide-to-neovim/) which helped
bootstrap the configuration.

Also a special note for [thoughtbot's article](https://robots.thoughtbot.com/my-life-with-neovim)
that gave the confidence to move away from Vim (that it is bad but just that
NeoVim is viable alternative).

This configuration couldn't have been done without the numerous people
having trouble with vim configurations all over internet. Thanks to you
anonymous people asking for help and getting answers :)
