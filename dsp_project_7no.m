clear all;
close all;
clc;
[s,fs]=audioread('Final.wav');
frame_length = 1024;
overlap_factor = 0.5;
overlap_samples = frame_length * overlap_factor;
output_signal = zeros(size(s));
for i = 1:frame_length:length(s)
    start_idx = i;
    end_idx = min(i+frame_length-1, length(s));
    frame = s(start_idx:end_idx);
    t = linspace(0, 1, length(frame));
    f0 = 261.63; 
    f1 = 2*f0; 
    f2 = 3*f0;
    A0 = 1;
    A1 = 0.8;
    A2 = 0.6;
    harmonics = A0*sin(2*pi*f0*t) + A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);
    window = hann(length(frame));
    frame = frame .* window;
    frame = frame + harmonics';
    if i == 1
        output_signal(start_idx:end_idx) = frame;
    else
        output_signal(start_idx:end_idx-overlap_samples) = output_signal(start_idx:end_idx-overlap_samples) + frame(1:end-overlap_samples);
        output_signal(end_idx-overlap_samples+1:end_idx) = frame(end-overlap_samples+1:end) + output_signal(end_idx-overlap_samples+1:end_idx);
    end
end
output_signal = output_signal / max(abs(output_signal));
audiowrite('Melodious.wav', output_signal, fs);