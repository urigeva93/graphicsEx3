function [TransformedIm] = ComputeProjective(Im, H)
    Mat = imread(Im);
    [n,m,k] = size(Mat);
    TransformedIm = zeros(n, m, k);
    for i = 1:n
        for j = 1:m
            pixel = [i;j;1];
            newPixel = uint32(H*pixel);
            for p = 1:k
                TransformedIm(newPixel(1), newPixel(2), p) = Mat(i, j, p);
            end
        end
    end
    TransformedIm = uint8(TransformedIm);
    imshow(TransformedIm);
end