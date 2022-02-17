:: Takes in an experiment .mov file, splits to baseline and drugtreated based on timestamps, and extracts .tiff
:: frames based on a given frame rate.

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p n="Enter the number of videos to analyze: "

for /l %%v in (1, 1, !n!) do (
    set /p video="Enter the experiment video name for video #%%v: "
    set /p b_end="Enter the baseline end timestamp for video #%%v (H:MM:SS): "
    set /p d_start="Enter the drugtreated start timestamp for video #%%v (H:MM:SS): "
    set /p fps="En ter the frame rate for tiff extraction for video #%%v (e.g., 1/5 for 1 frame per 5 seconds): "

    CALL:FrameExtraction !video!, !b_end!, !d_start!, !fps!
    )
ENDLOCAL
EXIT /B %ERRORLEVEL%

:FrameExtraction
cd %~1
mkdir baseline
mkdir drugtreated
echo baseline and drugtreated folders created

ffmpeg -i %~1.mov -to %~2 -c copy -copyts baseline.mov
echo baseline.mov created

ffmpeg -ss %~3 -i %~1.mov -c copy -copyts drugtreated.mov
echo drugtreated.mov created

ffmpeg -i baseline.mov -pix_fmt gray -vf fps=%~4 .\baseline\baseline_%%04d.tiff
echo extracted tiff files for baseline
ffmpeg -i drugtreated.mov -pix_fmt gray -vf fps=%~4 .\drugtreated\drugtreated_%%04d.tiff
echo extracted tiff files for drugtreated

cd ..
EXIT /B 0