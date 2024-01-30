KEY="mykey"
CHAINID="gm"
MONIKER="localtestnet"
KEYALGO="secp256k1"
KEYRING="test"
LOGLEVEL="info"
# to trace evm
#TRACE="--trace"
TRACE=""
KEY2="validator"
# remove existing daemon
rm -rf ~/.rollkit-ibc*


# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

update_test_genesis () {
  # update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
  cat $HOME/.rollkit-ibc/config/genesis.json | jq "$1" > $HOME/.rollkit-ibc/config/tmp_genesis.json && mv $HOME/.rollkit-ibc/config/tmp_genesis.json $HOME/.rollkit-ibc/config/genesis.json
}

# if $KEY exists it should be deleted
rollkit-ibcd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO
echo "cup pencil conduct depth analyst human trick excite gain copy option arena mix stamp team soon embody jewel erupt advice access prefer negative cost" | rollkit-ibcd keys add $KEY2 --keyring-backend $KEYRING --algo $KEYALGO --recover

# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
rollkit-ibcd init $MONIKER --chain-id $CHAINID 

# Allocate genesis accounts (cosmos formatted addresses)
rollkit-ibcd genesis add-genesis-account $KEY2 100200001000000100stake,100000000000000utest --keyring-backend $KEYRING 
rollkit-ibcd genesis add-genesis-account $KEY 100200001000000000stake --keyring-backend $KEYRING

# Sign genesis transaction
rollkit-ibcd genesis gentx $KEY2 100000001000000000stake --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
rollkit-ibcd genesis collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
rollkit-ibcd genesis validate-genesis

if [[ $1 == "pending" ]]; then
  echo "pending mode is on, please wait for the first block committed."
fi

rollkit-ibcd config chain-id $CHAINID
rollkit-ibcd config keyring-backend $KEYRING

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
rollkit-ibcd start --pruning=nothing  --minimum-gas-prices=0.0001stake --rpc.laddr tcp://127.0.0.1:36657
