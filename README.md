# Universal Advent of Code Setup Script

This script automates the setup for Advent of Code for any year by:
- Creating directories for each day (e.g., `day1/part1`, `day1/part2`).
- Fetching inputs for each day from the Advent of Code website.
- Adding a daily cron job to set up new days at midnight New York time (5:00 UTC).

## Requirements

- **Linux/macOS** (or Windows with WSL).
- `curl` installed.  
- Advent of Code session token.  
    1 - Login on AoC with github or whatever  
    2 - Open browser's developer console (e.g. right click --> Inspect) and navigate to the Network tab  
    3 - GET any input page, say adventofcode.com/2016/day/1/input, and look in the request headers.  

## Features

- **Supports Any Year**: Dynamically determines the year or lets you specify one.
- **Handles Current and Past Years**: Automatically stops at Day 25 for past years.
- **Customizable Template**: Uses a `template.cpp` file for solutions.

## Setup Instructions

1. Clone the repository:  
   ```bash
   git clone https://github.com/your-username/advent-of-code-setup.git
   cd advent-of-code-setup
   ```  
2. Copy the `.env.example` file to `.env` and add your session token:  
    ```bash
    cp .env.example .env
    ```  
Replace `your-session-token-here` with your `aoc` token.  
3. Make the setup script executable:  
    ```bash
    chmod +x setup.sh
    ```  
4. Run the setup script:  
    ```bash
    ./setup.sh
    ```  
You will be prompted to specify the year or use the current year.  


## Example Directory Structure
After running the script, your directory will look like this:  
```bash  
    advent-of-code-setup
    ├── day1
    │   ├── input.txt
    │   ├── part1
    │   │   └── solution.cpp
    │   └── part2
    │       └── solution.cpp
    ├── day2
    │   ├── input.txt
    │   ├── part1
    │   │   └── solution.cpp
    │   └── part2
    │       └── solution.cpp
    ├── setup.sh
    ├── template.cpp
    └── .env
```