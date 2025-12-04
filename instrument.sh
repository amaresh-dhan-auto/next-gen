#!/bin/bash


# Start time
START_TIME_EPOCH=$(date +%s)
START_TIME_FMT=$(date +"%d-%m-%Y %I:%M:%S %p")


# Download api-scrip-master.csv
URL="https://images.dhan.co/api-data/api-scrip-master.csv"
OUTPUT_FILE="api-scrip-master.csv"


echo "Downloading $URL ..."
curl -o "$OUTPUT_FILE" "$URL"


if [ $? -eq 0 ]; then
echo "Download completed successfully: $OUTPUT_FILE"
else
echo "Download failed!"
exit 1
fi


# End time
END_TIME_EPOCH=$(date +%s)
END_TIME_FMT=$(date +"%d-%m-%Y %I:%M:%S %p")
RUNTIME=$((END_TIME_EPOCH - START_TIME_EPOCH))
echo "Script started at: $START_TIME_FMT"
echo "Script ended at : $END_TIME_FMT"
echo "Total execution time: ${RUNTIME} seconds"