% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of feature descriptors for a given set of interest points. 

% 'image' can be grayscale or color, your choice.
% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
%   The local features should be centered at x and y.
% 'descriptor_window_image_width', in pixels, is the local feature descriptor width. 
%   You can assume that descriptor_window_image_width will be a multiple of 4 
%   (i.e., every cell of your local SIFT-like feature will have an integer width and height).
% If you want to detect and describe features at multiple scales or
% particular orientations, then you can add input arguments.

% 'features' is the array of computed features. It should have the descriptor_window_image_width
%   following size: [length(x) x feature dimensionality] (e.g. 128 for
%   standard SIFT)

function [features] = get_descriptors(image, x, y, descriptor_window_image_width)
f = descriptor_window_image_width/2;
f1 = descriptor_window_image_width/4;
s = size(x);
si = size(image); 
image_rows = si(1);
image_cols = si(2);
features = zeros(s(1),128);

%Rotating the Sobel Filter 
filt = [];
m = fspecial('sobel'); 
filt(:,:,1) = m;
for i=2:8 
    m = [m(4) m(7) m(8); m(1) m(5) m(9); m(2) m(3) m(6)];
    filt(:,:,i) = m;
end

%Constructing New Image
image_size = size(image);
new_img = zeros(image_size(1),image_size(2),8); 
for i=1:8 
    new_img(:,:,i) = imfilter(image,filt(:,:,i)); 
end
blur = fspecial('gaussian', [descriptor_window_image_width/2, descriptor_window_image_width/2], descriptor_window_image_width / 2);
new_img = imfilter(new_img,blur);

for i=1:s(1)
    y_coord = uint16(y(i));
    x_coord = uint16(x(i));     
    x_l = x_coord-f;
    x_r = x_coord+f-1;
    y_top = y_coord-f;
    y_bot= y_coord+f-1;
    bins = zeros(1,128);
    if x_l >= 1 && x_r <= image_cols-f && y_top >=1 && y_bot <= image_rows-f  
        for j=1:8
        	image = new_img(:,:,j); 
            patch = image(y_top:y_bot, x_l:x_r);
            small_square = mat2cell(patch,[f1,f1,f1,f1], [f1,f1,f1,f1]);
            c = j;
            for row=1:4 
                for column=1:4
                    cell = cell2mat(small_square(row,column));
                    value = sum(cell(:));
                    bins(:,c) = value;
                    c = c+8;
                end
            end
        end 
        bins = bins./norm(bins);
        features(i,:) = bins(1,:); 
    end
end 
end








