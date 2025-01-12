% Part.I FRF for designing
clc; clear all; close all;

% Initial condition
m = 20000; % kg
Y = 0.005; % maximum height of runway, m
f_max = 10; % Hz

% constraints
X_max = 0.01; % m
k_min = 8e6; % N/m
c_max = 2e5; % N-s/m
f = linspace(0, 5*f_max, 1000); % frequency range including constraints, Hz

% new design
k = 8e8; % > k_min
c = 1.5e5; % > c_max
r = 2*pi*f / sqrt(k/m); % frequency ratio regarding f 
z = c/(2*sqrt(k*m));
r = 2*pi*f_max/sqrt(k/m);
T_d = sqrt((1+(2*z*r)^2)/((1-r^2)^2+(2*z*r)^2))    

% New design results
X_new = zeros(size(r));
for i = 1:length(r)
    X_new(i) = Y*calculate_displacement_transmissibility(z,r(i));
end

% Plot FRF and vibration response
figure;
plot(f, X_new,'b-', 'LineWidth', 3);
hold on;
yline(0.01, 'r--', 'Maximum allowed amplitude');
xlabel('Frequency, f (Hz)');
ylabel('Amplitude, X (m)');
legend('New design', 'Limit');
title('Frequency Response Function');
fontsize(15,"points")
grid on;


