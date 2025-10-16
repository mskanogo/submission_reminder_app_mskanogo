#!/usr/bin/bash
# create_environment.sh
# Creates the Submission Reminder App environment

# Prompt for user name
read -p "Enter your name: " yourname

# Main directory
maindir="submission_reminder_${yourname}"

# Create directories
mkdir -p "$maindir/app" "$maindir/modules" "$maindir/assets" "$maindir/config"

echo "Creating your submission reminder environment..."

# 1. functions.sh
cat > "$maindir/modules/functions.sh" << 'EOF'
#!/usr/bin/bash
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"
    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOF

# 2. submissions.txt
cat > "$maindir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Stacey, Shell Navigation, submitted
Erin, Shell Basics, not submitted
Charli, Git, not submitted
Winnie, Shell Navigation, submitted
Zack, Git, not submitted
EOF

# 3. config.env
cat > "$maindir/config/config.env" << 'EOF'
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=3
REMINDER_INTERVAL="2 days"
EOF

# 4. reminder.sh
cat > "$maindir/app/reminder.sh" << 'EOF'
#!/usr/bin/bash
source ./config/config.env
source ./modules/functions.sh

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions ./assets/submissions.txt
EOF

# 5. startup.sh
cat > "$maindir/startup.sh" << 'EOF'
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
EOF

# Make scripts executable
chmod +x "$maindir/startup.sh" "$maindir/app/"*.sh "$maindir/modules/"*.sh

echo "Environment created successfully in $maindir"
echo "To start the app, run:"
echo "  ./submission_reminder_${yourname}/startup.sh"

