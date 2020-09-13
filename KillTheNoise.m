function CleanData = KillTheNoise(data,fs)
N = 1024;  % frame size 
M = 500;   % distance between two consecutive frame

% Splitting the audio into frames and deleting unimportant ones
nOfFrames = ceil((length(data)-N)/M);
threshold = 0.1 ;
energyThreshold = N*0.002*0.002 ; 
CleanData = [] ;
good = zeros(1,length(data)) ; 

%  plot(data) ; 
%  R = [] ;  n = [] ;
for i = 0:nOfFrames-1
    temp = data(i*M+1:i*M+N) ;
    FFT = abs( fft(temp',2048) ) ;
    AM = mean(FFT) ; 
    GM = geomean(FFT) ; 
    Ratio = 10*log10(GM/AM) ;
    
    if (max(temp) < threshold && var(temp) < energyThreshold) 
        continue ;
    end
%     n = [n i*M+1] ; 
%     R = [R,Ratio] ;
    good(i*M+1:i*M+N) = 1 ;
end
% 
% figure , stem(n,R) ; 

for i = 1:length(data)
     if (good(i) == 1)
         CleanData = [CleanData ; data(i)] ;
     end
end

CleanData = CleanData' ; 
CleanData = [CleanData ; CleanData] ; 
CleanData = CleanData' ;
% 
% sound(CleanData,fs);

