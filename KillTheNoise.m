function CleanData = KillTheNoise(data,fs)

N = length(data);

% shifting mean to 0 : yn'= yn - mean(y) 
data = data - mean(data(1:200));

% pre-emphasis filter : y[n] = x[n] - 0.95 x[n-1]
B = [1 -0.95];
data = filter(B,1,data);

%

WINDOW_SIZE = 350;
NO_OF_WINDOWS = floor(N/350);
windows = [];
for k = 1:NO_OF_WINDOWS
    cur_window = data((k-1) * WINDOW_SIZE + 1 : min(k * WINDOW_SIZE, N));
    cur_window_len = length(cur_window);
    if cur_window_len < WINDOW_SIZE
        cur_window = [cur_window zeros(1, WINDOW_SIZE-cur_window_len)];
    end
    windows = [windows; cur_window];
end

max_avg_energy = 0;
max_avg_energy_window = 1;
for k = 1:NO_OF_WINDOWS
    if(max_avg_energy < sum(windows(k).^2))
        max_avg_energy = sum(windows(k).^2);
        max_avg_energy_window = k;
    end
end
THRESHOLD = max_avg_energy * 0.25;
SB = max_avg_energy_window;
SE = max_avg_energy_window;
total_energy = 0;
no_of_windows = 0;
for k = max_avg_energy_window : NO_OF_WINDOWS 
    total_energy = sum(windows(k).^2) + total_energy;
    no_of_windows = no_of_windows+1;
    avg = total_energy/no_of_windows;
    if (avg < THRESHOLD)     
        break;
    end
    SE = k;
end
total_enery = 0;
no_of_windows = 0;
for k = max_avg_energy_window : -1 : 1
    total_energy = sum(windows(k).^2) + total_energy;
    no_of_windows = no_of_windows+1;
    avg = total_energy/no_of_windows;
    if (avg < THRESHOLD)     
        break;
    end
    SB = k;
end
CleanData = data((SB-1)*WINDOW_SIZE+1:SE*WINDOW_SIZE); 
% plot(data((SB-1)*WINDOW_SIZE+1:SE*WINDOW_SIZE));
