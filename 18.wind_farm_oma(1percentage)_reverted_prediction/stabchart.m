function [fst, xist] = stabchart(fp, xip, fmin1, ximin1, yfrf, ip, ...
f, fst, xist, ff, xixi, mathp, istab, p)

% fst= fn; xist=xin;
        
% [fst, xist] = stabchart(fp, xip, fmin1, ximin1, yfrf, ip, ...
% f, fst, xist, ff, xixi, mathp, istab, p)
% Stabilization chart to extract stable poles in frequency and damping
%
% fp and xip        frequency and damping identified before poles selection
%                   at iteration p
% fmin1 and ximin1  frequency and damping identified at iteration p-1
% yfrf              amplitude in dB, yfrf = 20*log10(abs(frf))
% ip                iteration index
% f                 frequency vector in Hz
% fst               frequency of stables poles in frequency and damping (s)
% xist              damping of stable poles in frequency and damping (s)
% ff                frequency of stable poles in frequency (f)
% xixi              frequency of stable poles in damping (d)
% mathp             frequency of mathematical poles (o)
% p                 identification order
%
% fst and xist      frequency in Hz and modal damping factor of stable poles in
%                   frequency and damping

tolf = 0.01 ;
told = 0.25 ;

fmax = max(f) ;
fmin = min(f) ;
nfp = length(fp) ;
if length(fmin1) > 0
    for ifp = 1:nfp
        if (fp(ifp) < fmax) && (fp(ifp) > fmin)
            [diff_fp, idiff_fp] = min(abs(fp(ifp)-fmin1) / fp(ifp)) ;
            diff_xip = abs(xip(ifp)-ximin1) / xip(ifp) ;
            
            if (diff_fp <= tolf) && (diff_xip(idiff_fp) <= told)
                fst = [fst; fp(ifp)] ;
                xist = [xist xip(ifp)] ;
%                 
            elseif (diff_fp <= tolf) && (diff_xip(idiff_fp) > told)
                ff = [ff; fp(ifp)] ;
                
            elseif (diff_fp > tolf) && (diff_xip(idiff_fp) <= told)
                xixi = [xixi; fp(ifp)] ;
                
            elseif (diff_fp > tolf) && (diff_xip(idiff_fp) > told)
                mathp = [mathp; fp(ifp)] ;
            end
        end
    end
end
% figure(1)
% if length(fst) > 0
%     text(fst, (min(yfrf)+istab*ip)*ones(length(fst), 1), 's', 'Color', 'b')
% end  
% if length(ff) > 0
%     text(ff, (min(yfrf)+istab*ip)*ones(length(ff), 1), 'f', 'Color', 'g')
% end    
% if length(xixi) > 0
%     text(xixi, (min(yfrf)+istab*ip)*ones(length(xixi), 1), 'd', 'Color', 'r')
% end   
% if length(mathp) > 0
%     text(mathp, (min(yfrf)+istab*ip)*ones(length(mathp), 1), 'o', 'Color', 'c')
% end

% add gorizontal line at each order
% line([fmin, fmax], (min(yfrf)+istab*ip)*[1, 1], ...
% 'Color', [0.8, 0.8, 0.8],'HandleVisibility','off')
% add order on the right
% if mod(p,1)==0
%     text(fmax, min(yfrf)+istab*ip, num2str(p))
% end
% title('Stabilization chart')
    

