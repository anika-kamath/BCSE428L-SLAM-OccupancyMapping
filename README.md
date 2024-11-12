# BCSE428L-SLAM-OccupancyMapping

## Description

Implementation of Software Simulation as a part of the Digital Assignments for the course BCSE306L - Artificial Intelligence
- Review 1: Includes PPT for Initial Review
- Review 2: 2D Occupancy Mapping and Real Time Drone Position Visualization
- Review 3: 3D Occupancy Mapping using Depth and Error Measurement to Calculate a Real-Time Occupancy Map

## Overview

### Review 1
These two code snippets simulate two different approaches to 2D mapping and localization for an autonomous drone:

### 1: 2D Occupancy Grid Mapping with SLAM Loop
This first snippet simulates a **2D occupancy grid-based SLAM** approach where a drone moves around a grid and uses sensor data (simulated LIDAR) to identify obstacles and free space. Here's a breakdown of its key parts:

1. **Initialization**: The code sets up a grid (occupancy map) of size `50x50`, where the drone starts at the center (`[25, 25]`). Obstacles are manually placed in the grid at specified positions.

2. **Sensor Model**: A simulated LIDAR sensor with a limited range (5 units) is set up to detect obstacles. The LIDAR scans in a 360-degree circle around the drone to identify nearby obstacles.

3. **Movement Model**: The drone can randomly move one step at a time in one of four directions (right, down, left, up) while staying within the grid bounds.

4. **SLAM Loop**:
   - The drone moves to a new position and simulates LIDAR sensor readings in various directions.
   - If the sensor detects an obstacle (cell with a value of `0`), the scan stops for that direction. Otherwise, the cell is marked as explored with a `0.5` value.
   - After each step, the occupancy grid is updated, and the drone’s path and surroundings are visualized in real time.

**Outcome**: Over time, the occupancy grid fills with explored cells, showing the drone’s path and nearby detected obstacles, providing a basic environment map.

### 2: SLAM Process with Random Features and Path Mapping
The second snippet focuses on **Simultaneous Localization and Mapping (SLAM)** with feature-based mapping in an open, continuous 2D space. Here’s how it works:

1. **Initialization**: An empty map and the drone’s starting position at `[0; 0]` are initialized. Random features (points of interest) are distributed across an environment of size `50x50`.

2. **Simulating Sensor Data**: Random features are detected by the drone as it moves, with noise added to simulate real-world sensor inaccuracies.

3. **Simulate SLAM Process**:
   - The drone’s movement follows a random walk, with small random changes in position (`sigma_process`) representing movement noise.
   - Sensor readings detect the distances to the features, with some measurement noise (`sigma_measurement`). If a feature is within a certain range (10 units), it is considered visible to the drone.
   - Detected features are added to the SLAM map, updating as the drone moves.

4. **Visualization**: Each frame updates the plot, showing:
   - `kx`: Actual positions of true features (ground truth).
   - `ro`: Estimated positions of features detected by the drone (SLAM map).
   - `b-`: The path traced by the drone as it explores.

**Outcome**: The result is a dynamic SLAM map of detected features, tracking the drone’s path and estimated positions of environmental features, despite process and measurement noise.

### Summary
The **first snippet** builds a **grid-based occupancy map** to identify free and occupied spaces with discrete cells. In contrast, the **second snippet** uses **feature-based SLAM**, focusing on recognizing and mapping features (landmarks) in continuous 2D space, allowing it to estimate the drone’s position and path while mapping these landmarks. Both snippets provide simplified versions of SLAM suitable for autonomous drones navigating in 2D.


## Software Used

- Matlab Simulink

## Features

- 

## Prerequisites

- MATLAB and Simulink Installed.

## Usage

1. Clone this repository to your local machine:
   ```
   git clone https://github.com/anika-kamath/BCSE428L-SLAM-OccupancyMapping.git
   ```

2. For Review 2 Files
   ```
   On MATLAB Command Line, run
   DronePosition2D
   ```
   ```
   On MATLAB Command Line, run
   SLAMMapandDronePath2D
   ```
3. For Review 3 Files
   ```
   On MATLAB Command Line, run
   Parameters
   ```
   ```
   sim('OccupancyGridSimulation)
   ```


## Credits 

- 21BRS1296 - Anika Kamath
- 21BRS1026 - Charvi Mishra
- 21BRS1031 - Kshitija Sharma

