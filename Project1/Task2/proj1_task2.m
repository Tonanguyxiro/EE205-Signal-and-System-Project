% Project 1, Task 2, Task 3
% load
[samples, Freq_sample] = audioread('C_01_01.wav');

% define
lpf = [20 50 100 400];
Freq_low = 200;
Freq_high = 7000;

% Set the number of bands N=4
N = 4;

figure();
hold on

for i in 1:length(lpf):
    yn = tone_vocoder(N, Freq_low, Freq_high, Freq_sample, lpf[i], sample)
    yn = fftshift(fft(yn));
    yn_abs = abs(yn);

    %plot yn_abs
    subplot(4, 1, i);
    xn = linspace(-Freq_sample/2, Freq_sample/2, length(sample))
    plot(xn, yn_abs);
    title(sprintf('N = 4, f_{lpf}=%d Hz, Tone Vocoder',lpf(i)))

    xlabel('Frequency(Hz)');ylabel('Magnitude');
    audiowrite(sprintf('task2_N=4_lpf=%d.wav',lpf(n)),yn,Freq_sample);
    saveas(figure1,sprintf('task2_lpf%d.png',lpf(i)));

    grid on

end

