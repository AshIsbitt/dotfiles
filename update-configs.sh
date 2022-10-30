# clone dotfiles-playbook
git clone https://github.com/ttibsi/dotfiles-playbook.git playbook

# delete contents of config
echo "Cleaning current configs dir"
rm -rf configs/*

# copy from dotfiles-playbook/template/ to configs
echo "Moving from playbooks"
mv playbook/templates/firefox configs 
mv playbook/templates/git-config configs 
mv playbook/templates/firefox configs 
mv playbook/templates/nvim configs 
mv playbook/templates/tmux configs 
mv playbook/templates/zsh-shell configs 

# Delete playbook clone
echo "Removing playbook clone"
rm -rf playbook

git add -u configs
git commit -m "Updated configs"

