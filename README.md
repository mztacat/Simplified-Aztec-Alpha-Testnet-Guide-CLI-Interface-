
<img width="1200" height="600" alt="image" src="https://github.com/user-attachments/assets/c561e958-c451-4399-acb1-7c7881930995" />


# To make Installation easier, make sure to Navigate into home directory
### Input password when asked 
```
sudo su
```

```
cd
```

## The new valida


## Update Packages 
```
sudo apt-get update && sudo apt-get upgrade -y
```

## Install Build Essentials 
```
sudo apt install curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev  -y
```


## Install Aztec Tool 
![image](https://github.com/user-attachments/assets/610b5091-e8d5-45ac-9c9d-de26d080196e)

```
bash -i <(curl -s https://install.aztec.network)
```

_____
## Add Aztec to PATH 
![image](https://github.com/user-attachments/assets/be70b89b-e644-4d75-9087-1352cd544ad5)


```
echo 'export PATH="$HOME/.aztec/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Check version 
```
aztec
```

------
### Update version 
```
aztec-up alpha-testnet
```

------------
## Getting RPC {I use Alchemy}
* We need to create a Sepolia Alchemy RPC  --- Visit [here](https://dashboard.alchemy.com/)
* Loigin/Sign Up
* Click on `Create New app` 
![image](https://github.com/user-attachments/assets/f0acf5e7-e561-4d50-9575-beeee41624cd)

* Give a name, Select Ethereum and `Create App`
* Click on `Network` tab and select Sepolia
![image](https://github.com/user-attachments/assets/c2eee62c-ec39-450c-aed8-e2a2eb5deee0)
* Copy the RPC, will be needed soon

-----
### Beacon RPC/L1 Consensus   

* Use:   `https://rpc.drpc.org/eth/sepolia/beacon`
 OR
* Use:    `https://lodestar-sepolia.chainsafe.io` 

----------------

## Check IP 
Take note of IP 
```
curl ipinfo.io/ip
```

-------------
## Getting Sepolia ETH 
* Alchemy Faucet [here](https://www.alchemy.com/faucets/ethereum-sepolia)
* Pow Faucet -- [HERE](https://sepolia-faucet.pk910.de/)
* Google FAUCET -- [HERE](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
------------


## Allow Firewall Access
```
sudo ufw allow ssh
sudo ufw enable

sudo ufw allow 40400
sudo ufw allow 40500
sudo ufw allow 8080
```

## Environmental Variable
Add Coinbase address (EVM address) to COINBASE [e.g COINBASE=0XADDRESS] 
```
export DATA_DIRECTORY=/root/aztec-data/
export COINBASE=
export LOG_LEVEL=debug
export P2P_MAX_TX_POOL_SIZE=1000000000
```

## Open new screen 
```
screen -S aztec
```

-------------------
## Starting NODE 
```
aztec start \
  --network <network-name> \
  --l1-rpc-urls "<rpc-url>" \
  --l1-consensus-host-urls "<consensus-url>" \
  --sequencer.validatorPrivateKey "<private-key>" \
  --p2p.p2pIp "<local-ip>" \
  --p2p.maxTxPoolSize 1000000000 
  --archiver \
  --node \
  --sequencer
```
--------------
![image](https://github.com/user-attachments/assets/8a14e1d2-0712-4931-9ba4-e2c4e3f2a87c)


### Placeholders for command 
+ network-name: `alpha-testnet`
+ rpc-url: `https://eth-sepolia.g.alchemy.com/v2/your-key`
+ consensus-url: `https://lodestar-sepolia.chainsafe.io`
+ private-key: `your private key` (keep it secure)
+ local-ip: use `curl ifconfig.me` to find your local IP

------------

#  Getting Apprentice Role on Discord

Make sure the Node is Synced to the tip - [Confirm from here](https://aztecscan.xyz/)
![image](https://github.com/user-attachments/assets/cea509d2-d0fe-4345-a32b-a9d18da4a3cb)
and compare with the Node

![image](https://github.com/user-attachments/assets/19b73911-3855-4795-baa8-8a2bf643e463)


+ Open a new Ubuntu screen (Make sure the Node is already running). Remember `sudo su` and `cd` to navigate to the root folder
    * Use the below command
  
 ```
curl -s -X POST -H 'Content-Type: application/json' \
-d '{"jsonrpc":"2.0","method":"node_getL2Tips","params":[],"id":67}' \
http://localhost:8080 | jq -r ".result.proven.number"
```

* Save the output number [e.g 20500]
* Generate proof with below command 

    
```
curl -s -X POST -H 'Content-Type: application/json' \
-d '{"jsonrpc":"2.0","method":"node_getArchiveSiblingPath","params":["BLOCK_NUMBER","BLOCK_NUMBER"],"id":67}' \
http://localhost:8080 | jq -r ".result"
 ```

 * Replace both `BLOCK_NUMBER` in code with the output and run the command again
 * Copy the Proof generated, goto `#Operator | start here` channel
 * Type `/Operator start

   ![image](https://github.com/user-attachments/assets/b6479b17-b94f-4914-9320-66d6b0afd0e5)


https://github.com/user-attachments/assets/7359be63-62bb-4951-8624-7175bd2a2bf0

  * Visit the [Discord channel](https://discord.com/channels/1144692727120937080/1367196595866828982)
  * Follow the Video guide
  * Start the `Operator` with the `/operator start` then select follow the video guide


--------

# Update on Aztec: Alpha Testnet .8
 This update **requires a database reset and full re-sync.**  
 Restart ASAP to avoid missing **attestations** or **block proposals.**


Press `CTRL + C`  to stop  Node 
![image](https://github.com/user-attachments/assets/379683c8-013a-445d-ae89-9792ce354e01)


### Delete Database
```
rm -rf ~/.aztec/alpha-testnet/data/ 
```

### Update NODE

```
aztec-up alpha-testnet
```
![image](https://github.com/user-attachments/assets/cebd314a-d045-404a-a0c3-548e594187e4)



RESTART VALIDATOR WITH COMMAND
```
aztec start \
  --network <network-name> \
  --l1-rpc-urls "<rpc-url>" \
  --l1-consensus-host-urls "<consensus-url>" \
  --sequencer.validatorPrivateKeys "<private-key>" \
  --p2p.p2pIp "<local-ip>" \
  --p2p.maxTxPoolSize 1000000000 
  --archiver \
  --node \
  --sequencer
```
------
# Enable Governance Voting (Aztec Public Testnet) 
### If you’re running a sequencer on Aztec’s Public Testnet, you must participate in governance votes to help pass proposals. Proposals only pass if the majority of active block proposers (sequencers) vote in favor.

* Add Governance Payload
## OPTION 1: Using CLI Flag 
Add the following to Aztec command flag 
```
--sequencer.governanceProposerPayload 0x54F7fe24E349993b363A5Fa1bccdAe2589D5E5Ef
```
![image](https://github.com/user-attachments/assets/90c187ea-d364-486b-9bd4-b19505db51f5)

`e.g` 
```
aztec start \
  --network alpha-testnet \
  --l1-rpc-urls " " \
  --l1-consensus-host-urls " " \
  --sequencer.validatorPrivateKeys "      " \
  --p2p.p2pIp "      " \
  --archiver \
  --node \
  --sequencer
```


## Option B - Using Environmental Variable
  ### If you’re using a .env file or environment config: 

  Use command each time you start a new session (Temporary)
```
export GOVERNANCE_PROPOSER_PAYLOAD_ADDRESS=0x54F7fe24E349993b363A5Fa1bccdAe2589D5E5Ef
```

### Or add to config file using the `.bashrc file ` 

```
nano ~/.bashrc
```

### Add the following line at the end of the file:
 
```
export GOVERNANCE_PROPOSER_PAYLOAD_ADDRESS=0x54F7fe24E349993b363A5Fa1bccdAe2589D5E5Ef
```

### Reload `.bashrc` file to apply change 

```
source ~/.bashrc
```



---------------
# Troubleshooting Issues Discovered 



### You’re getting a TypeError: fetch failed → ConnectTimeoutError, which means the Aztec node can’t reach external resources (likely the L1 RPC or bootnode URLs).
![image](https://github.com/user-attachments/assets/0ae5dbdb-da0c-49fa-9299-d8cf0d964b55)


* Enable UFW

```
sudo ufw enable
```

* Allow Outbound connections

```
sudo ufw default allow outgoing
sudo ufw default allow incoming
```

* Readd and reload

```
sudo ufw allow 22/tcp      
sudo ufw allow 8080/tcp     
sudo ufw allow 40400/tcp   
sudo ufw allow 40400/udp
sudo ufw allow 40500/tcp 
```

```
sudo ufw reload
sudo ufw status verbose
```

## Now start Node again 

-----
-----

## Docker not Installed
![image](https://github.com/user-attachments/assets/af616462-cb49-4b09-9642-dfe41bbc6cbe)

```
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

### Add Docker Key 
```
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### Set up Docker REPO

```
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```


### Update and Ins.tall Docker

```
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Verify Installation 

```
docker --version
```

-----------


### Please follow the appropriate steps based on how you’ve set up your validator.

 * Stop Aztec Node with `CTRL + C`
<img width="2472" height="236" alt="image" src="https://github.com/user-attachments/assets/8faa0a72-bde3-4bc0-8b11-81866c9d01c5" />


 * Upgrade to v1.1.0
```
aztec-up 1.1.0
```

* Clear Data and Worldstate
```
rm -rf /tmp/aztec-world-state-*
rm -rf ~/.aztec/alpha-testnet/data
```
<img width="2634" height="1020" alt="image" src="https://github.com/user-attachments/assets/02aa71fa-f7cd-4755-9b1f-6e047cbf8439" />

 * Update your startup command:
   + Replace --sequencer.validatorPrivateKey ➡️=>>> with `--sequencer.validatorPrivateKeys` (note the plural)
   + Provide a comma-separated list of private keys to run multiple validators (eg: upto 10).
     
 * (Optional) Set a --sequencer.publisherPrivateKey
   + This address will post transactions.
   + Only this address needs to be funded with Sepolia ETH if you’re running multiple validators.


-------
# Aztec Update: v2.0.4 (Sequencer / Validator Stability Patch)
This update moves your node onto the latest public testnet runtime (2.x series).  
It is REQUIRED if you still want to:
- stay in the active validator / proposer set
- keep submitting attestations / block proposals
- avoid forking yourself on an old state


* Upgrade Aztec to V2.0.4
### 1. Stop the Node

If you're running in `screen`:
```
screen -ls
screen -r aztec
```
# then press CTRL + C inside that session


### Upgrade Aztec CLI / Binary to v2.0.4
```
aztec-up latest 
```

<img width="3692" height="1272" alt="image" src="https://github.com/user-attachments/assets/518bebcc-c2a4-46a3-9b1b-ee22fbaf21c6" />

### Please update `--network alpha-testnet` to `--network testnet` .


### Governance Voting (Make it permanent)
```
nano ~/.bashrc
```
Add this line at the end 

```
export GOVERNANCE_PROPOSER_PAYLOAD_ADDRESS=0xDCd9DdeAbEF70108cE02576df1eB333c4244C666
```
## CTRL X + Y and click the ENTER

### Then Reload 
```
source ~/.bashrc
```


## Start Aztec with the command (e.g) 
```
aztec start \
  --network testnet \
  --l1-rpc-urls " " \
  --l1-consensus-host-urls " " \
  --sequencer.validatorPrivateKeys "      " \
  --p2p.p2pIp "      " \
  --archiver \
  --node \
  --sequencer
```
<img width="4020" height="768" alt="image" src="https://github.com/user-attachments/assets/99d4555f-8c93-4653-ae10-eb99f4ac1cc4" />

--------

# Migrating Aztec to `V. 2.1.2
## Make sure Aztec is already installed on server `aztec --v` or use the Install command 

```
bash -i <(curl -s https://install.aztec.network)
```

```
echo 'export PATH="$HOME/.aztec/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```


### Install Foundry 

```
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc 2>/dev/null || source ~/.profile 2>/dev/null || true
foundryup
```
<img width="2020" height="428" alt="image" src="https://github.com/user-attachments/assets/b62e0981-4480-433e-80c4-969a329f5b7a" />


### check if properly installed 
```
cast --version
```
<img width="3920" height="1380" alt="image" src="https://github.com/user-attachments/assets/edafe6f6-818e-4cf8-8007-4a4c8c4a5946" />


### Install jQ 
```
sudo apt update && sudo apt install jq -y
```

### Using this script to [Generate New Key and BLS](https://docs.aztec.network/the_aztec_network/operation/keystore/creating_keystores)

Create abd run script
```
nano setup.sh 
```

# Paste in script; 

```
#!/bin/bash

clear
echo "──────────────────────────────────────────────"
echo "     AZTEC 2.1.2 TESTNET — VALIDATOR SETUP"
echo "──────────────────────────────────────────────"
echo ""

# --- Collect old validator details ---
echo "Please provide your previous validator information."
read -sp "   Enter your OLD Sequencer Private Key (hidden): " OLD_PRIVATE_KEY && echo
read -p  "   Enter your Sepolia RPC URL (e.g., https://sepolia.infura.io/v3/...): " ETH_RPC
echo ""
echo "Starting setup..."
echo ""

# --- Remove existing keystore (if any) ---
rm -f ~/.aztec/keystore/key1.json 2>/dev/null

echo "Be prepared to write down your new ETH private key, BLS private key, and ETH address."
read -p "   Press [Enter] to generate new keys..."

# --- Generate new validator keys ---
aztec validator-keys new \
  --fee-recipient 0x0000000000000000000000000000000000000000000000000000000000000000 && echo ""

# --- Extract generated key details ---
KEYSTORE_FILE="$HOME/.aztec/keystore/key1.json"
NEW_ETH_PRIVATE_KEY=$(jq -r '.validators[0].attester.eth' "$KEYSTORE_FILE")
NEW_BLS_PRIVATE_KEY=$(jq -r '.validators[0].attester.bls' "$KEYSTORE_FILE")
NEW_PUBLIC_ADDRESS=$(cast wallet address --private-key "$NEW_ETH_PRIVATE_KEY")

echo ""
echo "New keys generated successfully. Please save the following details securely:"
echo "   - ETH Private Key: $NEW_ETH_PRIVATE_KEY"
echo "   - BLS Private Key: $NEW_BLS_PRIVATE_KEY"
echo "   - Public ETH Address: $NEW_PUBLIC_ADDRESS"
echo ""

echo "You must now fund this address with approximately 0.2–0.5 Sepolia ETH for gas fees."
echo "   $NEW_PUBLIC_ADDRESS"
read -p "   After confirming the transaction, press [Enter] to continue..." && echo ""

# --- Approve STAKE token spending ---
echo "Approving 200,000 STAKE for the Aztec rollup contract..."
cast send 0x139d2a7a0881e16332d7D1F8DB383A4507E1Ea7A \
  "approve(address,uint256)" \
  0xebd99ff0ff6677205509ae73f93d0ca52ac85d67 200000ether \
  --private-key "$OLD_PRIVATE_KEY" \
  --rpc-url "$ETH_RPC" && echo ""

# --- Join the Aztec testnet ---
echo "Registering your validator on the Aztec testnet..."
aztec add-l1-validator \
  --l1-rpc-urls "$ETH_RPC" \
  --network testnet \
  --private-key "$OLD_PRIVATE_KEY" \
  --attester "$NEW_PUBLIC_ADDRESS" \
  --withdrawer "$NEW_PUBLIC_ADDRESS" \
  --bls-secret-key "$NEW_BLS_PRIVATE_KEY" \
  --rollup 0xebd99ff0ff6677205509ae73f93d0ca52ac85d67 && echo ""

# --- Completion message ---
echo ""
echo "──────────────────────────────────────────────"
echo "            SETUP COMPLETED SUCCESSFULLY ✅"
echo "──────────────────────────────────────────────"
echo ""
echo "You have successfully joined the new Aztec 2.1.2 testnet."
echo "Next steps:"
echo "   1. Restart your node using your new private key and address."
echo "   2. Monitor logs to confirm your validator is active."
echo ""
```

### Run and make executable 
```
chmod +x setup.sh
./setup.sh
```

<img width="1742" height="508" alt="image" src="https://github.com/user-attachments/assets/02aac28f-5faf-49fe-9a41-305824246a15" />

-----
# ⚙️ The script Key Points and it's use. 
1. **Generate New Keys**  
   - Removes old keystore and creates new ETH + BLS keys.  
   - Saves them to `~/.aztec/keystore/key1.json`.  
   - Extracts and displays your ETH private key, BLS private key, and public ETH address.

2. **Fund the New Address**  
   - Send **0.2–0.5 Sepolia ETH** to your new public address.
   - COnfirm with ENTER 

3. **Approve STAKE Token**  
   - Uses your **old sequencer private key** to approve 200,000 STAKE for the rollup contract.  
   - Required before you can register your validator.

4. **Register the Validator**  
   - Executes `aztec add-l1-validator` to link your new keys on-chain.  
   - Confirms your validator on the new Aztec 2.1.2 testnet.  
   - Afterwards, restart your node using your **new private key and address**.
-----

<img width="3900" height="1932" alt="image" src="https://github.com/user-attachments/assets/87e7547a-46d4-4f45-ae46-e11ba6a628c9" />

-----
### Create a .ENV File
### Remember, from the BLS, PUBLIC ADDRESS you copied, replace them with this 

```
nano ~/.aztec/.env
```

### Replace the info with the previously copied data

```
# ──────────────────────────────────────────────
# AZTEC 2.1.2 TESTNET — EXAMPLE ENV FILE
# ──────────────────────────────────────────────
# This file contains dummy values and structure for configuring
# a native Aztec validator/sequencer node (non-Docker setup).
# Copy this to `.env` and replace the placeholders with your values.
# ──────────────────────────────────────────────

# Old validator private key (the one holding your STAKE tokens)
OLD_PRIVATE_KEY=0xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

# Ethereum Sepolia RPC endpoint (Alchemy, Infura, or custom)
ETH_RPC=https://eth-sepolia.g.alchemy.com/v2/yourAlchemyAPIKeyHere

# ──────────────────────────────────────────────
# NEW VALIDATOR KEYS
# ──────────────────────────────────────────────
# These are generated via `aztec validator-keys new`
# Replace with your actual keys and address
NEW_ETH_PRIVATE_KEY=0xbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
NEW_BLS_PRIVATE_KEY=0xcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
NEW_PUBLIC_ADDRESS=0x1111111111111111111111111111111111111111

# ──────────────────────────────────────────────
# NETWORK + ROLLUP SETTINGS
# ──────────────────────────────────────────────
ROLLUP=0xebd99ff0ff6677205509ae73f93d0ca52ac85d67
NETWORK=testnet
SYNC_MODE=full

# ──────────────────────────────────────────────
# P2P & NODE SETTINGS
# ──────────────────────────────────────────────
# Use your server's public IP (change just the IP)
P2P_IP=123.45.67.89
P2P_PORT=8080
BROKER_PORT=8081

# ──────────────────────────────────────────────
# LOGGING & PERFORMANCE
# ──────────────────────────────────────────────
LOG_LEVEL=info
MAX_TX_POOL_SIZE=1000000000

# ──────────────────────────────────────────────
# OPTIONAL: LOCAL PATHS
# ──────────────────────────────────────────────
# AZTEC_DATA_DIR=/root/.aztec
# AZTEC_KEYSTORE_PATH=$AZTEC_DATA_DIR/keystore/key1.json
```


### Source .env
```
source ~/.aztec/.env
```



## Start with command 

```
aztec start \
  --network $NETWORK \
  --l1-rpc-urls "$ETH_RPC" \
  --l1-consensus-host-urls "$ETH_RPC" \
  --sequencer.validatorPrivateKeys "$NEW_ETH_PRIVATE_KEY" \
  --sequencer.coinbase "$NEW_PUBLIC_ADDRESS" \
  --sequencer.governanceProposerPayload 0xDCd9DdeAbEF70108cE02576df1eB333c4244C666 \
  --sync-mode $SYNC_MODE \
  --p2p.p2pIp "$P2P_IP" \
  --archiver \
  --node \
  --sequencer
```
<img width="3722" height="392" alt="image" src="https://github.com/user-attachments/assets/0516f2da-962e-4d88-8ff1-95bcd117da45" />



# --- LATEST 2.2.1 ENDS HERE ----







## 🔁 Notes: [ DEPRECATED ] 
+ Changed --sequencer.validatorPrivateKey =>>  `--sequencer.validatorPrivateKeys`
+ Even if you’re using one key, it must still be passed as a string (in quotes) for the plural format.
+ You can add more keys by comma separating them:
```
--sequencer.validatorPrivateKeys "0xkey1,0xkey2,..."
```

-----
## For those using Docker command 
###  Option 2: Advanced / Manual Setup (Docker or Binary)

### ✅ Steps:

* Upgrade your Docker image or binary to v1.1.0.
* Update your startup command:
  + Replace --sequencer.validatorPrivateKey ➡️ with `--sequencer.validatorPrivateKeys`
  + Provide a comma-separated list of private keys.
  + (Optional) Set `--sequencer.publisherPrivateKey` for transaction posting. Only this key needs Sepolia ETH.



## If facing Error: [ Error fetching file from Storage] 
The node is tried to grab a snapshot file from Aztec’s snapshot bucket and the file wasn’t there (HTTP 404 = “not found”).
<img width="3768" height="1464" alt="image" src="https://github.com/user-attachments/assets/04b1cdc8-f98f-49d9-aec4-2c268156c2a4" />


### Use the command 
```
aztec start \
  --network testnet \
  --l1-rpc-urls "http://<L1-RPC-IP>:8545" \
  --l1-consensus-host-urls "http://<CONSENSUS-IP>:3500" \
  --sequencer.validatorPrivateKeys "<VALIDATOR_PRIVATE_KEY>" \
  --sequencer.coinbase "<EVM_REWARD_ADDRESS>" \
  --sequencer.governanceProposerPayload 0xDCd9DdeAbEF70108cE02576df1eB333c4244C666 \
  --snapshots-url https://files5.blacknodes.net/Aztec/ \
  --p2p.p2pIp "<PUBLIC_P2P_IP>" \
  --p2p.maxTxPoolSize 1000000000 \
  --archiver \
  --node \
  --sequencer
```

<img width="3696" height="1404" alt="image" src="https://github.com/user-attachments/assets/50ca6956-234c-4ead-b4b9-64bf6a3b313a" />


# BACK ON TRACK!

