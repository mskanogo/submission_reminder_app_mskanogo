#!/usr/bin/bash
# reminder.sh — Main app script

# Load configuration and helper functions
source ./config/config.env
source ./modules/functions.sh

# Display assignment information
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

# Run the reminder function
check_submissions ./assets/submissions.txt


##############################################
# 5. Create the startup.sh file
##############################################
cat > "$maindir/startup.sh" << 'EOF'
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
