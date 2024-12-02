# 🎄 Universal Advent of Code Setup Script

## Overview

This comprehensive script automates the entire setup process for Advent of Code, supporting any year with a robust, flexible approach to preparing your coding environment.

## 🛠 Requirements

- **Supported Platforms**: 
  - Linux
  - macOS
  - Windows (with WSL)

- **Prerequisites**:
  - `curl` installed
  - Advent of Code session token

### Obtaining Session Token

1. Login to Advent of Code (via GitHub or other method)
2. Open browser's developer console (Right-click → Inspect) / Press `F12`
3. Navigate to the Application tab
4. Open Storage > Cookies
5. Locate the session token next to the name `session`

## ✨ Features

- **Flexible Year Support**
  - Dynamically determine current year
  - Manual year specification
  - Automatic cutoff at Day 25 for past years

- **Automated Setup**
  - Creates daily directory structures
  - Fetches problem inputs automatically
  - Uses customizable solution template

## 📦 Installation & Setup

### 1. Clone Repository
```bash
git clone https://github.com/Mithril64/advent-of-code-setup.git
cd advent-of-code-setup
```

### 2. Configure Environment
```bash
cp .env.example .env
```
Replace `your-session-token-here` with your actual Advent of Code session token.

### 3. Make Script Executable
```bash
chmod +x setup.sh
```

### 4. Run Setup
```bash
./setup.sh
```
Follow the interactive prompts to specify the year (or use the current year by default).

## 🗂 Resulting Directory Structure

```
advent-of-code-setup/
│
├── day1/
│   ├── input.txt
│   ├── part1/
│   │   └── solution.cpp
│   └── part2/
│       └── solution.cpp
│
├── day2/
│   ├── input.txt
│   ├── part1/
│   │   └── solution.cpp
│   └── part2/
│       └── solution.cpp
│
├── setup.sh
├── template.cpp
└── .env
```

## 🚀 Additional Notes

- The script uses a `template.cpp` for solution files
- Includes a nightly cron job to set up new days at midnight New York time (5:00 UTC)

## 🤝 Contributing

Feel free to open issues or submit pull requests to improve this setup script!