# Modeling and Control of Underwater Vehicle: SPARUS

## Introduction
This project focuses on the simulation and modeling of the Sparus Autonomous Underwater Vehicle (AUV). By analyzing the Sparus AUV's dynamics, including its mass and drag matrices, this project aims to optimize its performance under various conditions. The study is crucial for enhancing the AUV's efficiency, stability, and control in underwater environments.

## Project Overview
The Sparus AUV project encompasses several key areas:
- **Dimensional Analysis:** Detailed measurements of the Sparus AUV's body to understand its physical properties.
- **Mass Matrix Computation:** Analysis of the Sparus AUV's global real mass matrix to assess its impact on movement and stability.
- **Added Mass and Drag Matrices:** Evaluation of added mass and drag forces that affect the Sparus AUV's navigation and how these forces are computed to ensure accurate simulation models.
- **Simulator Validation:** Through various experiments, the project validates the simulated model against expected physical behaviors, ensuring that the Sparus AUV's virtual representation closely matches its real-world counterpart.

## Code Structure
The repository is structured into several key components, essential for understanding and replicating the Sparus AUV's simulation:

- `Sparus Calibration.dwg`: An AutoCAD file containing the dimensions of the Sparus AUV.
- `Added Mass and Drag.m`: MATLAB script for calculating the added mass and drag matrices.
- `Parameter.m`: Defines the parameters used in the simulations.
- `RovModel.m`: The main MATLAB script modeling the Sparus AUV.
