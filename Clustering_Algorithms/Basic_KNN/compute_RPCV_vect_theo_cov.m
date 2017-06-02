function [ dist_mat ] = compute_RPCV_vect_theo_cov(VXTrain, VXTest, norm_XTrain, norm_XTest)
  
  % Approach this differently

  % Here, we plug in the ordinary estimate of inner product
  est_IP = VXTrain * VXTest';
  
  est_norm1 = repmat(sum(VXTrain.^2,2), 1, size(VXTest,1));
  est_norm2 = repmat(sum(VXTest.^2,2)', size(VXTrain,1),1);

  % and the ED
  orig_ED = est_norm1 + est_norm2  - 2 *est_IP;
  
  % Compute CV  
  m1_mat = repmat(norm_XTrain,1,size(VXTest,1));
  m2_mat = repmat(norm_XTest',size(VXTrain,1),1);

  % Use Li's estimated IP
  [ IP_vals ] = li_vectorized_NR_mat_version_IP( est_IP, est_norm1, est_norm2, m1_mat, m2_mat);
  
  c_vec_li = ((m1_mat - IP_vals).^2 + (m2_mat - IP_vals).^2)./(m1_mat.^2 + m2_mat.^2 + 2*IP_vals.^2 );
  %c_vec_est_1 = ((m1_mat - est_IP).^2 + (m2_mat - est_IP).^2)./(m1_mat.^2 + m2_mat.^2 + 2*est_IP.^2 );
  %c_vec_orig = ((est_norm1 - est_IP).^2 + (est_norm2 - est_IP).^2)./(est_norm1.^2 + est_norm2.^2 + 2*est_IP.^2);

  dist_mat =  sqrt(abs(orig_ED - c_vec_li.*(est_norm1 + est_norm2 - m1_mat - m2_mat)));

end

