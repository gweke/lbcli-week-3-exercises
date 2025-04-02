# Create a native segwit address and get the public key from the address.
wallet_name="btrustwallet"

SEGWIT_ADDR=$(bitcoin-cli -regtest -rpcwallet=$wallet_name getnewaddress "" "bech32")
#echo "- SegWit digital safe: $SEGWIT_ADDR"

ADDR_INFO=$(bitcoin-cli -regtest -rpcwallet=$wallet_name getaddressinfo $SEGWIT_ADDR)
#echo "The segwit address : $SEGWIT_ADDR information is:"
#echo $ADDR_INFO | jq '.'

pubkey=$(echo $ADDR_INFO | jq -r '.pubkey')

# Or we use this method
#desc=$(echo $ADDR_INFO | jq -r '.desc')
#echo "the descriptor is : $desc"
#pubkey=$(echo "$desc" | grep -oP '\[[^]]+\]\K[^#)]+')

echo $pubkey

