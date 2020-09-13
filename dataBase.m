clc ; 
clear all ; 
close all ; 


%%
sz = 0 ; 
res = [] ; 

for i = 1:5
    for j = 1:5
        sz = sz+1 ; 
        [data fs] = audioread(sprintf('%d(%d).m4a',i,j)) ;
        t = KillTheNoise(data,fs) ; 
        coeff = kannumfcc(13,t,fs) ;
        res = [res i] ; 
        Memo{sz} = coeff ; 
    end
end

save('dataBase.mat','Memo','res') ; 