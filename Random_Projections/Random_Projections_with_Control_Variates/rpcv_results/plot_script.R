# Plots the results

read_and_load_data<-function(data_name, sim_type, iter_num = 1000, is_norm, type_of_mat, pos_in_perc){
  
  this_WD = "/Users/keegankang/Google Drive/research_projects/Random_Projections/Random_Projections_with_Control_Variates/rpcv_results"
  
  types_vec = c("bias", "mse", "var")
  if(sim_type == "ED"){
    task_vec = c("ord_ED", "ord_ED_using_bin_exp", "empirical_CV_ED", "theory_CV_via_naive_est_ED", "theory_CV_via_li_est_ED")
    #legend_vec = c("Ordinary ED estimates", "Substituting IP estimate for ED", "Empirical CV for ED", "Theoretical CV for ED using computed IP", "Theoretical CV for ED using Li's IP" )

  } else if (sim_type == "IP") {
    task_vec = c("ord_IP", "li_IP", "empirical_CV_IP", "theory_CV_via_naive_est_IP", "theory_CV_via_li_est_IP")
    #legend_vec = c("Ordinary IP estimates", "Li's IP estimates", "Empirical CV for IP", "Theoretical CV for IP using computed IP", "Theoretical CV for IP using Li's IP" )
  }
  # Example

  bias_mat = matrix(0, nrow = 5, ncol = 50)
  mse_mat = matrix(0, nrow = 5, ncol = 50)
  var_mat = matrix(0, nrow = 5, ncol = 50)
  
  for(zz in 1:5){
    cv_file = paste(this_WD, "/", data_name, "_", iter_num, "_iter/", data_name, "_", types_vec[1], "_", iter_num, "_iter_", type_of_mat, "_", is_norm, "_for_", task_vec[zz], ".csv", sep = "")
    cv_res = read.table(cv_file, header = FALSE, sep = ",")
    bias_mat[zz,] = c(unlist(cv_res[pos_in_perc,]))

    cv_file = paste(this_WD, "/", data_name, "_", iter_num, "_iter/", data_name, "_", types_vec[2], "_", iter_num, "_iter_", type_of_mat, "_", is_norm, "_for_", task_vec[zz], ".csv", sep = "")
    cv_res = read.table(cv_file, header = FALSE, sep = ",")
    mse_mat[zz,] = c(unlist(cv_res[pos_in_perc,]))

    cv_file = paste(this_WD, "/", data_name, "_", iter_num, "_iter/", data_name, "_", types_vec[3], "_", iter_num, "_iter_", type_of_mat, "_", is_norm, "_for_", task_vec[zz], ".csv", sep = "")
    cv_res = read.table(cv_file, header = FALSE, sep = ",")
    var_mat[zz,] = c(unlist(cv_res[pos_in_perc,]))

  }

  if(sim_type == "ED"){
    bias_mat = bias_mat[c(1,3,4,5),]
    mse_mat = mse_mat[c(1,3,4,5),]
    var_mat = var_mat[c(1,3,4,5),]
    legend_vec = c("Ordinary ED estimates", "Empirical CV for ED", "Theoretical CV for ED using computed IP", "Theoretical CV for ED using Li's IP" )
    frac_legend_vec = c("Baseline of ED with empirical CV", "Baseline of ED with theoretical CV (estimated IP)", "Baseline of ED with theoretical CV (Li's IP)")


  } else if (sim_type == "IP") {
    bias_mat = bias_mat[1:4,]
    mse_mat = mse_mat[1:4,]
    var_mat = var_mat[1:4,]

    legend_vec = c("Ordinary IP estimates", "Li's IP estimates", "Empirical CV for IP", "Theoretical CV for IP using computed IP" )
    frac_legend_vec = c("Baseline of IP with empirical CV", "Baseline of ED with theoretical CV (estimated IP)")
  }

  return(list(bias_mat = bias_mat, mse_mat = mse_mat, var_mat = var_mat, data_name = data_name, sim_type = sim_type, is_norm = is_norm, type_of_mat = type_of_mat, pos_in_perc = pos_in_perc, legend_vec = legend_vec, frac_legend_vec = frac_legend_vec))

}


