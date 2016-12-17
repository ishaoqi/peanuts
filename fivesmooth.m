function smoothdata = fivesmooth(data, info)
%%
% 
%  five points smooth filter
%  data: the original 3-d image data
%  info: the header file of image
%  smoothdata: the reuslt of smooth,3-d image data

    smoothdata = zeros(info.lines,info.samples,info.bands);
    for i = 3:info.bands-2
        smoothdata(:,:,i) = (data(:,:,i-2)./4 + data(:,:,i-1)./2 + data(:,:,i) + ...
            data(:,:,i+2)./4 + data(:,:,i+1)./2)./2.5;
    end
end

   