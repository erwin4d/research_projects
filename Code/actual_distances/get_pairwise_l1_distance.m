function [dist_struct] = get_pairwise_l1_distance(X1, X2)

  % X1: n1 by p matrix of n1 observations and p parameters 
  % X2: n2 by p matrix of n2 observations and p parameters

  % dist_struct: Outputs a structure with three fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        l1 distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'l1_distance' 
  %            .dist_p   : 1
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
  n1 = size(X1,1);
  n2 = size(X2,1);
  
  dist_struct.dist_mat = zeros(n1,n2);

  if (n1 <= n2)  
    for i = 1:n1
      dist_struct.dist_mat(i,:) = sum(abs(bsxfun(@minus, X1(i,:), X2)),2)';
    end
  else
    for j = 1:n2
      dist_struct.dist_mat(:,j) = sum(abs(bsxfun(@minus, X2(j,:), X1)),2);  
    end
  end  


  dist_struct.dist_type = 'l1_distance';
  dist_struct.dist_p = 1;

end
      
  