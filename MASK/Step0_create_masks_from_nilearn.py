# Retrieve the atlas and the data
from nilearn.datasets import fetch_atlas_harvard_oxford 
from nilearn import image
import numpy as np
from scipy.io import savemat

dataset = fetch_atlas_harvard_oxford("cort-maxprob-thr25-2mm") # downloades the atlas i needed
atlas_filename = dataset.maps                                  # the NIfTI file containing all ROI labels (each voxel has a number = a brain region
labels = dataset.labels                                        # list of the names of each region (e.g., “Frontal Pole”, “Insula”, etc.)
look_up_table = dataset.lut                                    # lookup table mapping numbers → names.
print(f"Atlas ROIs are located in nifti image (4D) at: {atlas_filename}")

# load preprocessed HCP clean rsfMRI data
subject_data = image.load_img('HCP_rfMRI_SingleSubjectData/176845rfMRI_REST1_RL_hp2000_clean_rclean_tclean.nii')

# Extract signals on a parcellation defined by labels
from nilearn.maskers import NiftiLabelsMasker
"""
this is aligning the atlas to the subject's fMRI space 

for each ROI, it finds all voxels inside labelled brain region -> extracts the fMRI signals from those voxels ->  
-> calculates mean time series across voxels (that is where the stategy = 'mean' comes into play) and standardizes each region
Finally, it gives us time x region matrix
"""
masker = NiftiLabelsMasker(                   
    labels_img=atlas_filename,
    lut=look_up_table,
    standardize="zscore_sample",
    strategy ='mean',                 # ask if this is correct? -> this is doing the mean time series across the voxels in each ROI
    memory=None,  #check this         # don't need to cache as this is only one subject, might do it for multiple subjects
    verbose=1,
)

# Here we go from nifti files to the signal time series in a numpy
# array. No confounds. 
time_series = masker.fit_transform(subject_data)

print(f"Time series shape: {time_series.shape}")  # gives shape of time series
print(f"Number of regions: {len(labels)}")         # gives number of atlas labels


# Save as .mat file for MATLAB
savemat('MASK/parcellated_timeseries_176845RL.mat', {    # name of file as which it is saved
    'time_series': time_series,                 # saves the (the ROI x time matrix)
    'labels': labels,                           # saves region names
    'n_timepoints': time_series.shape[0],       # saves number of time points
    'n_regions': time_series.shape[1]           # saves number of regions
})

print("Saved to MASK/parcellated_timeseries_176845RL.mat")

