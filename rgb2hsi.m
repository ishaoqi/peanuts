function hsi = rgb2hsi(rgb)
%%
% 
%  GRBÍ¼Ïñ×ª»»ÎªHSIÍ¼Ïñ
%  rgb£ºÈı²¨¶ÎµÄ²ÊÉ«Í¼Ïñ
% 

rgb = im2double(rgb);
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);

% ??????
num = 0.5*((r - g) + (r - b));
den = sqrt((r - g).^2 + (r - b).*(g - b));
theta = acos(num./(den + eps)); %?????0

H = theta;
H(b > g) = 2*pi - H(b > g);
H = H/(2*pi);

num = min(min(r, g), b);
den = r + g + b;
den(den == 0) = eps; %?????0
S = 1 - 3.* num./den;

H(S == 0) = 0;

I = (r + g + b)/3;

% ?3?????????HSI??
hsi = cat(3, H, S, I);