# Create a partially signed transaction from the details below

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

RAW_TX="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"
PAYMENT_ADDRESS="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
amount_to_send=20000000

DECODE_TX=$(bitcoin-cli -regtest decoderawtransaction $RAW_TX)
#echo $DECODE_TX | jq '.'

TXID=$(echo $DECODE_TX | jq -r '.txid')
VOUT_INDEX_1=$(echo $DECODE_TX | jq -r '.vout[0].n')
VOUT_INDEX_2=$(echo $DECODE_TX | jq -r '.vout[1].n')

amount_to_send_btc=$(printf "%.8f" "$(bc -l <<< "scale=8; $amount_to_send / 100000000")")


TX_INPUTS="[{\"txid\": \"$TXID\", \"vout\": $VOUT_INDEX_1}, {\"txid\": \"$TXID\", \"vout\": $VOUT_INDEX_2}]"
TX_OUTPUTS="{\"$PAYMENT_ADDRESS\": $amount_to_send_btc}"

psbt=$(bitcoin-cli -regtest createpsbt "$TX_INPUTS" "$TX_OUTPUTS")
echo $psbt