#!/usr/bin/bash
# reminder.sh — Main app script

# Load configuration and helper functions
source ./config/config.env
source ./modules/functions.sh

# Run the reminder function
check_submissions ./assets/submissions.txt
