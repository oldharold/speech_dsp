[audio, fs] = audioread('recorded_audio.wav');


t = (0:(length(audio)-1))*(1/fs);  % Corrected variable name 'xsteady' to 'steady'

% Find FFT size to avoid time aliasing
Nfft = 2^nextpow2(length(audio));

% Positive FFT frequencies, exploiting symmetry of real signal
freqfft = (0:(Nfft/2-1))*(fs/Nfft);

audio_fft = fft(audio, Nfft);


% Compute spectrograms
Nspec = 256;
wspec = hamming(Nspec);
Noverlap = Nspec/2;
[Ssteady, fspec, tspec] = spectrogram(audio, wspec, Noverlap, Nspec, fs);

% Plot

subplot(211);  
plot(t,audio);
xlabel( 't (s)');
ylabel('A');


subplot(212)
plot(freqfft, abs(audio_fft(1:Nfft/2)));
xlabel('Frequency (Hz)')
ylabel('|X(f)|')


