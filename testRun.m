clc ;
close all ; 
clear all ; 

load('dataBase.mat','Memo','res') ; 
Let = 5;

good = 0;
total = 0;

for DIGIT = 1:Let
    dirpath = "database\" + int2str(DIGIT) + "\*.m4a*";
    Files = dir(dirpath);
    SZ = floor(0.8 * length(Files));
    for k = SZ+1:length(Files)
        total = total + 1;
        FileName = Files(k).folder + "\" + Files(k).name;
        [data fs] = audioread(FileName);
%         sound(data, fs);
%         cur = kannumfcc(13,KillTheNoise(data),fs);
        t = KillTheNoise(data, fs);
        cur = kannumfcc(13,t',fs);
        tot = zeros(1,Let);
        cnt = zeros(1,Let);
        for i = 1:length(Memo)
            t = Memo{i} ; 
            dist = my_dtw(cur,t) ;
            tot(res(i)) = tot(res(i)) + dist;
            cnt(res(i)) = cnt(res(i)) + 1;
        end
        avg = tot;
        for k = 1:Let
            avg(k) = avg(k)/cnt(k);
        end
        [x digit] = min(avg);
        if (digit == DIGIT) 
            good = good+1;
        end
    end
end
Accuracy = good/total