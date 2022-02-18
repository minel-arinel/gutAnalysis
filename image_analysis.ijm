// This macro takes in two tiff image sequences for baseline and drugtreated conditions and saves fluorescence measurements
// in a .csv file for individual ROIs

#@ File (label="Select the experiment folder", style="directory") expfolder
#@ String(label="Enter the name of the first (pre) condition") cond1;
#@ String(label="Enter the name of the second (post) condition") cond2;
run("Image Sequence...", "select=["+expfolder+"/"+cond1+"/] dir=["+expfolder+"/"+cond1+"/] sort");
run("Image Sequence...", "select=["+expfolder+"/"+cond2+"/] dir=["+expfolder+"/"+cond2+"/] sort");

// The user determines the angle of rotation using the angle tool. The first point should be at the end of the distal gut,
// the second point should be at the beginning of the distal gut (where the kink is located), and the third point should
// be a horizontal line towards the end of the distal gut while pressing the Shift key.
// The rotated image sequence is saved as a tiff file.
selectWindow(cond1);
setTool("angle");
waitForUser("Using the angle tool, select the first side along the distal gut and the second side while holding the Shift key to make a straight horizontal line towards the end of the distal gut"));
run("Measure");
angle = Table.get("Angle", 1);
run("Rotate... ", "angle=-"+angle+" grid=1 interpolation=Bilinear stack");
run("Remove Overlay");
saveAs("Tiff", expfolder+"/"+cond1+".tif");
selectWindow(cond2);
run("Rotate... ", "angle=-"+angle+" grid=1 interpolation=Bilinear stack");
saveAs("Tiff", expfolder+"/"+cond2+".tif");

// The user selects all the pre-set ROIs that they want to measure. Each ROI is then sent to the roiAdjuster function to
// be adjusted by the user.
run("ROI Manager...");
#@ File[] (label="Select the ROI files", style="files") roifiles
for (i=0; i < roifiles.length; i++) {
	roiAdjuster(roifiles[i], i);
}
run("Set Measurements...", "area mean min integrated stack redirect=None decimal=3");
saveMeasurement(cond1);
saveMeasurement(cond2);
for (i=0; i < roifiles.length; i++) {
	roiManager("Select", 0);
	roiManager("Delete");
}

function saveMeasurement(cond) { 
// Saves the measurements from all ROIs across all slices into a .csv file.
	selectWindow(cond+".tif");
	roiManager("deselect");
	roiManager("multi measure");
	saveAs("Results", expfolder+"/"+cond+".csv");
	selectWindow("Results"); 
	run("Close");
}

function roiAdjuster(roifile, i) { 
// Opens a pre-set ROI, waits for the user to adjust it, and saves it as the experiment's ROI.
	roiManager("Open", roifile);
	setTool("rectangle");
	selectWindow(cond2+".tif");
	roiManager("Select", i);
	waitForUser("Adjust the size and shape of the ROI"));
	roiManager("Add");
	roiManager("Select", i+1);
	roiManager("Save", expfolder+"/"+File.getName(roifile));
	roiManager("Select", i);
	roiManager("Delete");
}