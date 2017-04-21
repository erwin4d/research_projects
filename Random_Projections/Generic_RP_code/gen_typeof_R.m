function [ R ] = gen_typeof_R( p, k, option, opt_para)

  % This generates a random projection matrix R of
  % dimensions p x k 

  % Four possible options.
  
  % opt_para differs based on option 3 and option 4 (see below)
  
  if strcmp(option, 'normal')
  	% Generate random projection matrix of dimensions p*k ; entries iid Normal
  	R = normrnd(0,1,p, k);
  elseif strcmp(option, 'binary')
  	% Generate random projection matrix of dimensions p*k, entries iid in {-1,1}
    R = reshape(randsample([-1,1],p*k,true,[0.5,0.5]),[p,k]);
  elseif strcmp(option, 'SB')
  	% Generate random projection matrix from Sparse Bernoulli, entries iid in {-1, 0, 1} with
  	% probability distribution 1/2s, 1-1/s, 1/s
  	% opt_para here becomes the parameter s
  	% This is slightly different from the literature where we
  	% sample -1/sqrt(s), 0, 1/sqrt(s) because the scaling factor
  	% can be factored out later
  	R = reshape(randsample([-1,0,1],p*k,true,[1/(2*opt_para),1-1/opt_para,1/(2*opt_para)]),[p,k]);
  elseif strcmp(option, 'SRHT')
  	% Generate random projection matrix using Subsampled Randomized Hadamard Transform
  	% opt_para here is the Hadamard matrix of size p * p 
    R_diag = randsample([-1,1],p,true,[0.5,0.5])';
    ind1 = randsample(2^(ceil(log2(p))),(k),'true');
    ub = max([ind1]);    
    R_tmp1 = repmat(R_diag(1:p),1,ub) .* opt_para(1:p, 1:ub);
    R = R_tmp1(:,ind1);
  end

end

