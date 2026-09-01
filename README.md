# Sex Differences in Brain Criticality Using Neuronal Avalanche Analysis of Resting-State fMRI

This repository contains MATLAB code and documentation for my undergraduate honours thesis:

**Sex Differences in Brain Criticality Using Neuronal Avalanche Analysis of Resting-State fMRI**
**Prithisha Gill**
B.Sc. Honours Biology, University of British Columbia, Vancouver (2026)

The project investigates whether neuronal avalanche dynamics differ between male and female groups using resting-state fMRI data from the Human Connectome Project (HCP) S1200 Young Adult release.

The analysis examines avalanche size, avalanche duration, power-law scaling, size-duration scaling relationships, and branching ratio as measures related to brain criticality.

---

## Project Overview

Brain criticality describes a regime between highly ordered and highly disordered activity. Neuronal avalanches are cascades of activity that can vary in size and duration and are commonly used to study critical-like brain dynamics.

The analysis used resting-state fMRI data from the **Human Connectome Project (HCP) S1200 Young Adult release**, including 20 participants (10 female and 10 male; ages 26–30 years). Each participant contributed two resting-state runs with opposite phase-encoding directions (LR and RL). The cortex was parcellated into 48 regions using the Harvard–Oxford cortical atlas.

### Research Question

**Do neuronal avalanche properties differ between male and female participants?**

The project examined:

* **Avalanche size (S):** the total number of events occurring within an avalanche
* **Avalanche duration (T):** how long an avalanche lasts
* **α (alpha):** exponent describing the avalanche-size distribution
* **τ (tau):** exponent describing the avalanche-duration distribution
* **γ (gamma):** exponent describing the relationship between avalanche size and duration
* **σ (sigma):** branching ratio, used as an additional indicator of criticality

---

## Analysis Workflow

The analysis pipeline proceeds from preprocessed resting-state fMRI data to ROI time series, event detection, neuronal avalanche detection, criticality analysis, and statistical comparison between groups.

### Step 0 — Get and Prepare the Data

The analysis starts with minimally preprocessed HCP resting-state fMRI data.

For each participant:

1. Obtain the resting-state fMRI data.
2. Parcellate the cortex into 48 regions using the Harvard–Oxford cortical atlas.
3. Extract the average BOLD signal from each region of interest (ROI).
4. Organize the regional signals into a region × timepoint matrix.
5. Z-normalize each regional time series.

The ROI time series were extracted using the **Nilearn** Python library. The main analysis pipeline was implemented in **MATLAB**.

> **Note:** HCP minimally preprocessed data and extracted/parcellated ROI time-series files are not included in this repository. Users must obtain the HCP data independently and comply with all relevant HCP data-use terms.

### Step 1 — Synchrony Analysis

Before avalanche detection, the ROI signals were used to examine global synchrony.

The workflow is:

**ROI signals → Hilbert transform → phase signals → Kuramoto order parameter → Mean Synchrony (MS) + Synchronization Entropy (SE)**

For each subject:

* ROI time series were converted to phase signals using the Hilbert transform.
* The Kuramoto order parameter was calculated across all regions at each time point.
* **Mean synchrony (MS)** was calculated as the temporal average of the order parameter.
* **Synchronization entropy (SE)** was calculated from the distribution of the order parameter.

Subjects were ranked based on MS and divided into low-, medium-, and high-synchrony groups:

* **LMS:** Low Mean Synchrony
* **MMS:** Medium Mean Synchrony
* **HMS:** High Mean Synchrony

The relationship between MS and SE was then examined using a second-order polynomial fit.

### Step 2 — Detect Events

Each z-normalized ROI time series was thresholded at **1.4 SD**.

An event was defined as a time point at which the signal in a given region exceeded this threshold.

This produced a binary sequence indicating whether each region was active at each time point.

### Step 3 — Detect Neuronal Avalanches

The event data were divided into time bins corresponding to **one TR (one volume)**.

A time bin was considered active if at least one region contained an event. Consecutive active bins were grouped together to form a neuronal avalanche.

For each avalanche:

* **Size (S):** total number of events across all regions within the avalanche
* **Duration (T):** number of consecutive active time bins

### Step 4 — Power-Law Analysis

Avalanche size and duration distributions were analyzed to assess scaling behaviour.

The distributions were modeled as:

$$
P(S) \sim S^{-\alpha}
$$

$$
P(T) \sim T^{-\tau}
$$

The relationship between average avalanche size and duration was also examined:

$$
\langle S \rangle(T) \sim T^\gamma
$$

The exponents **α** and **τ** were estimated using maximum-likelihood methods. Clauset's goodness-of-fit test was used to assess the plausibility of the power-law fits.

The theoretical scaling relationship was also evaluated:

$$
\gamma = \frac{1-\tau}{1-\alpha}
$$

### Step 5 — Branching Ratio Analysis

The **branching ratio (σ)** was calculated as another measure of criticality.

Conceptually:

* **σ ≈ 1:** critical
* **σ < 1:** subcritical
* **σ > 1:** supercritical

The branching ratio describes how activity propagates between consecutive time bins.

The analysis calculated σ across a range of event-detection thresholds to assess the stability of the avalanche dynamics and their proximity to criticality.

### Step 6 — Statistical Comparison

For the sex comparison, **α, τ, and γ** were compared between male and female groups using two-tailed unpaired t-tests assuming unequal variance.

Because each participant contributed both LR and RL scans, α and τ were averaged across the two runs for each participant before statistical comparison.

