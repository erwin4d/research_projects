function [V_EDPair1, V_EDPair2, V_IPPair1, V_IPPair2, V_eig_vecs, V_rand_vecs] = create_rpcv_types_of_V( EDPair1, EDPair2, IPPair1, IPPair2, eig_vecs, rand_vecs, num_para, k_max, num_mats, Had)

  % Initialize them:
  V_EDPair1 = zeros(size(EDPair1,1), k_max, num_mats);
  V_EDPair2 = zeros(size(EDPair2,1), k_max, num_mats);
  V_IPPair1 = zeros(size(IPPair1,1), k_max, num_mats);
  V_IPPair2 = zeros(size(IPPair2,1), k_max, num_mats);
  V_eig_vecs = zeros(size(eig_vecs,1), k_max, num_mats);
  V_rand_vecs = zeros(size(rand_vecs,1), k_max, num_mats);

  % Gotta do matrix mult

  X = [EDPair1 ; EDPair2 ;IPPair1 ; IPPair2 ; eig_vecs ; rand_vecs ];

  V_norm = gen_typeof_V(X, k_max, 'option', 'normal');
  V_bin = gen_typeof_V(X, k_max, 'option', 'binary');
  V_SB5 = gen_typeof_V(X, k_max, 'option', 'SB', 'opt_para', 5);
  V_SB10 = gen_typeof_V(X, k_max, 'option', 'SB', 'opt_para', 10);
  V_SRHT = gen_typeof_V(X, k_max, 'option', 'SRHT', 'opt_para', Had);

  % Oh blah
  % In retrospect ; probably should write a loop
  V_EDPair1(:,:,1) = V_norm(1:11,:);
  V_EDPair2(:,:,1) = V_norm(12:22,:);
  V_IPPair1(:,:,1) = V_norm(23:33,:);
  V_IPPair2(:,:,1) = V_norm(34:44,:);
  V_eig_vecs(:,:,1) = V_norm(45:46,:);  
  V_rand_vecs(:,:,1) = V_norm(47:48,:);  

  V_EDPair1(:,:,2) = V_bin(1:11,:);
  V_EDPair2(:,:,2) = V_bin(12:22,:);
  V_IPPair1(:,:,2) = V_bin(23:33,:);
  V_IPPair2(:,:,2) = V_bin(34:44,:);  
  V_eig_vecs(:,:,2) = V_bin(45:46,:);  
  V_rand_vecs(:,:,2) = V_bin(47:48,:);  

  V_EDPair1(:,:,3) = V_SB5(1:11,:);
  V_EDPair2(:,:,3) = V_SB5(12:22,:);
  V_IPPair1(:,:,3) = V_SB5(23:33,:);
  V_IPPair2(:,:,3) = V_SB5(34:44,:);  
  V_eig_vecs(:,:,3) = V_SB5(45:46,:);  
  V_rand_vecs(:,:,3) = V_SB5(47:48,:);  

  V_EDPair1(:,:,4) = V_SB10(1:11,:);
  V_EDPair2(:,:,4) = V_SB10(12:22,:);
  V_IPPair1(:,:,4) = V_SB10(23:33,:);
  V_IPPair2(:,:,4) = V_SB10(34:44,:);  
  V_eig_vecs(:,:,4) = V_SB10(45:46,:);  
  V_rand_vecs(:,:,4) = V_SB10(47:48,:);  

  V_EDPair1(:,:,5) = V_SRHT(1:11,:);
  V_EDPair2(:,:,5) = V_SRHT(12:22,:);
  V_IPPair1(:,:,5) = V_SRHT(23:33,:);
  V_IPPair2(:,:,5) = V_SRHT(34:44,:);  
  V_eig_vecs(:,:,5) = V_SRHT(45:46,:);  
  V_rand_vecs(:,:,5) = V_SRHT(47:48,:);  

end

