# gutAnalysis
Widefield imaging analysis of the zebrafish gut pre and post nutrient stimulation

## Installation
### ffmpeg

Download ffmpeg: https://github.com/BtbN/FFmpeg-Builds/releases (ffmpeg-master-latest-win64-gpl.zip)

Extract the folder and rename it as `ffmpeg`

Copy the ffmpeg folder to local disk (C:). The executable's path should be `C:\ffmpeg\bin\ffmpeg.exe`

### ImageJ

Install ImageJ: https://imagej.nih.gov/ij/download.html

### gutAnalysis

Open Anaconda Prompt:

    conda create --name gutAnalysis
    activate gutAnalysis
    git clone https://github.com/minel-arinel/gutAnalysis.git
    cd gutAnalysis

Run ImageJ and install the `image_analysis.ijm` macro from `Plugins > Install...`

Open the file under `...\gutAnalysis\image_analysis.ijm`

Save under `...\Fiji.app\plugins\Macros\`

## Structure

The analysis consists of three steps:
1. Run the `frame_extraction.bat` script on Anaconda Prompt. This script separates the 
experiment .mov file to baseline and drugtreated conditions and saves frames as .tiff for a
given frame rate.
2. Run the `image_analysis.ijm` macro from `Plugins > Macros > image analysis`. This allows 
the user to straighten the tiff frames and save measurements for individual ROIs as a .csv 
file.