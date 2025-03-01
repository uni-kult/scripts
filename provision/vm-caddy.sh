set -eufx -o pipefail

sudo git clone --quiet https://github.com/uni-kult/config-reverse-proxy /config
sudo chown -R unikult:unikult  /config

bash dotfiles/Install.Software/caddy.sh
sudo mv /etc/caddy/Caddyfile /etc/caddy/Caddyfile.old
sudo ln -s /config/Caddyfile /etc/caddy/Caddyfile
