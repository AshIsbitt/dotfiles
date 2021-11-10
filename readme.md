# Dotfiles

### Description

A combination of all my local dotfiles, featuring setups for Nano (although outdated), Neovim, TMUX, and Oh-My-Zsh. 

This setup is designed for MacOS use - specifically the Tmux prefix-key, which is only accessible easily on a UK keyboard MacBook. These installation instructions should also work on Linux with minor edits (assuming your familiar with your flavour of Linux)

### Installation
First make sure each of the tools listed are installed by running each of the following commands one at a time. 

```

```

If not, run the following to install and update all files. 

```

```

Next, clone this repo to a location of your choice:
```

```

And set up the required symlinks so that the various tools can use files from this repo:
```

```

### Theme and font installation
I use the `chalk` colour scheme and `Droid Sans Mono` nerd font (a font set up for more complex symbols). 

#### Install chalk:
If you are on MacOS, simply double click the attached `chalk.terminal` file and the terminal will launch. Open terminal > preferences > chalk > set to default (on the bottom of the theme window)
Otherwise, if you are on linux, run the following commands (written for ubuntu-based distros)

```
sudo apt-get install dconf-cli uuid-runtime
```
In the runtime, enter theme `6`

This is based off of the installation from [this rep](https://github.com/Mayccoll/Gogh)

#### Add the nerd font:
```
git clone git@github.com:ryanoasis/nerd-fonts.git
cd nerd-fonts/patched-fonts/droid-sans-mono/complete
```

I also prefer to use the PowerLevel10k theme in ZSH, which can be set up to my preferences like so:


