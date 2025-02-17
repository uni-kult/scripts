set -euf -o pipefail
set -x

# PVE Setup
# ubuntu-24.04.1-live-server-amd64.iso
# minimized
# mirror: http://ubuntu.mirror.lrz.de/ubuntu/
# install ssh, but no other apps


# Initial Commands
# apt-get update
# apt-get install -y git sudo
# git clone --quiet https://github.com/uni-kult/scripts /scripts
# chown -R unikult:unikult  /scripts
# usermod -aG sudo unikult
# echo "unikult  ALL=NOPASSWD: ALL" | tee -a /etc/sudoers
#
# bash /scripts/provision/init.sh



export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get dist-upgrade
DEBIAN_FRONTEND=noninteractive apt-get install -y git sudo curl wget zstd


# setup dotfiles
cd /home/unikult
sudo -u unikult git clone --quiet https://git.sr.ht/~patrickhaussmann/dotfiles
sudo -u unikult bash dotfiles/install.sh
bash dotfiles/install.sh
#set +x
#password="$(/home/unikult/.bin/password)"
#echo -e "root:${password}\nunikult:${password}" | tee ~/password | chpasswd
#set -x
#echo "" > /etc/motd
#rm -f /etc/update-motd.d/10-uname
#sudo -u unikult touch .hushlogin 


cd /home/unikult
bash dotfiles/.bin/update
bash dotfiles/Install.Software/locale.sh
bash dotfiles/Install.Software/ufw.sh
bash dotfiles/Install.Software/fail2ban.sh
#bash dotfiles/Install.Software/basic-tools.sh
#bash dotfiles/Install.Software/security-hardening.sh
bash dotfiles/Install.Software/docker.sh
sudo usermod -aG docker unikult
#sudo -u unikult newgrp docker #apply group information now

mkdir /src
chown -R unikult:unikult  /src
