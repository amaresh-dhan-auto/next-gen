#!/bin/bash
fi


STRIKE=$1
TYPE=$2
PRICE=$3


case "$TYPE" in
CE) OPT_TYPE="CALL" ;;
PE) OPT_TYPE="PUT" ;;
*) echo "Invalid type: use CE or PE"; exit 1 ;;
esac


SEARCH_STRING="$OPTION_TEMPLATE $STRIKE $OPT_TYPE"
echo "Searching for option: $SEARCH_STRING"


SECURITY_ID=$(grep -F "$SEARCH_STRING" "$FILE" | cut -d',' -f3)
if [ -z "$SECURITY_ID" ]; then
echo "Error: Could not find securityId for '$SEARCH_STRING' in $FILE"
exit 1
fi


echo "Found securityId: $SECURITY_ID"


TARGET_PRICE=$((PRICE + 8))
STOPLOSS_PRICE=$((PRICE - 5))


CORRELATION_ID=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c $((RANDOM % 31)))


read -r -d '' PAYLOAD <<EOF
{
"dhanClientId": "$DHAN_CLIENT_ID",
"correlationId": "$CORRELATION_ID",
"transactionType": "BUY",
"exchangeSegment": "NSE_FNO",
"productType": "INTRADAY",
"orderType": "LIMIT",
"securityId": "$SECURITY_ID",
"quantity": 100,
"price": $PRICE,
"targetPrice": $TARGET_PRICE,
"stopLossPrice": $STOPLOSS_PRICE,
"trailingJump": 0
}
EOF


RESPONSE=$(curl --silent --show-error --request POST \
--url "https://api.dhan.co/v2/super/orders" \
--header "Content-Type: application/json" \
--header "access-token: $ACCESS_TOKEN" \
--data "$PAYLOAD")


END_TIME_EPOCH=$(date +%s)
END_TIME_FMT=$(date +"%d-%m-%Y %I:%M:%S %p")
RUNTIME=$((END_TIME_EPOCH - START_TIME_EPOCH))


echo "Script started at: $START_TIME_FMT"
echo "Script ended at : $END_TIME_FMT"
echo "Total execution time: ${RUNTIME} seconds"


echo "---- REQUEST PAYLOAD ----"
echo "$PAYLOAD" | jq .
echo "--------- RESPONSE ------"
echo "$RESPONSE" | jq .