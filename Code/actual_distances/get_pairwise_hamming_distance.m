function [dist_struct] = get_pairwise_hamming_distance(X1, X2)

  % X1, X2:A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %           

  % dist_struct: Outputs a structure with three fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        Hamming distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'hamming_distance' 
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
  n1 = size(X1,1);
  n2 = size(X2,1);
  
  

  dist_struct.dist_mat = zeros((X1.num_obs),(X2.num_obs));

  if ((X1.num_obs) <= (X2.num_obs))  
    for i = 1:(X1.num_obs)
      dist_struct.dist_mat(i,:) = sum(bsxfun(@xor, (X1.mat(i,:)), (X2.mat)),2)';
    end
  else
    for j = 1:(X2.num_obs)
      dist_struct.dist_mat(:,j) = sum(bsxfun(@xor, (X2.mat(j,:)), (X1.mat)),2);  
    end
  end  


  dist_struct.dist_type = 'hamming_distance';

end
      
  