# SHM Post‑Earthquake Monitoring

*A data‑driven framework for vibration‑based health assessment of historical masonry after seismic events*

<!-- Optional badges -->

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](#license) [![Python](https://img.shields.io/badge/python-3.10+-blue.svg)](https://www.python.org/)

---

## Table of Contents

1. [Overview](#overview)
2. [Abstract](#abstract)
3. [Project Structure](#project-structure)
4. [Dataset](#dataset)
5. [Reproducing the Paper Experiments](#reproducing-the-paper-experiments)
6. [Citation](#citation)
7. [License](#license)
8. [Contact](#contact)

---

## Overview

This repository accompanies the paper **“Preserving the World Heritage: Post‑Earthquake Monitoring Based on Structural Break Testing with Deep Temporal Convolutional Features.”** It contains the full data‑processing pipeline, predictive models, and statistical tools needed to reproduce the study.

> **Goal** Predict the natural frequencies of a historical building from environmental variables, then detect abnormal post‑seismic behaviour by combining **Temporal Convolutional Networks (TCNs)** with **Bai‑Perron structural‑break testing**.

## Abstract

Built heritage faces nowadays increasing vulnerability due to
the combined impact of climatic, seismic, and anthropogenic forcings. In
this context, vibration-based monitoring has become a key non-invasive
method for assessing the integrity of historical buildings. However, little
attention has been given to the development of automatic tools, which are
crucial for rapid and effective decision-making. This study examines San
Cristobal Church, a 17th-century building located in the UNESCO World
Heritage site of Cusco, Peru. The church has been continuously moni-
tored during 17 months using a seismic sensor located on one of its walls.
First, we develop machine learning models to predict the church’s natu-
ral frequencies based only on weather data. Then, we analyze deviations
from the expected frequency variations to detect anomalies that may in-
dicate structural changes in the building, especially following strong tran-
sient events such as earthquake-induced motions. We evaluate multiple
machine learning approaches, including Ridge Regression, Feedforward
Neural Networks, and Temporal Convolutional Networks, with the latter
outperforming other models in capturing nonlinear temporal dependen-
cies. To estimate the post-seismic recovery time of the natural frequencies
following a Mw 4.2 earthquake occurred in August 13th, 2024, we em-
ploy the Bai-Perron test for structural break detection on the learned
deep temporal convolutional features. As this recovery time is influenced
by the damage state, changes in its duration can reflect alterations in
masonry mechanical properties. By accurately assessing the post-seismic
recovery time, our methodology offers a promising approach for develop-
ing early warning systems to identify damage in historical buildings.

## Project Structure

```
SHM-post_earthquake_monitoring/
├── data/                   # Sensor & weather data
├── transformed_data/       # Last layer activations of TCN
├── predictive_modeling/    # Training notebooks 
├── models/                 # Saved, serialised models (e.g. .pth, .joblib)
├── structural_break_analysis/  # Bai‑Perron tests & visualisations
└── README.md               # You’re here
```

## Dataset

| Source                  | Description                          | Resolution |
| ----------------------- | ------------------------------------ | ---------- |
| **Raspberry Shake 3C**  | Sensor data (Natural Frequency of first torsional mode) | 1 hour     |
| **Davis Vantage Pro 2** | Temp,Humidity,Wind,Wind_dir,Wind_run,Wind_max,Pressure,Rainfall,Solar_rad,Solar_energy   | 1 hour |

* **Time span:** July 2023 → Dec 2024
* **Event of interest:** Mw 4.2 earthquake on **2024‑08‑13** (UTC‑5)
* **Data availability:** Only already processed data about first torsional model is provided

## Reproducing the Paper Experiments

1. Git clone the repository
2. Execute the notebooks in both `predictive_modeling/` and `structural_break_analysis` to generate figures.

## Citation

If you make use of this code or data, please cite:

```bibtex
@inproceedings{dente2024heritage,
  title     = {Preserving the World Heritage: Post‑Earthquake Monitoring Based on Structural Break Testing with Deep Temporal Convolutional Features},
  author    = {Dente, Francesco and Combey, Andy and Lhéritier, Alix and Acuna‑Agost, Rodrigo and Mercerat, Diego},
  year      = {2024},
  booktitle = {Proceedings of ...},
}
```

## License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for more information.

## Contact

Francesco Dente — [francesco.dente@eurecom.fr](mailto:francesco.dente@eurecom.fr)

---
