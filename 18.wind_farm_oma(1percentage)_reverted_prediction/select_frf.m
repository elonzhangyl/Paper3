function [w1, frf1] = select_frf(w0, frf0, f_start, f_end)
% w0 = w; frf0=frf; f_start=0; f_end=10;
% [w1, frf1] = select_frf(w0, frf0, f_start, f_end)
% selects FRF between f_start and f_end
%
% w0       natural frequency vector in rad/s
% frf0     complex frequency response function vector
% f_start  start frequency
% f_end    end frequency
%
% w1       natural frequency vector in rad/s between w_start = 2*pi*f_start and
%          w_end = 2*pi*f_end
% frf1     complex frequency response function vector between f_start and f_end

f0 = w0/(2*pi) ;
[diff_start, i_start] = min(abs(f0-f_start)) ;
[diff_end, i_end] = min(abs(f0-f_end)) ;
w1 = w0(i_start:i_end) ;
frf1 = frf0(i_start:i_end) ;

