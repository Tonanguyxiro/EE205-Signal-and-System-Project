function yn = tone_vocoder(N, Freq_low, Freq_high, Freq_sample, Freq_filter, sample)
    % divide the frequency
    Freq_cochlea = cochlea(Freq_low, Freq_high, N);
    yn = zeros(length(sample))

    for band_index = 1:N
        band = [Freq_cochlea[band_index] Freq_cochlea[band_index+1]]

        % Design band-pass filter at band i
        band_pass = butter(4, band/(Freq_sample/2));
        
        % Do band-pass filtering at band i
        sample_band = filter(band_pass, sample);

        % Do full-wave rectification
        % apply low-pass filtering to get the envelope at band i
        low_pass = butter(2, Freq_filter/(Freq_sample/2), 'low');
        filtered_sample_band = filter(low_pass, sample_band)

        % Generate a sinewave, whose frequency equals to the center frequency of the i-th bandpass filter
        fm = (band[1]+band[2])/2
        xn = 1:length(sample)
        sin_wave = sin(2*pi*fm*xn/Freq_sample)

        % Multiply the envelope signal and sinewave
        yn = yn + sin_wave .* filtered_sample_band
    end

    yn = yn/norm(yn)*norm(sample);
    yn = yn.';
    

end