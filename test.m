%% 
Files = dir("database\1\*.m4a*");
FileName = Files(1).folder + "\" + Files(1).name;
[audio_in,audio_freq_sampl]= audioread(FileName);
plot(audio_in);
KillTheNoise(audio_in);

%% 
sound(audio_in, audio_freq_sampl);
B = [1 -0.95];
audio_in = filter(B,1,audio_in);
pause(2);
sound(10*audio_in, audio_freq_sampl);
Length_audio=length(audio_in);
df=audio_freq_sampl/Length_audio;
frequency_audio=-audio_freq_sampl/2:df:audio_freq_sampl/2-df;
figure
FFT_audio_in=fftshift(fft(audio_in))/length(fft(audio_in));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
