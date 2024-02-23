#!/bin/bash

# Print the information
echo "This script was created by LightMind."
echo "You can drag and drop a VOD onto this script for segmentation at the saved segment time."

# Set default values
DEFAULT_SEGMENT_TIME=600
inputFile="$1"
segmentTime=$DEFAULT_SEGMENT_TIME

# If no file was dragged onto the script, list video files and ask user to select one
if [ -z "$inputFile" ]; then
    echo "Select a video file to split:"
    files=( *.mp4 *.avi *.mkv *.flv *.mov )
    for index in "${!files[@]}"; do 
        echo "$((index+1)). ${files[index]}"
    done
    read -p "Enter the ID of the video file you want to split: " userChoice
    inputFile="${files[$((userChoice-1))]}"

    # Ask the user to enter the segment time
    read -p "Enter the segment time in SECONDS ($DEFAULT_SEGMENT_TIME Seconds): " segmentTime
    if [ -z "$segmentTime" ]; then 
        segmentTime=$DEFAULT_SEGMENT_TIME
    fi
fi

baseName=$(basename "$inputFile")
subfolder="${baseName}_Segmented"
mkdir -p "$subfolder"

# Check if ffmpeg is installed and split the selected video file
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg is not installed. Please install it first."
    open "https://www.ffmpeg.org/"
    exit 1
fi

ffmpeg -i "$inputFile" -map 0 -c copy -f segment -segment_time $segmentTime -segment_start_number 1 "$subfolder/%03d_$baseName.mp4"

# Pause the script to see any error messages
read -n 1 -s -r -p "Press any key to continue"
