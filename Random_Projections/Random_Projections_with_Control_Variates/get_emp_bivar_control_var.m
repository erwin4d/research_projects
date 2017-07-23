function [ mvn2d_est ] = get_emp_bivar_control_var(ests, currV, kvec, kvals, typeof)


  v1_norm_four = repmat(sum(currV.V1(:,1:kvec(kvals)).^4,2), 1, ests.n2);
  v2_norm_four = repmat(sum(currV.V2(:,1:kvec(kvals)).^4,2)', ests.n1, 1);



  if strcmp(typeof, 'squared_euclidean_distance')
    
    estimate_to_use = ests.small_euc_dist;
    cov_numer1 = v1_norm_four + v2_norm_four + 2*currV.V1(:,1:kvec(kvals)).^2 * currV.V2(:,1:kvec(kvals)).^2' - 2*currV.V1(:,1:kvec(kvals)).^3*currV.V2(:,1:kvec(kvals))' - 2*currV.V1(:,1:kvec(kvals)) * currV.V2(:,1:kvec(kvals)).^3' -  ((ests.small_v2norm + ests.small_v1norm) .* ((ests.small_v2norm + ests.small_v1norm) - 2*ests.small_v1v2));
    
  elseif strcmp(typeof, 'inner_product')

    estimate_to_use = ests.small_v1v2;

    cov_numer1 = currV.V1(:,1:kvec(kvals)).^3 * currV.V2(:,1:kvec(kvals))' + currV.V1(:,1:kvec(kvals)) * currV.V2(:,1:kvec(kvals)).^3' - (ests.small_v2norm + ests.small_v1norm) .* ests.small_v1v2; 

  end

  cov_denom1 = v1_norm_four + v2_norm_four +  2 * currV.V1(:,1:kvec(kvals)).^2 * currV.V2(:,1:kvec(kvals)).^2' - (ests.small_v1norm + ests.small_v2norm).^2;

  mvn2d_c_hat = cov_numer1./cov_denom1;
  mvn2d_est = estimate_to_use - mvn2d_c_hat .* (ests.small_v1norm + ests.small_v2norm - 2);    
   

end

