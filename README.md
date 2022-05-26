# gutAnalysis
Widefield imaging analysis of the zebrafish gut pre and post nutrient stimulation

## Installation
### ffmpeg

Download ffmpeg: https://github.com/BtbN/FFmpeg-Builds/releases (ffmpeg-master-latest-win64-gpl.zip)

Extract the folder and rename it as `ffmpeg`

Copy the ffmpeg folder to local disk (C:). The executable's path should be `C:\ffmpeg\bin\ffmpeg.exe`

### Fiji

Install Fiji: https://imagej.net/software/fiji/downloads

### gutAnalysis

Open Anaconda Prompt:

    conda create --name gutAnalysis
    conda activate gutAnalysis
    git clone https://github.com/minel-arinel/gutAnalysis.git
    cd gutAnalysis

Run ImageJ and install the `imageAnalysis.ijm` macro from `Plugins > Install...`

Open the file under `...\gutAnalysis\imageAnalysis.ijm`

Save under `...\Fiji.app\plugins\Macros\`

## Structure

This pipeline takes in a .mov experiment file and analyzes pre- and post-treatment
fluorescence values for given ROIs. The .ipynb consists of commonly used plots within and
between different stimuli.

### Naming convention
For the pipeline to run, the experiment folders and the .mov files have to be named in the
following format:
`genotype_age_feeding condition_stimulus_concentration_fish ID_date`

- Genotype should not include any special characters. If the fish is a transgenic, promoter
and the expressed construct should be written as a whole.
- Age should be in the format `[number]dpf`
- Feeding condition can be `fed`, `unfed`, `compunfed`. `fed` fish are fed on the day of 
the experiment, before running the fish. `unfed` fish have been introduced to a feed
before at a younger age, but not on the day of the experiment. `compunfed` fish have been
completely abstinent of any type of feed.

Examples:

1. neurod1GCaMP6s_6dpf_unfed_glucose_500mM_003_20220221
2. 

The analysis consists of three steps:
1. Run the `frameExtraction.bat` script on Anaconda Prompt. This script separates the 
experiment .mov file to baseline and drugtreated conditions and saves frames as .tiff for a
given frame rate.
2. Run the `imageAnalysis.ijm` macro from `Plugins > Macros > imageAnalysis`. This allows 
the user to straighten the tiff frames and save measurements for individual ROIs as a .csv 
file.
3. Open the Jupyter notebook `responsePlots.ipynb` to import the .csv file and plot the fluorescence
intensity values over time.

### TO-DO
1. example naming conventions on readme.md
2. plot times instead of frames
3. normalize to baseline
4. normalize to egg water
5. run stats per timebin
6. put the df and plotting lines in a separate functions.py