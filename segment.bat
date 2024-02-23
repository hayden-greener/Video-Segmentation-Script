@echo off
setlocal EnableDelayedExpansion

:: Print the information
echo This script was created by LightMind.
echo You can drag and drop a VOD onto this bat file for segmentation at the saved segment time.

:: Set default values
set "DEFAULT_SEGMENT_TIME=600"
set "inputFile=%~1"
set "segmentTime=%DEFAULT_SEGMENT_TIME%"

:: If no file was dragged onto the script, list video files and ask user to select one
if "%inputFile%"=="" (
    echo Select a video file to split:
    for /f "tokens=1,* delims=:" %%a in ('dir /b *.mp4 *.avi *.mkv *.flv *.mov ^| findstr /n "^"') do (
        echo %%a. %%b
        set "file%%a=%%b"
    )
    set /p userChoice="Enter the ID of the video file you want to split: "
    set "inputFile=!file%userChoice%!"

    :: Ask the user to enter the segment time
    set /p segmentTime="Enter the segment time in SECONDS (%DEFAULT_SEGMENT_TIME% Seconds): "
    if "!segmentTime!"=="" set "segmentTime=%DEFAULT_SEGMENT_TIME%"
)

set "baseName=%~n1"
set "subfolder=%baseName%_Segmented"
mkdir "!subfolder!" >nul 2>&1

:: Check if ffmpeg is installed and split the selected video file
ffmpeg -version >nul 2>&1 || (echo ffmpeg is not installed. Opening browser for download... && start "" "https://www.ffmpeg.org/" && exit /b)
ffmpeg -i "!inputFile!" -map 0 -c copy -f segment -fps_mode cfr -segment_time %segmentTime% -segment_start_number 1 "!subfolder!/%%03d_!baseName!.mp4"

:: Pause the script to see any error messages
pause
endlocal
