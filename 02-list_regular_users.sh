#!/bin/bash
# Script: Display all regular users (based on UID range) and show their total count

# List regular users: UID >= 1000 and exclude 'nobody' (UID 65534)
awk -F : '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd

# Count the number of regular users
number_of_users=$(awk -F : '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd | wc -l)

# Display the count
echo "Number of users : $number_of_users"
