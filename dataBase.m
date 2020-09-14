clc ; 
clear all ; 
close all ; 

Let = 5;

%%
sz = 0; 
res = [];

for DIGIT = 1:Let
    dirpath = "database\" + int2str(DIGIT) + "\*.m4a*";
    Files = dir(dirpath);
    SZ = floor(0.8 * length(Files));
    for k = 1:SZ
        [data fs] = audioread(Files(k).folder + "\" + Files(k).name);
%         sound(data, fs);
%         pause(1);
        sz = sz+1 ; 
        t = KillTheNoise(data,fs) ; 
        coeff = kannumfcc(13,t',fs) ;
        res = [res DIGIT] ; 
        Memo{sz} = coeff ; 
    end
end

save('dataBase.mat','Memo','res') ; 