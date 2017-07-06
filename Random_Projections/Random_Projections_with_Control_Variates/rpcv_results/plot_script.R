# Plots the results
read_and_load_data<-function(data_name, matrix_type, qnum, est_type){

  # Find bias
  setwd("/Users/keegankang/Google Drive/Research SUTD/research_projects/Random_Projections/Random_Projections_with_Control_Variates/rpcv_results")
  wd_str = getwd()

  bias_start_str = paste(wd_str, "/", data_name, "_bias_1000_iter_", matrix_type, "_mat_normalized_for_", sep = "")
  mse_start_str = paste(wd_str, "/", data_name, "_mse_1000_iter_", matrix_type, "_mat_normalized_for_", sep = "") 
  var_start_str = paste(wd_str, "/", data_name, "_var_1000_iter_", matrix_type, "_mat_normalized_for_", sep = "")  

  start_str_vec = c(bias_start_str, mse_start_str, var_start_str)
  name_str_vec = c("bias", "mse", "var")



  biglist = vector("list",3)
  
  for(j in 1:3){
    start_str = paste(wd_str, "/", data_name, "_", name_str_vec[j], "_1000_iter_", matrix_type, "_mat_normalized_for_", sep = "")    
    if (est_type == "ED"){ 
      end_str = "_ED.csv"
    } else if (est_type == "IP"){
      end_str = "_IP.csv"
      baseline_li = unlist(read.csv(paste(start_str, "li_IP.csv", sep = ""), header = FALSE)[qnum,])
    }  
    baseline_ord = unlist(read.csv(paste(start_str, "ord", end_str, sep = ""), header = FALSE)[qnum,])

    ## One CV
    ## Arrange this as empirical, ip_est, li_est
    one_cv = matrix(0, nrow = 3, ncol = 50)
    one_cv[1,] = unlist(read.csv(paste(start_str, "empirical_CV", end_str, sep = ""), header = FALSE)[qnum,])
    one_cv[2,] = unlist(read.csv(paste(start_str, "theory_CV_via_naive_est", end_str, sep = ""), header = FALSE)[qnum,])
    one_cv[3,] = unlist(read.csv(paste(start_str, "theory_CV_via_li_est", end_str, sep = ""), header = FALSE)[qnum,])
  
    emp_try4 = matrix(0, nrow = 4, ncol = 50)
    emp_try4[1,] = unlist(read.csv(paste(start_str, "emp_one_evec_by_ED_for", end_str, sep = ""), header = FALSE)[qnum,])
    emp_try4[2,] = unlist(read.csv(paste(start_str, "emp_one_evec_by_IP_for", end_str, sep = ""), header = FALSE)[qnum,])
    emp_try4[3,] = unlist(read.csv(paste(start_str, "emp_one_rand_by_ED_for", end_str, sep = ""), header = FALSE)[qnum,])
    emp_try4[4,] = unlist(read.csv(paste(start_str, "emp_one_rand_by_IP_for", end_str, sep = ""), header = FALSE)[qnum,])

    naive_ip_try4 = matrix(0, nrow = 4, ncol = 50)
    naive_ip_try4[1,] = unlist(read.csv(paste(start_str, "subst_naive_ip_one_evec_by_ED_for", end_str, sep = ""), header = FALSE)[qnum,])
    naive_ip_try4[2,] = unlist(read.csv(paste(start_str, "subst_naive_ip_one_evec_by_IP_for", end_str, sep = ""), header = FALSE)[qnum,])
    naive_ip_try4[3,] = unlist(read.csv(paste(start_str, "subst_naive_ip_one_rand_by_ED_for", end_str, sep = ""), header = FALSE)[qnum,])
    naive_ip_try4[4,] = unlist(read.csv(paste(start_str, "subst_naive_ip_one_rand_by_IP_for", end_str, sep = ""), header = FALSE)[qnum,])

    li_ip_try4 = matrix(0, nrow = 4, ncol = 50)
    li_ip_try4[1,] = unlist(read.csv(paste(start_str, "subst_li_ip_one_evec_by_ED_for", end_str, sep = ""), header = FALSE)[qnum,])
    li_ip_try4[2,] = unlist(read.csv(paste(start_str, "subst_li_ip_one_evec_by_IP_for", end_str, sep = ""), header = FALSE)[qnum,])
    li_ip_try4[3,] = unlist(read.csv(paste(start_str, "subst_li_ip_one_rand_by_ED_for", end_str, sep = ""), header = FALSE)[qnum,])
    li_ip_try4[4,] = unlist(read.csv(paste(start_str, "subst_li_ip_one_rand_by_IP_for", end_str, sep = ""), header = FALSE)[qnum,])

    if (est_type == "ED"){ 
      this_list = list(baseline_ord, one_cv, emp_try4, naive_ip_try4, li_ip_try4)
      name_vec = paste(name_str_vec[j], "_", c("baseline_ord", "one_cv", "emp_try4", "naive_ip_try4", "li_ip_try4"), sep = "")
      names(this_list) = name_vec
    } else if (est_type == "IP"){
      this_list = list(baseline_ord, baseline_li, one_cv, emp_try4, naive_ip_try4, li_ip_try4)
      name_vec = paste(name_str_vec[j], "_", c("baseline_ord", "baseline_li", "one_cv", "emp_try4", "naive_ip_try4", "li_ip_try4"), sep = "")
      names(this_list) = name_vec      
    }
    biglist[[j]] = this_list
  }

  names(biglist) = paste(name_str_vec, "mat", sep = "")
  return(biglist)
}

