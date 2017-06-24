distRatio = 0.5;
image1 = 'bird.pgm';
image2 = 'bird_tran.pgm';
[ ~, matches, ~ ] = match(image1, image2, distRatio);
random_matches = matches;
for i=size(matches, 1):size(matches, 1)+20
    random_matches(i, :) = [512, 512, 512, 512];
end
fittingfn = @homfitfn;
distfn = @homdistfn;
degenfn = @isdegenerate;
t = 30;
s = 4; 
feedback = 0;
maxDataTrials = 100;
maxTrials = 10000;

H_ransac = RANSAC_Wrapper(random_matches, fittingfn, distfn, degenfn, s, t, feedback, maxDataTrials, maxTrials);
[ pnts_gt, pnts_computed ] = ComputeTestPoints(H_gt, H_ransac);
error_ransac = ComputeError(pnts_gt, pnts_computed) / 100;

H_comp = DLT(random_matches); new_im_comp = ComputeProjective(Im, H_comp); 
[ pnts_gt, pnts_computed ] = ComputeTestPoints(H_gt, H_comp);
error_dlt = ComputeError(pnts_gt, pnts_computed) / 100;
    
new_im_ransac = ComputeProjective(Im, H_ransac); 