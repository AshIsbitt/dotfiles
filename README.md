# Dotfiles

This is a bash script that installs the majority of the same things that my 
[ansible playbook](https://github.com/ttibsi/dotfiles-playbook) does as well,
It was designed mostly as a simple project to get some experience with more bash
scripting, and doesn't install everything that the playbook does, only configuring
the GNOME environment. 

There's also the archive branch that holds all my oldest dotfiles from before
I'd started automating them and being more organised.

## To Run
Make sure to update the configs in this repo from the master version in 
ttibsi/dotfiles-playbook first wwith the update-configs script.

Ideally this should be run on a fresh install of PopOS - It's been tested on
PopOS 22.04

```bash
./update-configs.sh
./dotfiles.sh
```
