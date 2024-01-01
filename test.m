filename = 'keyboad-typing.wav';
[audio, fs] = audioread(filename); 
t = (0:(length(audio)-1))*(1/fs);

% Designing a low-pass filter
fp1 = 1000; % Passband frequency in Hz
fs1 = 1200; % Stopband frequency in Hz
rp1 = 1;    % Passband ripple in dB
rs1 = 100;  % Stopband attenuation in dB

% Calculate digital frequencies
wp1 = 2*pi*fp1/fs;
ws1 = 2*pi*fs1/fs;

% Design the elliptic filter
[N1, wpo1] = ellipord(wp1, ws1, rp1, rs1, 's');
[B1, A1] = ellip(N1, rp1, rs1, wpo1, 's');

% Convert the analog filter to a digital filter using bilinear transformation
[Bz1, Az1] = bilinear(B1, A1, fs);


