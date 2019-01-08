function [dist_struct] = get_pairwise_distances_big(X1, X2, distance_type, varargin)

  % Note: The difference between this function and get_pairwise_distances is that
  %       sometimes our distance matrix D_{n1 by n_2} is "large" enough that 
  %       vectorizing it actually takes a longer time, than by vectorizing it by
  %       partitions. 

  %       For example, if n1 was 1000, and n2 was 1000, generating D of size 1000 by 1000
  %       can actually take longer than if we generated 16 smaller blocks of D, of say
  %       size 250 by 250.
  
  %       Hence, this function assembles our distance struct from these smaller blocks.
  %
  %       We still assume that we can store the big D matrix in memory.

  % In this function we fix the maximum size of block of D to be 250

  MAXSIZE = 250;
  

  % X1, X2:A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %           

  % distance_type: type of distance to be calculated, from
  %                - angular_distance
  %                - dot_product
  %                - euclidean_distance
  %                - hamming_distance
  %                - jacaard_similarity
  %                - lp_distance 
  %                - resemblance 
  %                - squared_euclidean_distance
  %                - squared_lp_distance  
  %  
  % varagin: optional parameter p, for lp distance

  pars = inputParser;  
  pars.addRequired('X1',@(x) isstruct(x) | ismatrix(x));
  pars.addRequired('X2',@(x) isstruct(x) | ismatrix(x));
  pars.addRequired('distance_type', @(x) any(strcmp(x,{'angular_distance', 'dot_product', 'euclidean_distance', 'hamming_distance', 'jaccard_similarity', 'lp_distance', 'resemblance', 'squared_euclidean_distance', 'squared_lp_distance'})));
  pars.addOptional('p_dist', 'none', @(x) x > 0 | x == Inf);
  pars.parse(X1, X2 , distance_type, varargin{:});  

  inputs = pars.Results;

  % dist_struct: Outputs a structure with two (or three) fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        distance chosen between X1(i,:) and X2(j,:)
  %            .dist_type: distance type chosen (as a character)
  %            .dist_p   : l_p distance (if l_p distance was chosen)
  %                                                                                                              
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info


  % Construct start index and end index of blocks of "height" 250 or less
  if X1.num_obs > MAXSIZE
    n1_index_start = 1:MAXSIZE:X1.num_obs;
    n1_index_end = MAXSIZE:MAXSIZE:X1.num_obs;
    
    if(length(n1_index_start) > length(n1_index_end))
      n1_index_end = [n1_index_end, X1.num_obs];
    end
  else
    n1_index_start = 1;
    n1_index_end = X1.num_obs;
  end
  % Construct start index and end index of blocks of "width" 250 or less
  if X2.num_obs > MAXSIZE
    n2_index_start = 1:MAXSIZE:X2.num_obs;
    n2_index_end = MAXSIZE:MAXSIZE:X2.num_obs;
    
    if(length(n2_index_start) > length(n2_index_end))
      n2_index_end = [n2_index_end, X2.num_obs];
    end
  else
    n2_index_start = 1;
    n2_index_end = X2.num_obs;
  end

  dist_struct.n1_index_start = n1_index_start;
  dist_struct.n2_index_start = n2_index_start;
  
  dist_struct.n1_index_end = n1_index_end;
  dist_struct.n2_index_end = n2_index_end;


  dist_struct.dist_mat = zeros(X1.num_obs,X2.num_obs);
  if ~ischar(inputs.p_dist)
    dist_struct.dist_p = inputs.p_dist;
    for i = 1:length(n1_index_start)
      for j = 1:length(n2_index_start)
        dist_struct_tmp = get_pairwise_distances(X1.mat(n1_index_start(i):n1_index_end(i),:), X2.mat(n2_index_start(j):n2_index_end(j),:) , distance_type, inputs.p_dist);
        
        dist_struct.dist_mat(n1_index_start(i):n1_index_end(i),n2_index_start(j):n2_index_end(j)) = dist_struct_tmp.dist_mat;
      end
    end 
  else
    for i = 1:length(n1_index_start)
      for j = 1:length(n2_index_start)
         dist_struct_tmp = get_pairwise_distances(X1.mat(n1_index_start(i):n1_index_end(i),:), X2.mat(n2_index_start(j):n2_index_end(j),:) , distance_type);
      
        dist_struct.dist_mat(n1_index_start(i):n1_index_end(i),n2_index_start(j):n2_index_end(j)) = dist_struct_tmp.dist_mat;
     end
    end 
  end


  


  dist_struct.dist_type = dist_struct_tmp.dist_type;


end
      
  