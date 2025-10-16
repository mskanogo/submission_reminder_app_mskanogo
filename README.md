# Submission Reminder App

## Project Overview

The **Submission Reminder App** is a Linux-based shell script application designed to help students track their assignment submissions. It automatically checks which students have not submitted a particular assignment and displays reminders along with the assignment name and remaining days.

The app includes:

- Environment setup script (`create_environment.sh`)
- Assignment update and reminder script (`copilot_shell_script.sh`)
- Configuration, submissions data, and helper functions
- Startup script (`startup.sh`) to run the app

---

## Directory Structure

After running `create_environment.sh`, the environment will be structured as follows:


- **app/** – contains the main reminder script.
- **modules/** – contains helper functions (`functions.sh`).
- **assets/** – stores student submissions (`submissions.txt`).
- **config/** – stores environment variables (`config.env`).
- **startup.sh** – initializes and runs the app.
