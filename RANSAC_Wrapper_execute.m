%init parameters for RANSAC_Wrapper
fittingfn = @homfitfn;
distfn = @homdistfn;
degenfn = @homisdegenerate;
t = 30;
s = 4; 
feedback = 0;
maxDataTrials = 100;
maxTrials = 10000;
H_gt = [1 .2 0; .1 1 0; .5 .2 1];
distRatio = 0.5;
image1 = 'bird.pgm';
image2 = 'bird_tranhjmn.pgm';

[ ~, matches, ~ ] = match(image1, image2, distRatio);
H_ransac = RANSAC_Wrapper(matches, fittingfn, distfn, degenfn, s, t, feedback, maxDataTrials, maxTrials);
%[ pnts_gt, pnts_computed ] = ComputeTestPoints(H_gt, H_ransac);
%[error] = ComputeError(pnts_gt, pnts_computed) / 100;

new_im_ransac = ComputeProjective(image1, H_ransac); 
imshow(new_im_ransac);