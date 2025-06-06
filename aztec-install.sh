#!/bin/bash

echo "... [MZTACAT AUTO SCRIPT TEST]..."

if [ "$EUID" -ne 0 ]; then
  echo "⚠️  Please run this script as root (use: sudo ./aztec-install.sh)"
  exit 1
fi

echo "Navigating to home directory..."
cd ~

echo "Updating packages..."
apt-get update && apt-get upgrade -y

echo "Installing dependencies..."
apt install -y curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev

echo "Installing Aztec CLI..."
bash -i <(curl -s https://install.aztec.network)

echo "Adding Aztec to PATH..."
echo 'export PATH="$HOME/.aztec/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "Checking Aztec version..."
aztec

echo "Updating Aztec to alpha-testnet..."
aztec-up alpha-testnet

echo "Allowing Firewall Ports..."
ufw allow ssh
ufw allow 40400
ufw allow 40500
ufw allow 8080
ufw enable

echo "Setting up environment variables..."

read -p "Enter your EVM COINBASE address (0x...): " COINBASE
read -p "Enter your private key (for validator): " PRIVATE_KEY
read -p "Enter your local IP (use curl ifconfig.me if unsure): " LOCAL_IP
read -p "Enter your Alchemy Sepolia RPC URL: " RPC_URL
read -p "Enter your Consensus RPC (lodestar-sepolia): " CONSENSUS_URL

echo "export COINBASE=$COINBASE" >> ~/.bashrc
echo "export LOG_LEVEL=debug" >> ~/.bashrc
echo "export P2P_MAX_TX_POOL_SIZE=1000000000" >> ~/.bashrc
echo "export GOVERNANCE_PROPOSER_PAYLOAD_ADDRESS=0x54F7fe24E349993b363A5Fa1bccdAe2589D5E5Ef" >> ~/.bashrc
source ~/.bashrc

echo "Setup complete!"
echo ""
echo "Launching Aztec node..."

aztec start \
  --network alpha-testnet \
  --l1-rpc-urls "$RPC_URL" \
  --l1-consensus-host-urls "$CONSENSUS_URL" \
  --sequencer.validatorPrivateKey "$PRIVATE_KEY" \
  --p2p.p2pIp "$LOCAL_IP" \
  --p2p.maxTxPoolSize 1000000000 \
  --archiver \
  --node \
  --sequencer \
  --sequencer.governanceProposerPayload 0x54F7fe24E349993b363A5Fa1bccdAe2589D5E5Ef
