#!/usr/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$SCRIPT_DIR" || exit 1

chmod +x app/*.sh modules/*.sh 2>/dev/null

echo "========================================"
echo "     Starting Submission Reminder App"
echo "========================================"

if [ -f "app/reminder.sh" ]; then
    bash app/reminder.sh
    echo "----------------------------------------"
    echo "Reminder App executed successfully!"
else
    echo "Error: reminder.sh not found!"
fi
