## ROI examples

- `background_roi.roi`: rectangle for measuring change in background fluorescence over time 
to subtract from the gut signal. This ROI is generally placed on the zebrafish, dorsal to 
the spinal cord. Make sure to not have a fluorescence signal within this ROI.
- `gut_roi.roi`: schematic of a larval zebrafish gut. Adjust the size of this ROI on the
post-treatment condition when the gut is at its largest volume.

![Gut ROI example](https://github.com/minel-arinel/gutAnalysis/blob/main/gut_roi_example.png)
- `vagal_roi.roi`: schematic of a vagal ganglion from the side. Vagal ganglia have a 
tooth-like structure, positioned below the hindbrain.

