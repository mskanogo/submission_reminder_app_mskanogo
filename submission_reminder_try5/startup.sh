#!/usr/bin/bash
# startup.sh — Starts the Submission Reminder App

# Get current script directory
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$SCRIPT_DIR" || {
    echo "Error: Unable to access main directory!"
    exit 1
}

# Make sure all .sh files are executable
chmod +x app/*.sh modules/*.sh 2>/dev/null

echo "========================================"
echo "     Starting Submission Reminder App"
echo "========================================"

# Run the reminder app
if [ -f "app/reminder.sh" ]; then
    bash app/reminder.sh
    echo "----------------------------------------"
    echo "Reminder App executed successfully!"
else
    echo "Error: reminder.sh not found!"
fi
