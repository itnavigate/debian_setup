COMPOSE_VERSION=2.29.0

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

lsb_release_is=`lsb_release -is | tr '[:upper:]' '[:lower:]'`
curl -fsSL https://download.docker.com/linux/${lsb_release_is}/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$lsb_release_is $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

# apt-cache policy docker-ce

sudo apt install -y docker-ce

sudo systemctl status docker

sudo usermod -aG docker ${USER}

mkdir -p ~/.docker/cli-plugins/

curl -SL https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

docker compose version
#Now logout, then back in to run without sudo
