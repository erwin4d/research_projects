function [dist_struct] = get_pairwise_distances(X1, X2, distance_type, varargin)

  % X1, X2: Either a structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %    
  %         OR
  %         
  %         X1 a n1 by p matrix, and X2, a n2 by p matrix
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

  % Example: get_pairwise_distance(X1,X2, 'lp_distance', 3);  % to compute l_3 distance
  pars = inputParser;  
  pars.addRequired('X1',@(x) isstruct(x) | ismatrix(x));
  pars.addRequired('X2',@(x) isstruct(x) | ismatrix(x));
  pars.addRequired('distance_type', @(x) any(strcmp(x,{'angular_distance', 'dot_product', 'euclidean_distance', 'hamming_distance', 'jaccard_similarity', 'lp_distance', 'resemblance', 'squared_euclidean_distance', 'squared_lp_distance', 'squared_Euclidean_distance', 'Euclidean_distance'})));
  pars.addOptional('p_dist', 'none', @(x) x > 0 | x == Inf);
  pars.parse(X1, X2 , distance_type, varargin{:});  

  inputs = pars.Results;

  if ~isstruct(X1)
    X1_tmp.mat = X1;
    X1_tmp.num_obs = size(X1,1);
    X1 = X1_tmp;
  end

  if ~isstruct(X2)
    X2_tmp.mat = X2;
    X2_tmp.num_obs = size(X2,1);
    X2 = X2_tmp;
  end

  % dist_struct: Outputs a structure with two (or three) fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        distance chosen between X1(i,:) and X2(j,:)
  %            .dist_type: distance type chosen (as a character)
  %            .dist_p   : l_p distance (if l_p distance was chosen)
  %                                                                                                              
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info

  if strcmp(distance_type, 'angular_distance')
    dist_struct = get_pairwise_angular_distance(X1,X2);
  elseif strcmp(distance_type, 'dot_product')
    dist_struct = get_pairwise_dot_product(X1,X2);    
  elseif (strcmp(distance_type, 'euclidean_distance') | strcmp(distance_type, 'Euclidean_distance'))
    dist_struct = get_pairwise_euclidean_distance(X1,X2);
  elseif strcmp(distance_type, 'hamming_distance')
    dist_struct = get_pairwise_hamming_distance(X1,X2);
  elseif strcmp(distance_type, 'jaccard_similarity')
    dist_struct = get_pairwise_jaccard_similarity(X1,X2);
  elseif strcmp(distance_type, 'lp_distance')  
    dist_struct = get_pairwise_lp_distance(X1,X2,inputs.p_dist);
  elseif strcmp(distance_type, 'resemblance')
    dist_struct = get_pairwise_resemblance(X1,X2);
  elseif (strcmp(distance_type, 'squared_euclidean_distance') | strcmp(distance_type, 'squared_Euclidean_distance'))
    dist_struct = get_pairwise_squared_euclidean_distance(X1,X2);    
  elseif strcmp(distance_type, 'squared_lp_distance')
    dist_struct = get_pairwise_squared_lp_distance(X1,X2,inputs.p_dist);
  else
    % ehoh
    dist_struct = 'Error'
  end




end
      
  