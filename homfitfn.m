function [ H ] = homfitfn( matches )
    rhs_point = matches(1:3, :)';
    lhs_point = matches(4:6, :)';
    for i=1:size(rhs_point, 1)
        rhs_point(i, :) = rhs_point(i, :) ./ rhs_point(i, 3);
        lhs_point(i, :) = lhs_point(i, :) ./ lhs_point(i, 3);
    end
 
    [rhs_hom_point, rhs_T] = Normalize2dHomPoints(rhs_point);
    [lhs_hom_point, lhs_T] = Normalize2dHomPoints(lhs_point);
   
    % Compute Ai
    A = [];
    x_lhs = lhs_hom_point(1,:);
    y_lhs = lhs_hom_point(2,:);
    w_lhs = lhs_hom_point(3,:);
    for i=1:size(rhs_hom_point,2)
        A = [A; ...
            zeros(3,1)', -w_lhs(i)*rhs_hom_point(:,i)', ...
            y_lhs(i)*rhs_hom_point(:,i)';  ...
            w_lhs(i)*rhs_hom_point(:,i)', zeros(3,1)', ...
            -x_lhs(i)*rhs_hom_point(:,i)'];
    end
    
    [~, ~, V] = svd(A);
    
    h = reshape(V(:,9),3,3);
    H = (lhs_T\h) * rhs_T;
    
end