biglist = read_and_load_data(data_name = "colon", matrix_type = "normal", qnum = 5, est_type = "ED")


plot_bias_fn<-function(est_type, data_name, matrix_type, qnum){

  biglist = read_and_load_data(data_name = data_name, matrix_type = matrix_type, qnum = qnum, est_type = est_type)
  bias_info = biglist$biasmat
  col_vec = c("black", "blue", "red", "magenta", "green")
  kvec = seq(2,100,2)  
  # Plot single CV la
  tit_str = paste(data_name, "-", matrix_type, "-", (qnum-1)*10, " percentile for ", est_type, sep = "")


  if (est_type == "ED"){ 
    curr_mat_plot = rbind(bias_info$bias_baseline_ord, bias_info$bias_one_cv)
    name_vec = c("Naive estimate", "Empirical estimate", "Naive IP plugin", "Li IP plugin")
  } else if (est_type == "IP"){
    curr_mat_plot = rbind(bias_info$bias_baseline_ord, bias_info$bias_baseline_li, bias_info$bias_one_cv[1:2,])    
    name_vec = c("Naive estimate", "Li estimate", "Empirical estimate", "Naive IP plugin")
  }

  ybounds = c(0, max(curr_mat_plot))
  plot(0, type = "n", main = paste("Bias plot for", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Relative bias", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("topright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])

  
  curr_mat_plot = bias_info$bias_emp_try4
  name_vec = c("EDCV - eigvec", "IPCV - eigvec", "EDCV - randvec", "IPCV - randvec")
 
  ybounds = c(0, max(curr_mat_plot))
  plot(0, type = "n", main = paste("Bias plot for empirical", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Relative bias", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("topright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])

  curr_mat_plot = bias_info$bias_naive_ip_try4
  name_vec = c("EDCV - eigvec", "IPCV - eigvec", "EDCV - randvec", "IPCV - randvec")
 
  ybounds = c(0, max(curr_mat_plot))
  plot(0, type = "n", main = paste("Bias plot for naive IP", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Relative bias", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("topright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])

  curr_mat_plot = bias_info$bias_li_ip_try4
  name_vec = c("EDCV - eigvec", "IPCV - eigvec", "EDCV - randvec", "IPCV - randvec")
 
  ybounds = c(0, max(curr_mat_plot))
  plot(0, type = "n", main = paste("Bias plot for li IP", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Relative bias", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("topright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])

}


plot_var_fn<-function(est_type, data_name, matrix_type, qnum){
  biglist = read_and_load_data(data_name = data_name, matrix_type = matrix_type, qnum = qnum, est_type = est_type)
  var_info = biglist$varmat
  col_vec = c("black", "blue", "red", "magenta", "green")
  kvec = seq(2,100,2)  
  # Plot single CV la
  tit_str = paste(data_name, "-", matrix_type, "-", (qnum-1)*10, " percentile for ", est_type, sep = "")


  if (est_type == "ED"){ 
    bl = var_info$var_baseline_ord
    curr_mat_plot = var_info$var_one_cv / matrix(rep(bl,3), byrow = TRUE, nrow =3 )
    name_vec = c("Empirical estimate", "Naive IP plugin", "Li IP plugin")
  } else if (est_type == "IP"){
    bl = var_info$var_baseline_li
    curr_mat_plot = var_info$var_one_cv[1:2,] / matrix(rep(bl,2), byrow = TRUE, nrow =2 )
    name_vec = c("Empirical estimate", "Naive IP plugin")
  }

  ybounds = c(0, max(curr_mat_plot[,10:50]))
  plot(0, type = "n", main = paste("Rho plot for", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Ratio rho", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("bottomright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])

  
  curr_mat_plot = var_info$var_emp_try4 / matrix(rep(bl,4), byrow = TRUE, nrow =4 )
  name_vec = c("EDCV - eigvec", "IPCV - eigvec", "EDCV - randvec", "IPCV - randvec")
 
  ybounds = c(0, max(curr_mat_plot[,10:50]))
  plot(0, type = "n", main = paste("Rho plot for", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Ratio rho", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("bottomright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])


  curr_mat_plot = var_info$var_naive_ip_try4 / matrix(rep(bl,4), byrow = TRUE, nrow =4 )
  name_vec = c("EDCV - eigvec", "IPCV - eigvec", "EDCV - randvec", "IPCV - randvec")
 
  ybounds = c(0, max(curr_mat_plot[,10:50]))
  plot(0, type = "n", main = paste("Rho plot for", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Ratio rho", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("bottomright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])


  curr_mat_plot = var_info$var_li_ip_try4 / matrix(rep(bl,4), byrow = TRUE, nrow =4 )
  name_vec = c("EDCV - eigvec", "IPCV - eigvec", "EDCV - randvec", "IPCV - randvec")
 
  ybounds = c(0, max(curr_mat_plot[,10:50]))
  plot(0, type = "n", main = paste("Rho plot for", tit_str), xlim = c(0,100), ylim = ybounds, ylab = "Ratio rho", xlab = "Number of columns")
  for(j in 1:dim(curr_mat_plot)[1]){
    lines(kvec, curr_mat_plot[j,], col = col_vec[j])
  }
  legend("bottomright", legend = name_vec, lty = rep(1, dim(curr_mat_plot)[1]), col = col_vec[1:dim(curr_mat_plot)[1]])

}

par(mfrow = c(2,2))
plot_bias_fn(est_type = "ED", data_name = "colon", matrix_type = "normal", qnum = 5)
