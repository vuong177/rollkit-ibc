CHAIN_ID=gm
BASE_DIR="$HOME/.rollkit-ibc_fn"

rm -rf $BASE_DIR

rollkit-ibcd --home "$BASE_DIR" init FullNode --chain-id $CHAIN_ID

cp -R "$HOME/.rollkit-ibc/config/genesis.json" "$BASE_DIR/config/genesis.json"

export AUTH_TOKEN=$(docker exec $(docker ps -q)  celestia bridge --node.store /home/celestia/bridge/ auth admin)

DA_BLOCK_HEIGHT=572
NAMESPACE=aeab9d13ea5d5340
P2P_ID="12D3KooWMpy1EMUZq4HoKBih46a4Se36NHor935SNJ7uJ2hV55K6"

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
echo "BASE_DIR=$BASE_DIR" >> restart-full-local.sh
echo "AUTH_TOKEN=$AUTH_TOKEN" >> restart-full-local.sh
echo "NAMESPACE=$NAMESPACE" >> restart-full-local.sh
echo "DA_BLOCK_HEIGHT=$DA_BLOCK_HEIGHT" >> restart-full-local.sh
echo "P2P_ID=$P2P_ID" >> restart-full-local.sh

rollkit-ibcd --home $BASE_DIR start --rollkit.da_layer celestia --rollkit.da_config='{"base_url":"http://localhost:26658","timeout":60000000000,"fee":600000,"gas_limit":6000000,"auth_token":"'$AUTH_TOKEN'"}' --rollkit.namespace_id $NAMESPACE --rollkit.da_start_height $DA_BLOCK_HEIGHT --rpc.laddr tcp://127.0.0.1:46657 --grpc.address 127.0.0.1:9390 --grpc-web.address 127.0.0.1:9391 --p2p.seeds $P2P_ID@127.0.0.1:36656 --p2p.laddr "0.0.0.0:46656" --log_level debug