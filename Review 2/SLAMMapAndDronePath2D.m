% Initialize parameters map building
numFrames = 100; % Number of frames to simulate
map = []; % Initialize an empty map
pose = [0; 0]; % Initialize drone's position
poses = pose; % To store all positions (path)
sigma_process = 0.1; % Process noise
sigma_measurement = 0.05; % Measurement noise

% Simulate Sensor Data (for simplicity, generate random features in the environment)
environmentSize = 50;
features = environmentSize * rand(2, 50); % 50 random features in the environment

% Visualization setup
figure;
hold on;
axis equal;
xlim([0 environmentSize]);
ylim([0 environmentSize]);

% Simulate SLAM Process
for frame = 1:numFrames
    % Simulate drone motion (random walk)
    delta_pose = [randn * sigma_process; randn * sigma_process];
    pose = pose + delta_pose;
    poses = [poses, pose];
    
    % Simulate sensor measurements (distances to features with noise)
    distances = sqrt(sum((features - pose).^2, 1)) + randn(1, size(features, 2)) * sigma_measurement;
    
    % Feature detection (threshold on distance to detect nearby features)
    visible_features = features(:, distances < 10);
    
    % Add detected features to the map (simple 2D point-based map)
    map = [map, visible_features];
    
    % Visualize the process
    plot(features(1, :), features(2, :), 'kx'); % True feature locations
    plot(map(1, :), map(2, :), 'ro'); % SLAM map
    plot(poses(1, :), poses(2, :), 'b-', 'LineWidth', 2); % Drone path
    pause(0.1);
end

title('SLAM Map and Drone Path');
legend('True Features', 'SLAM Map', 'Drone Path');
