:: Takes in an experiment .mov file, splits to pre- and post-treatment based on timestamps, and extracts .tiff
:: frames based on a given frame rate.

@echo off
set ffmpeg="C:\ffmpeg\bin\ffmpeg"

SETLOCAL ENABLEDELAYEDEXPANSION

set /p path="Enter the path to where the experiment directories are located: "
cd !path!

set /p n="Enter the number of videos to analyze: "
set /p pre="Enter a name for the pre-treatment condition (e.g., baseline): "
set /p post="Enter a name for the post-treatment condition (e.g., drugtreated): "

for /l %%v in (1, 1, !n!) do (
    set /p video="Enter the experiment name for video #%%v: "
    set /p pre_end="Enter the %pre% end timestamp for video #%%v (H:MM:SS): "
    set /p post_start="Enter the %post% start timestamp for video #%%v (H:MM:SS): "
    set /p fps="Enter the frame rate for tiff extraction for video #%%v (e.g., 1/5 for 1 frame per 5 seconds): "

    cd !video!
    mkdir !pre!
    mkdir !post!
    echo %pre% and %post% folders created

    CALL:FrameExtraction !video!, !pre_end!, !post_start!, !fps!
    cd ..
)
ENDLOCAL
EXIT /B %ERRORLEVEL%

:FrameExtraction
%ffmpeg% -i %~1.mov -to %~2 -c copy -copyts %pre%.mov
echo %pre%.mov created

%ffmpeg% -ss %~3 -i %~1.mov -c copy -copyts %post%.mov
echo %post%.mov created

%ffmpeg% -i %pre%.mov -pix_fmt gray -vf fps=%~4 .\%pre%\%pre%_%%04d.tiff
echo extracted tiff files for %pre%

%ffmpeg% -i %post%.mov -pix_fmt gray -vf fps=%~4 .\%post%\%post%_%%04d.tiff
echo extracted tiff files for %post%

EXIT /B 0