clc ;
close all ; 
clear all ; 

load('dataBase.mat','Memo','res') ; 
let = 5 ; 
% disp('record now');
% 
% recorder = audiorecorder(48000,16,2);
% recordblocking(recorder,2);
% audioarray = getaudiodata(recorder);
% 
% disp('stop record');
[data fs] = audioread('1(6).m4a') ; 
%data=audioarray;
sound(data,fs) ; 

cur = kannumfcc(13,KillTheNoise(data),fs) ; 

tot = zeros(1,let) ; 

for i = 1:25
    t = Memo{i} ; 
    dist = my_dtw(cur,t) ;
    tot(res(i)) = tot(res(i)) + dist ; 
end
avg = tot/5 ;
[x digit] = min(avg) ;
avg , digit