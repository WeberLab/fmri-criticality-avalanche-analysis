# Sex Differences in Brain Criticality Using Neuronal Avalanche Analysis of Resting-State fMRI

This repository contains MATLAB code and documentation for my undergraduate honours thesis:

**Sex Differences in Brain Criticality Using Neuronal Avalanche Analysis of Resting-State fMRI**  
Prithisha Gill 
B.Sc. Honours Biology, University of British Columbia, Vancouver (2026)

The project investigates whether neuronal avalanche dynamics differ between male and female groups using resting-state fMRI data from the Human Connectome Project (HCP) S1200 Young Adult release.

The analysis examines avalanche size, avalanche duration, power-law scaling, size-duration scaling relationships, and branching ratio as measures related to brain criticality.

## Important Note on Code Attribution
This analysis pipeline is primarily adapted from previously published methods by:

**Xu, L., Feng, J., & Yu, L. (2022). Avalanche criticality in individuals, fluid intelligence, and working memory. Human Brain Mapping, 43(8), 2534–2553. https://doi.org/10.1002/hbm.25802**

The criticality analysis workflow and several helper functions are based on or adapted from this prior work. My project-specific modifications include subject selection, file organization, application to male and female participant groups, statistical comparison between groups, and figure generation for the honours thesis.

This repository is therefore intended to document the analysis pipeline used for my thesis, not to present the criticality analysis software as an original software package.

## Data
This project uses resting-state fMRI data from the Human Connectome Project (HCP) S1200 Young Adult release.

The study included 20 participants in total:
- 10 female participants
- 10 male participants
- Age range: 26-30 years
- Two resting-state runs per participant: LR and RL phase-encoding directions
- 1200 time points per run
- Harvard-Oxford cortical atlas parcellation with 48 regions of interest

HCP minimally preprocessed data and extracted/parcellated ROI time-series files are not included in this repository. Users must obtain HCP data independently and comply with all relevant HCP data-use terms. 


## Participant Groups
The following HCP subject IDs were used in the thesis analysis.

| Group | HCP Subject IDs |
|---|---|
| Female | 111211, 117021, 120414, 139435, 143224, 153126, 165941, 167440, 168947, 176845 |
| Male | 102109, 102715, 119025, 125222, 138332, 144933, 145632, 146836, 161832, 165436 |

Both LR and RL resting-state scans were included for each participant.

The same analysis pipeline was run for both male and female groups. For group-specific analyses, the relevant subject list and 
input files were used while keeping the event detection, avalanche detection, power-law analysis, and branching parameter workflow 
consistent across groups.


## Repository Structure
```text
├── All_Atlas_Files/                         # Atlas files used for parcellation
├── Functions/                               # Helper functions used by the MATLAB pipeline
│   ├── CritAnalysisSoftwarePackage...       # External/adapted criticality analysis package
│   ├── find_nonzero_data.m
│   ├── xlz_aggr_ava_pl.m
│   ├── xlz_aggr_branching_parameter.m
│   ├── xlz_avalanches.m
│   ├── xlz_entropy.m
│   ├── xlz_fit_plnonlinearLS.m
│   ├── xlz_fit_poly1.m
│   ├── xlz_fit_poly2.m
│   ├── xlz_kop.m
│   ├── xlz_kop2sta.m
│   ├── xlz_lifetimeAverageSize.m
│   ├── xlz_peakevents.m
│   └── xlz_shape2branchingprocess.m
├── HCP_rfMRI_SingleSubjectData/             # Local HCP input data; not included publicly
├── MASK/                                    # Applies mask; extracted/parcellated ROI time-series data
├── step_2_MS_SE_relationship/               # Outputs from Step 2 scripts
├── step_3_events/                           # Outputs from event detection
├── step_4_avalanches/                       # Outputs from avalanche detection
├── step_5_powerlaw_analysis/                # Outputs from power-law analysis
├── step_6_branching_process_analysis/       # Outputs from branching process analysis
├── Step_0_5_bundling_subjects.m             # Bundles subject time-series data
├── Step_2_1_ROI_signals_MS_SE.m             # Calculates Kuramoto order parameter, MS, and SE
├── Step_2_2_define_LMH_group.m              # Defines LMS, MMS, and HMS groups
├── Step_2_3_MS_SE_relationship.m            # Plots MS-SE relationship
├── Step_3_detect_events.m                   # Detects threshold-based peak events
├── Step_4_detect_avalanches.m               # Detects neuronal avalanches
├── Step_5_powerlaw_analysis.m               # Performs group-level power-law analysis
├── Step_5_1_individual_alpha_tau_value.m    # Calculates individual alpha and tau values
├── Step_6_1_branching_analysis.m            # Converts avalanche shapes to branching processes
├── Step_6_2_branching_parameter.m           # Calculates branching parameters
└── display_figure.m                         # Generates figures from processed outputs
```

## License and Permissions
No open-source license has been assigned.

This repository contains code and documentation for an unpublished undergraduate honours thesis. Please do not redistribute, reuse, cite, adapt, or use the thesis materials, figures, or analysis code for machine learning/model-training purposes without permission from the author and, where applicable, the supervising lab.

Raw HCP data and derived subject-level data files are not included in this repository.

## Questions

For questions, contact:

**Prithisha Gill**  
prithishagill@gmail.com
