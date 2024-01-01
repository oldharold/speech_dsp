function TimeFreq_plot(t,audio,fs)
    
    audio_fft = fft(audio);

    freqfft = (0:(length(audio_fft)/2-1))*(fs/length(audio_fft));
    
    subplot(211);
    plot(t, audio);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    
    subplot(212);
    plot(freqfft, abs(audio_fft(1:length(audio_fft)/2)));
    xlabel('Frequency (Hz)');
    ylabel('|X(f)|');
    grid on;

end