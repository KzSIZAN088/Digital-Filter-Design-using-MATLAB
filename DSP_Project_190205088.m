clc;
close all;
clear all;
[s1,fs1]=audioread('NonOverlapping.wav');
[s2,fs2]=audioread('Final.wav');
t1=linspace(0,length(s1)/fs1,length(s1)); 
t2=linspace(0,length(s2)/fs2,length(s2)); 
nfft=2^nextpow2(length(s1));
f=fs1/2*linspace(0,1,nfft/2+1);
y1=abs(fft(s1,nfft));
figure(1);
plot(f,y1(1:nfft/2+1));
title('Non overlapping Frequncy Domain')
nfft=2^nextpow2(length(s2));
f1=fs1/2*linspace(0,1,nfft/2+1);
y2=abs(fft(s2,nfft));
figure(2);
plot(f1,y2(1:nfft/2+1));
title('Final signal Frequncy Domain')
filter1=designfilt('lowpassfir','PassbandFrequency',2020,'StopbandFrequency',2400,'PassbandRipple',1,'StopbandAttenuation',95,'SampleRate',fs1);
fSignal1=filter(filter1,s2);
nfft1=2^nextpow2(length(fSignal1));
filtered1=fs1/2*linspace(0,1,nfft1/2+1);
y3=abs(fft(fSignal1,nfft1));
figure(4);
subplot(221);
plot(filtered1,y3(1:nfft1/2+1));
title('Guitar')
audiowrite('Guitar.wav',fSignal1,fs1);
filter2=designfilt('bandpassfir','FilterOrder',30,'CutoffFrequency1',3600,'CutoffFrequency2',6400,'SampleRate',fs1);
fSignal2=filter(filter2,s2);
nfft2=2^nextpow2(length(fSignal2));
filtered2=fs1/2*linspace(0,1,nfft2/2+1);
y2=abs(fft(fSignal2,nfft2));
subplot(222);
plot(filtered2,y2(1:nfft2/2+1));
title('Piano')
audiowrite('Piano.wav',fSignal2,fs1);
filter3=designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',9700,'CutoffFrequency2',10000,'SampleRate',fs1);
fSignal3=filter(filter3,s2);
nfft3=2^nextpow2(length(fSignal3));
filtered3=fs1/2*linspace(0,1,nfft3/2+1);
y3=abs(fft(fSignal3,nfft3));
subplot(223);
plot(filtered3,y3(1:nfft3/2+1));
title('Trumpet')
audiowrite('Trumpet.wav',fSignal3,fs1);
filter4=designfilt('highpassfir','PassbandFrequency',15000,'StopbandFrequency',14900,'PassbandRipple',1,'StopbandAttenuation',80,'SampleRate',fs1);
fSignal4=filter(filter4,s2);
nfft4=2^nextpow2(length(fSignal4));
filtered4=fs1/2*linspace(0,1,nfft4/2+1);
y4=abs(fft(fSignal4,nfft4));
subplot(224);
plot(filtered4,y4(1:nfft4/2+1));
title('Violin')
audiowrite('Violin.wav',fSignal4,fs1);
[guitar1,k1]=audioread('Guitar.wav');
[piano1,k2]=audioread('Piano.wav');
carrier_Freq1=5143;
carrier_Freq2=4000;
t=[1:length(guitar1)]';
cs1=cos(2*pi*carrier_Freq1*t);
cs2=cos(2*pi*carrier_Freq2*t);
figure (5)
subplot 311
stem(abs(fft(guitar1.*cs1)))
subplot 312
stem(abs(fft(piano1.*cs2)))
subplot 313
stem(abs(fft(piano1.*cs2+guitar1.*cs1)))



