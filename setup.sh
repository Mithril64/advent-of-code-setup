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

CURRENT_DAY=$(date -u --date="TZ=\"America/New_York\" now" +%d | sed 's/^0//')

if [ "$AOC_YEAR" -lt "$CURRENT_YEAR" ]; then
    MAX_DAY=25
else
    MAX_DAY=$CURRENT_DAY
fi

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
        echo "Fetching input for day $day..."
        curl -o "$INPUT_FILE" --cookie "session=$SESSION" "$INPUT_URL"
    else
        echo "Input file for day $day already exists."
    fi
done

echo "Setup and fetching complete for all days up to day $MAX_DAY of $AOC_YEAR!"

SCRIPT_PATH=$(realpath "$0")
CRON_JOB="0 5 * * * $SCRIPT_PATH"
(crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH"; echo "$CRON_JOB") | crontab -

echo "Cron job has been set to run daily at midnight New York time (5:00 UTC) for $AOC_YEAR."
