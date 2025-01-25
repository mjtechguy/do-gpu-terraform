#!/bin/bash

# Calculate the destruction time
current_time=$(date +%s)
destroy_time=$((current_time + $1 * 60))
destroy_date=$(date -d @$destroy_time '+%M %H %d %m *')

# Schedule the cron job
(crontab -l; echo "$destroy_date terraform destroy -auto-approve") | crontab - 