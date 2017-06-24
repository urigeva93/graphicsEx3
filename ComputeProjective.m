% function [TransformedIm] = ComputeProjective(Im, H)
%     Mat = imread(Im);
%     [n,m,k] = size(Mat);
%     TransformedIm = zeros(n, m, k);
%     for i = 1:n
%         for j = 1:m
%             pixel = [i;j;1];
%             newPixel = uint32(H*pixel);
%             TransformedIm(newPixel(1), newPixel(2), :) = Mat(i, j, :);
%         end
%     end
%     TransformedIm = uint8(TransformedIm);
%     imshow(TransformedIm);
% end

function [TransformedIm] = ComputeProjective(Im, H)
    mat = imread(Im);
    tform = projective2d(H);
    TransformedIm = imwarp(mat, tform);
    imshow(TransformedIm);
end