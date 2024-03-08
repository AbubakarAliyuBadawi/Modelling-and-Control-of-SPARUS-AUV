%% Initial Graph 
T = 0:0.01:10;

 colororder([1 0 0; 0 1 0; 0 0 1]);

% figure(1)
% subplot(3, 1, 1)
% plot(T, PosE(:, 1), T, PosE(:, 2), T, PosE(:, 3));
% title("Earth Position")
% ylabel("Position(m)")
% xlabel("Time(s)")
% legend("Surge", "Sway", "Heave")
% grid on

subplot(3, 1, 2)
plot(T, VitG(:, 1), T, VitG(:, 2), T, VitG(:, 3) )
title("Body Velocity")
ylabel("Velocity (m/s)")
xlabel("Time (s)")
legend("Surge", "Sway", "Heave")
grid on

subplot(3, 1, 3)
plot(T, AccG(:, 1), T, AccG(:, 2), T, AccG(:, 3))
title("Body Acceleration")
ylabel("Acceleration (m/s2)")
xlabel("Time (s)")
legend("Surge", "Sway", "Heave")
alpha 0.05
grid on

figure(2)
subplot(3, 1, 1)
plot(T, PosE(:, 4), T, PosE(:, 5), T, PosE(:, 6))
title("Earth Orientation")
ylabel("Orientation (rad)")
xlabel("Time (s)")
legend("Roll", "Pitch", "Yaw")
grid on

subplot(3, 1, 2)
plot(T, VitG(:, 4), T, VitG(:, 5), T, VitG(:, 6) )
title("Body Angular Velocity")
ylabel("Angular Velocity (rad/s)")
xlabel("Time (s)")
legend("Roll", "Pitch", "Yaw")
grid on

subplot(3, 1, 3)
plot(T, AccG(:, 4), T, AccG(:, 5), T, AccG(:, 6))
title("Body Angular Acceleration")
ylabel("Angular Acceleration (rad/s2)")
xlabel("Time (s)")
legend("Roll", "Pitch", "Yaw")
alpha 0.05
grid on
% 

figure(3)
subplot(1, 2, 1)
plot(PosE(:, 1), PosE(:, 2), '-b')
xlabel("Position X")
ylabel("Position Y")
title("XY Trajectory")
axis equal
daspect([1, 1, 1])
grid on

subplot(1, 2, 2)
plot(T, PosE(:, 3), '-b')
set(gca, 'YDir','reverse')
xlabel("Time")
ylabel("Position Z")
title("Depth Trajectory")
grid on
%}

%% Overlapping for clean data

T = 0:0.01:10;

 colororder([1 0 0; 0 1 0; 0 0 1]);

figure(1)
subplot(3, 1, 1)
plot(T, PosE_S(:, 1), T, PosE_S(:, 2), T, PosE_S(:, 3));
title("Earth Position")
ylabel("Position(m)")
xlabel("Time(s)")
legend("Surge", "Sway", "Heave")
grid on

subplot(3, 1, 2)
plot(T, VitB_S(:, 1), T, VitB_S(:, 2), T, VitB_S(:, 3) )
title("Body Velocity")
ylabel("Velocity (m/s)")
xlabel("Time (s)")
legend("Surge", "Sway", "Heave")
grid on

subplot(3, 1, 3)
plot(T, AccB_S(:, 1), T, AccB_S(:, 2), T, AccB_S(:, 3))
title("Body Acceleration")
ylabel("Acceleration (m/s2)")
xlabel("Time (s)")
legend("Surge", "Sway", "Heave")
alpha 0.05
grid on

figure(2)
subplot(3, 1, 1)
plot(T, PosE_S(:, 4), T, PosE_S(:, 5), T, PosE_S(:, 6))
title("Earth Orientation")
ylabel("Orientation (rad)")
xlabel("Time (s)")
legend("Roll", "Pitch", "Yaw")
grid on

subplot(3, 1, 2)
plot(T, VitB_S(:, 4), T, VitB_S(:, 5), T, VitB_S(:, 6) )
title("Body Angular Velocity")
ylabel("Angular Velocity (rad/s)")
xlabel("Time (s)")
legend("Roll", "Pitch", "Yaw")
grid on

subplot(3, 1, 3)
plot(T, AccB_S(:, 4), T, AccB_S(:, 5), T, AccB_S(:, 6))
title("Body Angular Acceleration")
ylabel("Angular Acceleration (rad/s2)")
xlabel("Time (s)")
legend("Roll", "Pitch", "Yaw")
alpha 0.05
grid on

figure(3)
subplot(1, 2, 1)
plot(PosE_S(:, 1), PosE_S(:, 2), '-b')
xlabel("Position X")
ylabel("Position Y")
title("XY Trajectory")
axis equal
daspect([1, 1, 1])
grid on

subplot(1, 2, 2)
plot(T, PosE_S(:, 3), '-b')
set(gca, 'YDir','reverse')
xlabel("Time")
ylabel("Position Z")
title("Depth Trajectory")
grid on


