function yn = tone_vocoder(N, Freq_low, Freq_high, Freq_sample, Freq_filter, sample)
    % divide the frequency
    Freq_cochlea = cochlea(Freq_low, Freq_high, N);
    yn = 0:length(sample)-1;
    yn = yn * 0;

    for band_index = 1:N
        band = [Freq_cochlea(band_index) Freq_cochlea(band_index+1)]

        % Design band-pass filter at band i
        [a1, b1] = butter(4, band/(Freq_sample/2));
        
        % Do band-pass filtering at band i
        sample_band = filter(a1, b1, sample);
        freqz(a1, b1)
        % Do full-wave rectification
        % apply low-pass filtering to get the envelope at band i
        [a2, b2] = butter(2, Freq_filter/(Freq_sample/2), 'low');
        
        filtered_sample_band = filter(a2, b2, sample_band);
        freqz(a2, b2);
        % Generate a sinewave, whose frequency equals to the center frequency of the i-th bandpass filter
        fm = (band(1)+band(2))/2;
        xn = 1:length(sample);
        sin_wave = sin(2*pi*fm*xn/Freq_sample);
        
        % Multiply the envelope signal and sinewave
        yn = yn + sin_wave .* filtered_sample_band
       
    end

    yn = yn/norm(yn)*norm(sample);
    yn = yn.';
    

end