% Part.II Vibration response under the periodic motion
clc; clear all; close all;

% time and frequency domain
m = 20000; % kg
t = 0:0.001:1.5; % sec
f = 0:0.1:10;

% vibration response design
Y = 0.005; % maximum height of runway, m
k = 8e6; % N/m
c = 2e5; % N-s/m
z = c/(2*sqrt(k*m));
wn = sqrt(k/m);

% total vibration response
x_total = zeros(size(t));

for f_idx = 1:length(f)
    w = 2*pi*f_idx;
    x = zeros(size(t));

    for n = 1:2:10 
        r=n*w/wn; % frequency ratio or jth armonic
        phi = atan2(2*z*n*r, 1-r^2); % phase angle    
        bn = -0.02/(n*pi);
        H = 1/k * 1/sqrt((1-r^2)^2+(2*z*r)^2);
        x = x + bn*H*exp(-z*wn*t).*sin(n*w*t - phi);
    end 
    x_total = x_total + x;
end

figure
plot(t, x_total, 'k-', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Total displacement (m)');
legend('Origin deisgn');
title('Total vibration response')
grid on;