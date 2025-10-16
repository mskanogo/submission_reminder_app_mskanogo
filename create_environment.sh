#!/usr/bin/bash


#Prompt for user name

read -p "Enter your name: " yourname

#Create main directories

maindir="submission_reminder_${yourname}"
mkdir "$maindir"

#Create subdirectories

mkdir "$maindir/app"
mkdir "$maindir/modules"
mkdir "$maindir/assets"
mkdir "$maindir/config"

# Add content into the reminder.sh

echo "#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
" > "$maindir/app/reminder.sh"

#Add content into the functions.sh

echo "#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
" > "$maindir/modules/functions.sh"

#Add content into submissions.txt

echo "student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Stacey, Git, not submitted
Zack, Shell Navigation, submitted
Trevor, Shell Basics, not submitted
Erin, Git, submitted
Bryson, Shell Navigation
" > "$maindir/assets/submissions.txt"

#Add content into config.env

echo "# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
" > "$maindir/config/config.env"

#Create startup.sh

echo "#!/bin/bash

# Print a message indicating the startup process has begun
echo "Starting the Reminder App..."

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Check if required environment variables are set
if [[ -z "$ASSIGNMENT" || -z "$DAYS_REMAINING" ]]; then
    echo "Error: ASSIGNMENT or DAYS_REMAINING is not set in config.env"
    exit 1
fi

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Check if the submissions file exists
if [[ ! -f "$submissions_file" ]]; then
    echo "Error: Submissions file '$submissions_file' does not exist."
    exit 1
fi

# Call the function to check submissions
check_submissions "$submissions_file"

# Print a message indicating the app has started successfully
echo "Reminder App started successfully."
" > "$maindir/startup.sh"

#Give the *.sh executable permission

chmod +x "$maindir/app/reminder.sh"
chmod +x "$maindir/modules/functions.sh"
chmod +x "$maindir/startup.sh"

#Success message

echo "Environment created successfully in $maindir"

echo "Type "$maindir/startup.sh" to run the startup.sh"
