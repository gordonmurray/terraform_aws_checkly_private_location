#!/bin/bash
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release redis -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker ubuntu
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
# Run Checkly agent
sudo docker run -e API_KEY="${private_location_key}" -d ghcr.io/checkly/agent:latest
# Install Goss
sudo curl -L https://github.com/goss-org/goss/releases/latest/download/goss-linux-amd64 -o /usr/local/bin/goss
sudo chmod +rx /usr/local/bin/goss
# Goss yaml file
cat <<EOT >> /home/ubuntu/goss.yaml
command:
  rds:
    exec: mysql -h ${rds_host} -u ${rds_username} -p${rds_password} -N -e "select 1;"
    exit-status: 0
    stdout:
    - 1
    stderr: []
    timeout: 10000
  redis:
    exec: redis-cli -h ${redis_host} -r 1 ping
    exit-status: 0
    stdout:
    - PONG
    stderr: []s
    timeout: 10000
EOT
# Start Goss server
goss serve --format json &