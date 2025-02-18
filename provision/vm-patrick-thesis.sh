set -eufx -o pipefail

read -p "Enter your Tailscale auth key: " authkey
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale set --auto-update
sudo ufw allow in on tailscale0
sudo ufw reload
sudo tailscale up --ssh --authkey "$authkey"
sudo ufw allow from 172.16.81.0/24 to any port ssh
sudo ufw delete allow ssh
sudo ufw delete limit ssh
sudo ufw delete allow mosh
sudo ufw delete allow http
sudo ufw delete allow https



curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server@patrick
sudo -u patrick mkdir -p /home/patrick/.config/code-server/
cd /home/patrick
echo -e "bind-addr: 127.0.0.1:8080\nauth: none\ncert: false" > .config/code-server/config.yaml
sudo chown patrick:patrick .config/code-server/config.yaml

micro -plugin install wc
micro -plugin install runit
micro --plugin install jump
micro --plugin install cheat



sudo -u patrick code-server --install-extension vlanguage.vscode-vlang
sudo -u patrick code-server --install-extension james-yu.latex-workshop
sudo -u patrick code-server --install-extension valentjn.vscode-ltex
sudo -u patrick code-server --install-extension ybaumes.highlight-trailing-white-spaces
sudo -u patrick code-server --install-extension mhutchie.git-graph
sudo -u patrick code-server --install-extension vscode-icons-team.vscode-icons
sudo -u patrick code-server --install-extension ibm.output-colorizer
sudo -u patrick code-server --install-extension gruntfuggly.todo-tree
sudo -u patrick code-server --install-extension alefragnani.Bookmarks

sudo systemctl restart code-server@patrick
sudo tailscale serve --bg 8080


DEBIAN_FRONTEND=noninteractive sudo apt-get install -y perl wget build-essential
wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sudo -u patrick sh
echo 'export PATH="$HOME/bin:$PATH"' >> /home/patrick/.bashrc 
cd /home/patrick
sudo -u patrick /home/patrick/bin/tlmgr install babel-english babel-german german hyphen-german hyphen-english koma-script setspace parskip fancyhdr appendix placeins cite emptypage csquotes microtype csvsimple pgf sidecap mhchem was siunitx caption titlesec floatrow minted upquote lineno oberdiek ulem datetime2 datetime2-german datetime2-english ragged2e latexindent draftwatermark nth


echo "the rest of this script is not working :("
exit 1

read -p "Please enter your private key: " -s private_key
cd /home/patrick
echo "$private_key" | sudo tee .ssh/thesis_ed25519 > /dev/null
sudo chown patrick:patrick -R .ssh/thesis_ed25519
sudo chmod 600 .ssh/thesis_ed25519
sudo ssh-keygen -f .ssh/thesis_ed25519 -y > .ssh/thesis_ed25519.pub

cat <<EOF | sudo tee .ssh/config > /dev/null
Host github.com
    Hostname github.com
    IdentityFile=/home/patrick/.ssh/thesis_ed25519
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF

sudo chown patrick:patrick -R .ssh/
sudo chmod 700 .ssh/

cd /src
sudo -u patrick git clone --quiet git@github.com:PatrickHaussmann/masterthesis.git thesis

