BASE_DIR=/home/vuong/.rollkit-ibc_fn
AUTH_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJwdWJsaWMiLCJyZWFkIiwid3JpdGUiLCJhZG1pbiJdfQ.6SaLT-vj1W0hHFkh6zzDqtuLBYfSDXX0XCLjWj4058k
NAMESPACE=c6b65c99e475e125
DA_BLOCK_HEIGHT=333
P2P_ID=12D3KooWBcfN4obHukPCU9GPB33sUCiKGbFRb36hXj4Fzmjdk8R3

rollkit-ibcd --home $BASE_DIR start --rollkit.da_layer celestia --rollkit.da_config='{"base_url":"http://localhost:26658","timeout":60000000000,"fee":600000,"gas_limit":6000000,"auth_token":"'$AUTH_TOKEN'"}' --rollkit.namespace_id $NAMESPACE --rollkit.da_start_height $DA_BLOCK_HEIGHT --rpc.laddr tcp://127.0.0.1:46657 --grpc.address 127.0.0.1:9390 --grpc-web.address 127.0.0.1:9391 --p2p.seeds $P2P_ID@127.0.0.1:36656 --p2p.laddr "0.0.0.0:46656" --log_level debugBASE_DIR=/home/vuong/.rollkit-ibc_fn
AUTH_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJwdWJsaWMiLCJyZWFkIiwid3JpdGUiLCJhZG1pbiJdfQ.aK6LIaZbVZ_SOCSc-X2n0WlYQD7CXJYd6iG4BHT9H_M
NAMESPACE=c6b65c99e475e125
DA_BLOCK_HEIGHT=333
P2P_ID=12D3KooWBcfN4obHukPCU9GPB33sUCiKGbFRb36hXj4Fzmjdk8R3
BASE_DIR=/home/vuong/.rollkit-ibc_fn
AUTH_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJwdWJsaWMiLCJyZWFkIiwid3JpdGUiLCJhZG1pbiJdfQ.aK6LIaZbVZ_SOCSc-X2n0WlYQD7CXJYd6iG4BHT9H_M
NAMESPACE=c6b65c99e475e125
DA_BLOCK_HEIGHT=333
P2P_ID=12D3KooWBcfN4obHukPCU9GPB33sUCiKGbFRb36hXj4Fzmjdk8R3
