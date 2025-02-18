set -eufx -o pipefail

# PVE Setup
# ubuntu-24.04.1-live-server-amd64.iso
# minimized
# mirror: http://ubuntu.mirror.lrz.de/ubuntu/
# install ssh, but no other apps


# Initial Commands
# sudo apt-get update
# sudo apt-get install -y git

# ###### sudo apt-get install -y sudo
# ###### sudo usermod -aG sudo unikult
# ###### echo "unikult  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# sudo git clone --quiet https://github.com/uni-kult/scripts /scripts
# sudo chown -R $USER:$USER  /scripts
# sudo bash /scripts/provision/init.sh



export DEBIAN_FRONTEND=noninteractive
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git sudo curl wget zstd mosh

read -p "Enter your username (default: unikult): " username
username=${username:-unikult}

# setup dotfiles
cd /home/$username
sudo -u $username git clone --quiet https://git.sr.ht/~patrickhaussmann/dotfiles
sudo -u $username bash dotfiles/install.sh
bash dotfiles/install.sh
#set +x
#password="$(/home/$username/.bin/password)"
#echo -e "root:${password}\n${username}:${password}" | tee ~/password | chpasswd
#set -x
#echo "" > /etc/motd
rm -f /etc/update-motd.d/00-header /etc/update-motd.d/10-help-text /etc/update-motd.d/60-unminimize
#sudo -u $username touch.hushlogin


cd /home/$username
bash dotfiles/.bin/update
bash dotfiles/Install.Software/locale.sh
bash dotfiles/Install.Software/ufw.sh
bash dotfiles/Install.Software/fail2ban.sh
#bash dotfiles/Install.Software/basic-tools.sh
#bash dotfiles/Install.Software/security-hardening.sh
bash dotfiles/Install.Software/docker.sh
sudo usermod -aG docker $username
#sudo -u $username newgrp docker #apply group information now


mkdir /src
chown -R $username:$username  /src
