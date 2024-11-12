% SLAM for Autonomous Drones in a 2D Grid

% 1. Initialize parameters
mapSize = 50;  % Define the size of the map
map = ones(mapSize); % Initialize a map (occupancy grid)

% Drone's initial position
dronePos = [25, 25];  % Starting at the center of the grids
% 2. Sensor model (simulated LIDAR)
lidarRange = 5;  % Maximum distance the sensor can detect obstacles

% 3. Simulate environment with some obstacles
obstacles = [
    10 10;
    40 40;
    30 15;
    15 35];  % Predefined obstacle positions

for i = 1:size(obstacles, 1)
    map(obstacles(i,1), obstacles(i,2)) = 0;  % Mark obstacles as occupied
end

% Visualize the initial map
figure;
imagesc(map);  % Plot the occupancy grid
title('Initial Environment Map');
colormap(gray);  % Use grayscale to represent free/occupied space

% 4. Movement model (simulated drone movement)
movementSteps = [
    0 1;  % Move right
    1 0;  % Move down
    0 -1; % Move left
    -1 0]; % Move up

% SLAM loop
for step = 1:20  % Simulate 20 movements
    % Simulate random movement
    movement = movementSteps(randi([1, 4]), :);
    newPos = dronePos + movement;
    
    % Make sure the drone stays within the bounds of the map
    newPos = max(min(newPos, mapSize), 1);

    % Update drone position
    dronePos = newPos;
    
    % Simulate sensor readings (LIDAR)
    for angle = 0:pi/4:2*pi  % Simulate readings in different directions
        for r = 1:lidarRange
            % Compute the sensor's ray (in polar coordinates)
            scanPos = round(dronePos + r * [cos(angle), sin(angle)]);
            
            % Make sure the scan is within map bounds
            if all(scanPos > 0 & scanPos <= mapSize)
                if map(scanPos(1), scanPos(2)) == 0  % If obstacle detected
                    break;  % Stop the scan at the obstacle
                else
                    % Update the map based on the sensor data
                    map(scanPos(1), scanPos(2)) = 0.5;  % Mark as explored
                end
            end
        end
    end
    
    % Visualize updated map
    imagesc(map);
    hold on;
    plot(dronePos(2), dronePos(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);  % Plot drone
    hold off;
    title(sprintf('Drone Position: [%d, %d]', dronePos(1), dronePos(2)));
    pause(0.5);  % Pause for visualization
end
