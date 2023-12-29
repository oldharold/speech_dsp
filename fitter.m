% FIR滤波器设计示例
% 设计一个低通FIR滤波器

% 参数
order = 30;          % 滤波器的阶数
cutoff_frequency = 0.2;  % 截止频率为0.2倍采样频率

% 设计滤波器
b = firl(order, cutoff_frequency);

% 绘制频率响应
freqz(b, 1, 1024, 1000);
title('FIR滤波器频率响应');