## Now: Plot bias, var, MSE at once

show_bias_plot<-function(some_list, kvec, col_vec, lty_vec, size_main, size_axis, size_labels, size_legend){
  bias_mat = some_list$bias_mat
  ybounds = c(0, max(bias_mat[,10:50])) # Cut off the first part
  xbounds = c(0, 100)
  ptile = some_list$pos_in_perc*10
  main_str = paste("Relative bias of ", ptile, "th percentile pair with ",some_list$type_of_mat, "rix", sep = "") # something like this so
  plot(0, type = "n", xlab = "Columns of projection matrix", ylab = "Relative Bias", ylim = ybounds, xlim = xbounds, main = main_str, cex.main = size_main, cex.axis = size_axis, cex.lab = size_labels)

  for(j in 1:4){
    lines(kvec, bias_mat[j,], col = col_vec[j], lty = lty_vec[j])
  }
  legend_vec = some_list$legend_vec
  legend("topright", legend = legend_vec, lty = lty_vec, col = col_vec, cex = size_legend, bg = "white")
  legend("topleft", legend = paste(some_list$data_name, "dataset"), bg = "white", cex = size_legend)

}

show_var_plot<-function(some_list, kvec, col_vec, lty_vec, size_main, size_axis, size_labels, size_legend){
  var_mat = some_list$var_mat
  ybounds = c(0, max(var_mat[,10:50])) # Cut off the first part
  xbounds = c(0, 100)
  ptile = some_list$pos_in_perc*10
  main_str = paste("Relative variance of ", ptile, "th percentile pair with ",some_list$type_of_mat, "rix", sep = "") # something like this so
  plot(0, type = "n", xlab = "Columns of projection matrix", ylab = "Relative variance", ylim = ybounds, xlim = xbounds, main = main_str, cex.main = size_main, cex.axis = size_axis, cex.lab = size_labels)

  for(j in 1:4){
    lines(kvec, var_mat[j,], col = col_vec[j], lty = lty_vec[j])
  }
  legend_vec = some_list$legend_vec
  legend("topright", legend = legend_vec, lty = 1, col = col_vec, cex = size_legend, bg = "white")
  legend("topleft", legend = paste(some_list$data_name, "dataset"), bg = "white", cex = size_legend)

}


show_mse_plot<-function(some_list, kvec, col_vec, lty_vec, size_main, size_axis, size_labels, size_legend){
  mse_mat = some_list$mse_mat
  ybounds = c(0, max(mse_mat[,10:50])) # Cut off the first part
  xbounds = c(0, 100)
  ptile = some_list$pos_in_perc*10
  main_str = paste("Relative MSE of ", ptile, "th percentile pair with ",some_list$type_of_mat, "rix", sep = "") # something like this so
  plot(0, type = "n", xlab = "Columns of projection matrix", ylab = "Relative MSE", ylim = ybounds, xlim = xbounds, main = main_str, cex.main = size_main, cex.axis = size_axis, cex.lab = size_labels)

  for(j in 1:4){
    lines(kvec, mse_mat[j,], col = col_vec[j], lty = lty_vec[j])
  }
  legend_vec = some_list$legend_vec
  legend("topright", legend = legend_vec, lty = 1, col = col_vec, cex = size_legend, bg = "white")
  legend("topleft", legend = paste(some_list$data_name, "dataset"), bg = "white", cex = size_legend)

}

plot_all_three_para<-function(some_list, size_main = 0.7, size_axis = 0.7, size_labels = 0.7, size_legend = 0.7){
  par(mfrow = c(1,3))
  kvec = seq(2,100,2)
  lty_vec = c(1,1,1,1)
  col_vec = c("black", "blue", "green", "red", "blue")  
  show_bias_plot(some_list, kvec = kvec, col_vec = col_vec, lty_vec = lty_vec, size_main = size_main, size_axis = size_axis, size_labels = size_labels, size_legend = size_legend)

  show_var_plot(some_list, kvec = kvec, col_vec = col_vec, lty_vec = lty_vec, size_main = size_main, size_axis = size_axis, size_labels = size_labels, size_legend = size_legend)

  show_mse_plot(some_list, kvec = kvec, col_vec = col_vec, lty_vec = lty_vec, size_main = size_main, size_axis = size_axis, size_labels = size_labels, size_legend = size_legend)

}


