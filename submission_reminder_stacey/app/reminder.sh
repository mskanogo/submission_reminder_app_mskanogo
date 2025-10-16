#!/usr/bin/bash
source ./config/config.env
source ./modules/functions.sh

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions ./assets/submissions.txt
