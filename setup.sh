#!/bin/bash

if [ ! -f .env ]; then
    echo ".env file not found! Please create it with your session token."
    exit 1
fi

export $(grep -v '^#' .env | xargs)

if [ -z "$SESSION" ]; then
    echo "SESSION variable is not set in the .env file."
    exit 1
fi

CURRENT_YEAR=$(date -u +%Y)
read -p "Enter the Advent of Code year (default: $CURRENT_YEAR): " AOC_YEAR
AOC_YEAR=${AOC_YEAR:-$CURRENT_YEAR}

if [ "$AOC_YEAR" -lt 2015 ] || [ "$AOC_YEAR" -gt "$CURRENT_YEAR" ]; then
    echo "Invalid year. Advent of Code started in 2015 and the current year is $CURRENT_YEAR."
    exit 1
fi

BASE_URL="https://adventofcode.com/$AOC_YEAR/day"
TEMPLATE=$(cat template.cpp)

CURRENT_DAY=$(TZ=America/New_York date +%d | sed 's/^0//')

if [ "$AOC_YEAR" -lt "$CURRENT_YEAR" ]; then
    MAX_DAY=25
else
    MAX_DAY=$CURRENT_DAY
fi

fetch_input() {
    local day=$1
    local input_file=$2
    local input_url=$3
    local retries=5
    local delay=30

    while (( retries > 0 )); do
        echo "Fetching input for day $day..."
        curl -s -o "$input_file" --cookie "session=$SESSION" "$input_url"
        
        if [ -f "$input_file" ] && ! grep -q "500 Internal Server Error" "$input_file"; then
            echo "Successfully fetched input for day $day."
            return 0
        else
            echo "Failed to fetch input for day $day. Retrying in $delay seconds..."
            rm -f "$input_file" 
            sleep $delay
            ((retries--))
        fi
    done

    echo "Failed to fetch input for day $day after multiple attempts."
    return 1
}

for day in $(seq 1 "$MAX_DAY"); do
    echo "Setting up for day $day of $AOC_YEAR..."

    for part in part1 part2; do
        DIR="day${day}/${part}"
        if [ ! -d "$DIR" ]; then
            echo "Creating directory $DIR..."
            mkdir -p "$DIR"
        fi

        SOLUTION_FILE="$DIR/solution.cpp"
        if [ ! -f "$SOLUTION_FILE" ]; then
            echo "Creating $SOLUTION_FILE..."
            echo "$TEMPLATE" > "$SOLUTION_FILE"
        fi
    done

    INPUT_URL="${BASE_URL}/${day}/input"
    INPUT_FILE="day${day}/input.txt"
    if [ ! -f "$INPUT_FILE" ]; then
        fetch_input "$day" "$INPUT_FILE" "$INPUT_URL"
    else
        echo "Input file for day $day already exists."
    fi
done

echo "Setup and fetching complete for all days up to day $MAX_DAY of $AOC_YEAR!"

SCRIPT_PATH=$(realpath "$0")
CRON_JOB="0 5 * * * $SCRIPT_PATH"
(crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH"; echo "$CRON_JOB") | crontab -

echo "Cron job has been set to run daily at midnight New York time (5:00 UTC) for $AOC_YEAR."
