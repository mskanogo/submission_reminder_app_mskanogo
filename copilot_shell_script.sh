#!/usr/bin/bash
# copilot_shell_script.sh
# Updates the assignment in config.env and reruns the reminder app
# Automatically detects the most recently created submission_reminder_* folder

# Find the most recently modified submission_reminder_* folder
ENV_FOLDER=$(ls -td submission_reminder_* 2>/dev/null | head -1)

# Check if a folder was found
if [ -z "$ENV_FOLDER" ]; then
    echo "Error: No submission_reminder_* folder found in the current directory!"
    exit 1
fi

echo "Detected environment folder: $ENV_FOLDER"

# Prompt for the new assignment name
read -p "Enter the new assignment name: " NEW_ASSIGNMENT

# Path to config.env
CONFIG_FILE="$ENV_FOLDER/config/config.env"

# Update the ASSIGNMENT variable in config.env
if [ -f "$CONFIG_FILE" ]; then
    sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$NEW_ASSIGNMENT\"/" "$CONFIG_FILE"
    echo "Updated assignment in $CONFIG_FILE to '$NEW_ASSIGNMENT'."
else
    echo "Error: config.env not found in $ENV_FOLDER/config/"
    exit 1
fi

# Run the startup.sh script
STARTUP_SCRIPT="$ENV_FOLDER/startup.sh"

if [ -f "$STARTUP_SCRIPT" ]; then
    echo "Running the reminder app for the new assignment..."
    bash "$STARTUP_SCRIPT"
else
    echo "Error: startup.sh not found in $ENV_FOLDER/"
    exit 1
fi

