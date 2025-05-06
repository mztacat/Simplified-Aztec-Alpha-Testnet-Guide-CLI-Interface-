# Simplified-Aztec-Alpha-Testnet-Guide-CLI-Interface-



# To make Installation easier, make sure to Navigate into home directory
### Input password when asked 
```
sudo su
```

```
cd
```




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
  --sequencer.validatorPrivateKey "<private-key>" \
  --p2p.p2pIp "<local-ip>" \
  --p2p.maxTxPoolSize 1000000000 
  --archiver \
  --node \
  --sequencer
```


 


