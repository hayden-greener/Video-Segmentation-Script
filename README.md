# Video Segmentation Script
This bat file allows you to segment a video file at set intervals. It provides two methods for selecting the video file: drag and drop or selecting from a list. The default segment time is 600 seconds.

## Requirements

- [ffmpeg](https://www.ffmpeg.org/) must be installed on your system.

## Usage

1. Drag and drop a video file onto the script to segment it at the specified segment time.
2. If no file is dragged onto the script, a list of video files will be displayed and you can select one.
3. Enter the segment time in seconds when prompted.

## Output

The segmented video files will be saved in a subfolder named `filename_Segmented`.

## Troubleshooting

- If the script doesn't run on the attempted video file, try renaming it. Some characters, such as exclamation marks, are not valid in Windows batch files.

---

*This script was created by LightMind.*
