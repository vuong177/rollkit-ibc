#!/bin/sh

# set variables for the chain
VALIDATOR_NAME=validator1
CHAIN_ID=gm
KEY_NAME=gm-key
KEY_2_NAME=gm-key-2
CHAINFLAG="--chain-id ${CHAIN_ID}"
TOKEN_AMOUNT="10000000000000000000000000stake"
STAKING_AMOUNT="1000000000stake"

# query the DA Layer start height, in this case we are querying
# our local devnet at port 26657, the RPC. The RPC endpoint is
# to allow users to interact with Celestia's nodes by querying
# the node's state and broadcasting transactions on the Celestia
# network. The default port is 26657.
DA_BLOCK_HEIGHT=$(curl http://0.0.0.0:26657/block | jq -r '.result.block.header.height')

# rollkit logo
cat <<'EOF'

                 :=+++=.                
              -++-    .-++:             
          .=+=.           :++-.         
       -++-                  .=+=: .    
   .=+=:                        -%@@@*  
  +%-                       .=#@@@@@@*  
    -++-                 -*%@@@@@@%+:   
       .=*=.         .=#@@@@@@@%=.      
      -++-.-++:    =*#@@@@@%+:.-++-=-   
  .=+=.       :=+=.-: @@#=.   .-*@@@@%  
  =*=:           .-==+-    :+#@@@@@@%-  
     :++-               -*@@@@@@@#=:    
        =%+=.       .=#@@@@@@@#%:       
     -++:   -++-   *+=@@@@%+:   =#*##-  
  =*=.         :=+=---@*=.   .=*@@@@@%  
  .-+=:            :-:    :+%@@@@@@%+.  
      :=+-             -*@@@@@@@#=.     
         .=+=:     .=#@@@@@@%*-         
             -++-  *=.@@@#+:            
                .====+*-.  

   ______         _  _  _     _  _   
   | ___ \       | || || |   (_)| |  
   | |_/ /  ___  | || || | __ _ | |_ 
   |    /  / _ \ | || || |/ /| || __|
   | |\ \ | (_) || || ||   < | || |_ 
   \_| \_| \___/ |_||_||_|\_\|_| \__|
EOF

# echo variables for the chain
echo -e "\n Your DA_BLOCK_HEIGHT is $DA_BLOCK_HEIGHT \n"


# reset any existing genesis/chain data
rollkit-ibcd tendermint unsafe-reset-all
rm -rf ~/.rollkit-ibc/

# initialize the validator with the chain ID you set
rollkit-ibcd init $VALIDATOR_NAME --chain-id $CHAIN_ID

# add keys for key 1 and key 2 to keyring-backend test
rollkit-ibcd keys add $KEY_NAME --keyring-backend test 
rollkit-ibcd keys add $KEY_2_NAME --keyring-backend test
echo "cup pencil conduct depth analyst human trick excite gain copy option arena mix stamp team soon embody jewel erupt advice access prefer negative cost" | rollkit-ibcd keys add gnad --keyring-backend test --recover

# add these as genesis accounts
rollkit-ibcd genesis add-genesis-account $KEY_NAME $TOKEN_AMOUNT --keyring-backend test
rollkit-ibcd genesis add-genesis-account $KEY_2_NAME $TOKEN_AMOUNT --keyring-backend test
rollkit-ibcd genesis add-genesis-account gnad 1000000000000000000stake --keyring-backend test

# set the staking amounts in the genesis transaction
rollkit-ibcd genesis gentx $KEY_NAME $STAKING_AMOUNT --chain-id $CHAIN_ID --keyring-backend test

# collect genesis transactions
rollkit-ibcd genesis collect-gentxs

# copy centralized sequencer address into genesis.json
# Note: validator and sequencer are used interchangeably here
ADDRESS=$(jq -r '.address' ~/.rollkit-ibc/config/priv_validator_key.json)
PUB_KEY=$(jq -r '.pub_key' ~/.rollkit-ibc/config/priv_validator_key.json)
jq --argjson pubKey "$PUB_KEY" '.consensus["validators"]=[{"address": "'$ADDRESS'", "pub_key": $pubKey, "power": "1000", "name": "Rollkit Sequencer"}]' ~/.rollkit-ibc/config/genesis.json > temp.json && mv temp.json ~/.rollkit-ibc/config/genesis.json

# create a restart-local.sh file to restart the chain later
[ -f restart-local.sh ] && rm restart-local.sh
echo "DA_BLOCK_HEIGHT=$DA_BLOCK_HEIGHT" >> restart-local.sh

echo "rollkit-ibcd start --rollkit.aggregator true --rollkit.da_address=":26650" --rollkit.da_start_height \$DA_BLOCK_HEIGHT --rpc.laddr tcp://127.0.0.1:36657 --p2p.laddr \"0.0.0.0:36656\" --minimum-gas-prices="0.025stake"" >> restart-local.sh

# start the chain
rollkit-ibcd start --rollkit.aggregator true --rollkit.da_address=":26650" --rollkit.da_start_height $DA_BLOCK_HEIGHT --rpc.laddr tcp://127.0.0.1:36657 --p2p.laddr "0.0.0.0:36656" --minimum-gas-prices="0.025stake" --rollkit.block_time=6s 
 