# Check to see if works, yes.

mat_vecs = c("normal_mat", "binary_mat", "SB5_mat", "SB10_mat", "SRHT_mat")

for (pp in 2:10){
  for(j in 1:length(mat_vecs)){
    some_list = read_and_load_data(data_name = "colon", sim_type = "ED", is_norm = "normalized", type_of_mat = mat_vecs[j], pos_in_perc = pp)

    plot_all_three_para(some_list, size_main = 0.8, size_axis = 0.8, size_labels = 0.8, size_legend = 0.8)
    readline("Pause for contemplation")

  }
}

# Plot fraction of variance: 
# Empirical / Baseline
# Theoretical / Baseline
# Theoretical / Baseline
plot_var_fraction<-function(some_list_ED, some_list_IP, size_main = 0.8, size_axis = 0.8, size_labels = 0.8, size_legend = 0.8){
  par(mfrow = c(1,2))
  kvec = seq(2,100,2)
  lty_vec = c(1,1,1,1)
  col_vec = c("black", "blue", "green", "red")  

  # First do ED
  mse_mat = some_list_ED$mse_mat


  ybounds = c(0, 1)
  xbounds = c(0, 100)
  ptile = some_list_ED$pos_in_perc*10
  main_str = paste("Variance reduction of ", ptile, "th percentile pair with ",some_list_ED$type_of_mat, "rix", sep = "") # something like this so
  plot(0, type = "n", xlab = "Columns of projection matrix", ylab = expression(paste("Ratio ", rho)), ylim = ybounds, xlim = xbounds, main = main_str, cex.main = size_main, cex.axis = size_axis, cex.lab = size_labels)

  for(j in 2:4){
    lines(kvec, mse_mat[j,]/mse_mat[1,], col = col_vec[j], lty = lty_vec[j])
  }
  legend_vec = some_list_ED$frac_legend_vec
  legend("bottomright", legend = legend_vec, lty = 1, col = col_vec[2:4], cex = size_legend, bg = "white")
  legend("bottomleft", legend = paste(some_list_ED$data_name, "dataset"), bg = "white", cex = size_legend)



  mse_mat = some_list_IP$mse_mat


  ybounds = c(0, 1)
  xbounds = c(0, 100)
  ptile = some_list_IP$pos_in_perc*10
  main_str = paste("Variance reduction of ", ptile, "th percentile pair with ",some_list_IP$type_of_mat, "rix", sep = "") # something like this so
  plot(0, type = "n", xlab = "Columns of projection matrix", ylab = expression(paste("Ratio ", rho)), ylim = ybounds, xlim = xbounds, main = main_str, cex.main = size_main, cex.axis = size_axis, cex.lab = size_labels)

  for(j in 3:4){
    lines(kvec, mse_mat[j,]/mse_mat[2,], col = col_vec[j], lty = lty_vec[j])
  }
  legend_vec = some_list_IP$frac_legend_vec
  legend("bottomright", legend = legend_vec, lty = 1, col = col_vec[3:4], cex = size_legend, bg = "white")
  legend("bottomleft", legend = paste(some_list_IP$data_name, "dataset"), bg = "white", cex = size_legend)

}


mat_vecs = c("normal_mat", "binary_mat", "SB5_mat", "SB10_mat", "SRHT_mat")

for (pp in 2:10){
  for(j in 1:length(mat_vecs)){
    some_list_ED = read_and_load_data(data_name = "nips", sim_type = "ED", is_norm = "normalized", type_of_mat = mat_vecs[j], pos_in_perc = pp)
    some_list_IP = read_and_load_data(data_name = "nips", sim_type = "IP", is_norm = "normalized", type_of_mat = mat_vecs[j], pos_in_perc = pp)

    plot_var_fraction(some_list_ED, some_list_IP, size_main = 0.8, size_axis = 0.8, size_labels = 0.8, size_legend = 0.7)
    readline("Pause for contemplation")

  }
}
