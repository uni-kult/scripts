set -eufx -o pipefail

git clone --quiet https://github.com/uni-kult/config-reverse-proxy /config
chown -R unikult:unikult  /config

ln -s /config/Caddyfile /etc/caddy/Caddyfile
bash dotfiles/Install.Software/caddy.sh

ufw allow http
ufw allow https
                                                                                                                                            
