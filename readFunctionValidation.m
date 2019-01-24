function I = readFunctionValidation(filename)
% Resize the flowers images to the size required by the network.
I = imread(filename);
% [p3, p4] = size(I);
%     q1 = 400; %// size of the crop box
%     i3_start = round((p3-q1)/2); % or round instead of floor; using neither gives warning
%     i3_stop = i3_start + q1;
% 
%     i4_start = round((p4-q1)/2);
%     i4_stop = i4_start + q1;

% cim = I(i3_start:i3_stop, i4_start:i4_stop, :);
if ismatrix(I)
    I = cat(3,I,I,I);
end

I = imresize(I, [224 224]);
end