A Bonferroni correction was applied across the three comparisons, resulting in a corrected significance threshold of:

**p < 0.0167**

---

## Main Findings

Both male and female groups showed features consistent with **near-critical avalanche behaviour**, including plausible power-law fits for avalanche size and duration distributions, agreement with theoretical scaling relationships, and branching ratios close to but below 1.

### Sex-related differences

| Measure                                | Result                                                   |
| -------------------------------------- | -------------------------------------------------------- |
| **α — Avalanche size exponent**        | Significant difference; females showed higher values     |
| **τ — Avalanche duration exponent**    | Significant difference; females showed higher values     |
| **γ — Size-duration scaling exponent** | No significant difference                                |
| **σ — Branching ratio**                | Remained below 1 across tested thresholds in both groups |

The group comparisons found:

* **α:** p = 2.29 × 10⁻⁶
* **τ:** p = 9.82 × 10⁻⁵
* **γ:** p = 0.76

### Interpretation

The results suggest that male and female groups may differ in the **distribution of neuronal avalanches**, particularly in avalanche size and duration, while maintaining a similar overall size-duration scaling relationship. However, due to smaller sample size, more subjects need to be concluded to make such a conclusion. 

The results also suggest that avalanche dynamics in both groups operate near, but slightly below, the critical point.

---

## Important Note on Code Attribution

This analysis pipeline is primarily adapted from previously published methods by:

**Xu, L., Feng, J., & Yu, L. (2022).** *Avalanche criticality in individuals, fluid intelligence, and working memory.* Human Brain Mapping, 43(8), 2534–2553.
https://doi.org/10.1002/hbm.25802

The criticality analysis workflow and helper functions are mainly based on or adapted from this prior work.

My project-specific modifications include:

* subject selection
* changes to extract fMRI time series data and bundle subjects in groups
* file organization
* application to male and female participant groups
* statistical comparison between groups
* figure generation for the honours thesis

This repository is therefore intended to document the analysis pipeline used for my thesis, not to present the criticality analysis software as an original software package.

---

## Data

This project uses resting-state fMRI data from the **Human Connectome Project (HCP) S1200 Young Adult release**.

The study included **20 participants** in total:

* 10 female participants
* 10 male participants
* Age range: 26–30 years
* Two resting-state runs per participant (**40 runs total**)
* LR and RL phase-encoding directions
* 1200 time points per run
* Harvard–Oxford cortical atlas parcellation with 48 regions of interest

HCP minimally preprocessed data and extracted/parcellated ROI time-series files are **not included** in this repository. Users must obtain HCP data independently and comply with all relevant HCP data-use terms.

---

## Participant Groups

The following HCP subject IDs were used in the thesis analysis.

| Group      | HCP Subject IDs                                                                |
| ---------- | ------------------------------------------------------------------------------ |
| **Female** | 111211, 117021, 120414, 139435, 143224, 153126, 165941, 167440, 168947, 176845 |
| **Male**   | 102109, 102715, 119025, 125222, 138332, 144933, 145632, 146836, 161832, 165436 |

Both LR and RL resting-state scans were included for each participant.

The same analysis pipeline was run for both male and female groups. For group-specific analyses, the relevant subject list and input files were used while keeping the event detection, avalanche detection, power-law analysis, and branching parameter workflow consistent across groups.

---

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
├── MASK/                                    # Masks and extracted/parcellated ROI data
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

### Analysis Order

For a basic reproduction of the analysis, the main scripts are run in approximately this order:

```text
Step_0_5_bundling_subjects.m
        ↓
Step_2_1_ROI_signals_MS_SE.m
        ↓
Step_2_2_define_LMH_group.m
        ↓
Step_2_3_MS_SE_relationship.m
        ↓
Step_3_detect_events.m
        ↓
Step_4_detect_avalanches.m
        ↓
Step_5_powerlaw_analysis.m
        ↓
Step_5_1_individual_alpha_tau_value.m
        ↓
Step_6_1_branching_analysis.m
        ↓
Step_6_2_branching_parameter.m
        ↓
display_figure.m
```

---

## Thesis

**Sex Differences in Brain Criticality Using Neuronal Avalanche Analysis of Resting-State fMRI**

Prithisha Gill
B.Sc. Honours Biology
University of British Columbia
April 2026

The thesis contains the full background, literature review, methods, results, discussion, limitations, and references for this project.

---

## Future Directions

The thesis identified several areas for future work, including:

* Increasing the sample size
* Investigating whether results remain stable using a single phase-encoding direction/run (LR or RL)
* Combining runs at the time-series level before avalanche estimation where appropriate
* Using automated fitting-range selection and stronger power-law validation methods
* Comparing against alternative heavy-tailed distributions and surrogate data
* Testing robustness across different atlases, preprocessing pipelines, and event-detection thresholds

The thesis also notes that LR and RL runs were obtained from the same participants and therefore should not be treated as fully independent participants.

---

## License and Permissions

No open-source license has been assigned.

This repository contains code and documentation for an undergraduate honours thesis. Please do not redistribute, reuse, cite, adapt, or use the thesis materials, figures, or analysis code for machine-learning/model-training purposes without permission from the author and, where applicable, the supervising lab.

Raw HCP data and derived subject-level data files are not included in this repository.

---

## Questions

For questions, contact:

**Prithisha Gill**
[prithishagill@gmail.com](mailto:prithishagill@gmail.com)
