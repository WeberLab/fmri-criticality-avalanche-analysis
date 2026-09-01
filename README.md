# Project overview
This repository contains MATLAB code and documentation for my undergraduate honours thesis:

**Sex Differences in Brain Criticality Using Neuronal Avalanche Analysis of Resting-State fMRI**  
Prithisha Gill 
B.Sc. Honours Biology, University of British Columbia, Vancouver (2026)

The project investigates whether neuronal avalanche dynamics differ between male and female groups using resting-state fMRI data from the Human Connectome Project (HCP) S1200 Young Adult release.

The analysis examines avalanche size, avalanche duration, power-law scaling, size-duration scaling relationships, and branching ratio as measures related to brain criticality.

Project overview
Sex Differences in Brain Criticality Using Neuronal Avalanche Analysis of Resting-State fMRI
This undergraduate honours thesis investigated whether large-scale brain dynamics differ between males and females by examining neuronal avalanche activity in resting-state fMRI data.

Brain criticality describes a regime between highly ordered and highly disordered activity. Neuronal avalanches are cascades of activity that can vary in size and duration and are commonly used to study critical-like brain dynamics.

The analysis used resting-state fMRI data from the Human Connectome Project (HCP) S1200 Young Adult release, including 20 participants (10 female, 10 male; ages 26–30). Each participant had two resting-state runs with opposite phase-encoding directions (LR and RL). The cortex was divided into 48 regions using the Harvard–Oxford cortical atlas.

**What was the research question?**
Do neuronal avalanche properties differ between male and female participants?
Specifically, the project examined:
Avalanche size — how many regional events occur within an avalanche
Avalanche duration — how long an avalanche lasts
α (alpha) — exponent describing the avalanche-size distribution
τ (tau) — exponent describing the avalanche-duration distribution
γ (gamma) — relationship between avalanche size and duration
σ (sigma) — branching ratio, used as another indicator of criticality
Analysis workflow
Step 0 — Get and prepare the data
The analysis starts with minimally preprocessed HCP resting-state fMRI data.
For each participant:
Obtain the resting-state fMRI data.
Parcellate the cortex into 48 Harvard–Oxford regions.
Extract the average BOLD signal from each region.
Organize the regional signals into a region × timepoint matrix.
z-normalize each regional time series.
The thesis used Nilearn for ROI extraction, while the main avalanche-analysis pipeline was implemented in MATLAB.
Step 1 — Synchrony analysis
Before avalanche detection, the ROI signals were also used to examine global synchrony.
The pipeline:
ROI signals → Hilbert transform → phase signals → Kuramoto order parameter → mean synchrony (MS) + synchronization entropy (SE)
Participants were ranked by mean synchrony and divided into low-, medium-, and high-synchrony groups. The MS–SE relationship was then examined using a second-order polynomial fit.
Step 2 — Detect events
Each z-normalized ROI signal was thresholded at 1.4 SD.
Whenever the signal exceeded this threshold, the region was treated as having an event.
This produces a binary matrix describing whether each ROI was active at each timepoint.
Step 3 — Detect neuronal avalanches
The event data were divided into bins of one TR (one volume).
A time bin was considered active if at least one ROI contained an event. Consecutive active bins were grouped into a neuronal avalanche.
For each avalanche:
Size (S) = total number of events across regions
Duration (T) = number of consecutive active time bins.
Step 4 — Analyze avalanche scaling
Avalanche size and duration distributions were tested for power-law behaviour:
P(S) ∼ S⁻ᵅ
P(T) ∼ T⁻ᵗᵃᵘ
The size–duration relationship was also examined:
⟨S⟩(T) ∼ Tᵞ
The exponents α and τ were estimated using maximum-likelihood methods, and Clauset's goodness-of-fit test was used to assess the plausibility of the power-law fits.
Step 5 — Calculate branching ratio
The branching ratio σ was calculated to assess how activity propagated between consecutive time bins.
Conceptually:
σ ≈ 1: critical
σ < 1: subcritical
σ > 1: supercritical
The analysis calculated σ across a range of event-detection thresholds to examine the stability of the results.
Step 6 — Compare groups
For the sex comparison, α, τ, and γ were compared between male and female participants using two-tailed unpaired t-tests.
Because each participant had both LR and RL runs, α and τ were averaged across the two runs before statistical comparison. A Bonferroni correction was applied across the three comparisons, giving a significance threshold of p < 0.0167.
Main findings
Both male and female groups showed avalanche behaviour broadly consistent with near-critical dynamics. The size and duration distributions were compatible with power-law behaviour, the empirical scaling relationships were close to theoretical expectations, and branching ratios remained below 1 but relatively close to the critical value.
The main sex-related differences were:
Measure	Result
α — avalanche size exponent	Significantly different; females had higher values
τ — avalanche duration exponent	Significantly different; females had higher values
γ — size-duration scaling exponent	No significant difference
σ — branching ratio	Below 1 across tested thresholds in both groups
The group comparison found p = 2.29 × 10⁻⁶ for α, p = 9.82 × 10⁻⁵ for τ, and p = 0.76 for γ.
What does this mean?
The results suggest that male and female groups may differ in the distribution of neuronal avalanches, particularly in avalanche size and duration, while maintaining a similar overall size–duration scaling relationship.
In other words, the two groups showed broadly similar critical-like dynamics, but the frequency/distribution of different avalanche sizes and durations differed between groups.
Repository / reproducibility
This repository contains the MATLAB scripts and supporting files used for the thesis analysis.
The workflow was adapted from Xu et al. (2022), with project-specific modifications including participant selection, file organization, application to the two participant groups, statistical comparisons, and figure generation.
The repository is therefore best understood as a research-analysis pipeline for reproducing the honours thesis, rather than as a standalone criticality software package.
A beginner trying to reproduce the analysis should follow the scripts in this order:
Step 0.5 → Step 2.1 → Step 2.2 → Step 2.3 → Step 3 → Step 4 → Step 5 → Step 5.1 → Step 6.1 → Step 6.2 → figure generation
with the relevant HCP data and atlas files supplied first.
Important reproducibility note
The publicly available repository does not contain the HCP resting-state data or subject-level extracted data. Those must be obtained separately under the HCP data-use requirements.
The original thesis used 20 participants and both LR and RL runs. For later publication work, one planned improvement is to increase the sample size and potentially use a single phase-encoding direction/run rather than treating LR and RL as separate observations. The thesis itself notes that LR and RL came from the same individuals and therefore were not independent participants.
For the actual lab wiki page, I would keep it even more visually simple than this: Project → Question → Data → Workflow → Results → Code → Thesis → Future work. That gives a new lab member enough information to understand what you did and how to reproduce it without dumping the entire thesis onto the page.
And I would specifically make Step 0 a proper “assume I know nothing” section in the GitHub README, because that's the piece your current README is missing.

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
- Two resting-state runs per participant (so, total 40 runs): LR and RL phase-encoding directions
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
