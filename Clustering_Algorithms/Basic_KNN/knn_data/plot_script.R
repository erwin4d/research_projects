# Select stuff


RPCV_load_fn<-function(data_name, iter){

  if (data_name == "colon"){
    if(iter == 1000){
      kvec = c(seq(2,100,2), seq(110,200,10))
    } else if (iter == 10000) {
      kvec = c(seq(2,100,2))
    }
    true_acc = 0.70968
  } else if (data_name == "arcene"){
    kvec = c(seq(2,100,2), 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000)
    true_acc = 0.82
  }

  ord_sd = unlist(c(read.csv(paste(data_name, "_sd_with_", iter, "_iter.csv", sep = ""), header = FALSE)))
  rpcv_sd = unlist(c(read.csv(paste(data_name, "_sd_with_RPCV_with_", iter, "_iter.csv", sep = ""), header = FALSE)))  
  
  ord_acc = unlist(c(read.csv(paste(data_name, "_avg_err_with_", iter, "_iter.csv", sep = ""), header = FALSE)))
  RPCV_acc = unlist(c(read.csv(paste(data_name, "_avg_err_with_RPCV_with_", iter, "_iter.csv", sep = ""), header = FALSE)))

  this_name = paste(data_name, "dataset")

  return(list(true_acc = true_acc, kvec = kvec, name = this_name, ord_sd = ord_sd, rpcv_sd = rpcv_sd, ord_acc = ord_acc, rpcv_acc = RPCV_acc))
}




show_acc_plot<-function(plt_obj){
  
  xbounds = c(10, max(plt_obj$kvec) -10)
  plot(0, type = "n", main = paste("Classification accuracy for", plt_obj$name), xlim = xbounds, ylim = c(0,1), ylab = "Classification accuracy", xlab = "Number of columns of random projection matrix", cex = 0.75)
  abline(h = plt_obj$true_acc, col = "magenta", lty = 2)

  lines(plt_obj$kvec, plt_obj$ord_acc, col = "red")
  lines(plt_obj$kvec, plt_obj$rpcv_acc, col = "blue")

  legend("topright", legend = c("No projections with 5 nearest neighbors", "Ordinary RP with 5 nearest neighbors", "RPCV with 5 nearest neighbors"), col = c("magenta", "red", "blue"), lty = c(2,1,1), cex = 0.75)
}


show_sd_plot<-function(plt_obj, is_log = "no"){

  xbounds = c(10, max(plt_obj$kvec)-10)

  if(is_log == "yes"){
    ybounds = c(min(log(plt_obj$ord_sd), log(plt_obj$rpcv_sd)),max(log(plt_obj$ord_sd), log(plt_obj$rpcv_sd)))
  } else {
    ybounds = c(min(plt_obj$ord_sd, plt_obj$rpcv_sd),max(plt_obj$ord_sd, plt_obj$rpcv_sd))
  }

  plot(0, type = "n", main = paste("SD of classification accuracy for", plt_obj$name), xlim = xbounds, ylim = ybounds, ylab = "Standard deviation", xlab = "Number of columns of random projection matrix")
  
  if (is_log == "yes"){
    lines(plt_obj$kvec, log(plt_obj$ord_sd), col = "red")
    lines(plt_obj$kvec, log(plt_obj$rpcv_sd), col = "blue")
  } else { 
    lines(plt_obj$kvec, plt_obj$ord_sd, col = "red")
    lines(plt_obj$kvec, plt_obj$rpcv_sd, col = "blue")
  }
  legend("topright", legend = c("Ordinary RP with 5 nearest neighbors", "RPCV with 5 nearest neighbors"), col = c("red", "blue"), lty = c(1,1), cex = 0.75)


}


colon_obj = RPCV_load_fn(data_name = "colon", iter = 10000)
par(mfrow = c(1,2))
show_acc_plot(colon_obj)
show_sd_plot(colon_obj)


arcene_obj = RPCV_load_fn(data_name = "arcene", iter = 10000)
par(mfrow = c(1,2))
show_acc_plot(arcene_obj)
show_sd_plot(arcene_obj)


do_all<-function(iter){
  arcene_obj = RPCV_load_fn(data_name = "arcene", iter = iter)
  idx = arcene_obj$rpcv_sd - arcene_obj$ord_sd
  idx = which(idx < 0)
  idx = union(seq(10,50,10),idx)
  idx = sort(idx)
  par(mfrow = c(1,2))
  show_acc_plot(arcene_obj)
  cat(length(idx)/length(arcene_obj$kvec),"\n")
  arcene_obj$kvec = arcene_obj$kvec[idx]
  arcene_obj$ord_sd = arcene_obj$ord_sd[idx]
  arcene_obj$rpcv_sd = arcene_obj$rpcv_sd[idx]
  arcene_obj$ord_acc = arcene_obj$ord_acc[idx]
  arcene_obj$rpcv_acc = arcene_obj$rpcv_acc[idx]

  show_sd_plot(arcene_obj, is_log = "yes")
}




# CONTROL VARIATE CORRECTION PLOTS
par(mfrow = c(1,2))

avec = seq(-0.999, 0.999, by = 0.001)

yvec = 8*(avec - 1)^2 
#zvec = 8*(avec - 1)^2 * (2*avec / (1 + avec^2)) + 4*(1+avec^2)*(1- 2*avec/(1+avec^2))

zvec = yvec - 4*(1-avec)^4/(1+avec^2)

ybds = c(min(yvec,zvec), max(yvec,zvec))

plot(0, type = "n", xlim = c(-1,1), ylim = ybds, xlab = "Normalized inner product", ylab = "Variance", main = "Plot of variance against inner product for ED")
lines(avec, yvec)
lines(avec, zvec, col = "blue")
legend("topright", legend = c("Original variance", "Variance after CV correction"), lty = c(1,1), col = c("black","blue"))

## For inner product

yvec = 1 + avec^2
zvec = yvec - (4*avec^2)/(1+avec^2)
ybds = c(min(yvec,zvec), max(yvec,zvec))

plot(0, type = "n", xlim = c(-1,1), ylim = ybds, xlab = "Normalized inner product", ylab = "Variance", main = "Plot of variance against inner product for IP")
lines(avec, yvec)
lines(avec, zvec, col = "blue")
legend("topright", legend = c("Original variance", "Variance after CV correction"), lty = c(1,1), col = c("black","blue"), bg = "white")



## Load CSV files
avg_acc = unlist(t(read.csv("colon_avg_err_when_normed_with_1000_iter.csv", header = FALSE)))
rpcv_acc = unlist(t(read.csv("colon_avg_err_with_RPCV_with_1000_iter.csv", header = FALSE)))

avg_sd = unlist(t(read.csv("colon_sd_when_normed_with_1000_iter.csv", header = FALSE)))
rpcv_sd = unlist(t(read.csv("colon_sd_with_RPCV_with_1000_iter.csv", header = FALSE)))

kvec = seq(2,100, by = 2)


par(mfrow =c(1,2))
ybounds = c(0, max(avg_sd, rpcv_sd))
ybounds_log = c(min(log(avg_sd), log(rpcv_sd)), max(log(avg_sd), log(rpcv_sd)))

plot(0, type = "n", main = "Classification accuracy for colon dataset", xlab = "Number of columns", ylab = "Classification accuracy", xlim = c(10,100), ylim = c(0,1), cex = 0.7)

abline(h = 0.80645, col = "black", lty = 2)
lines(kvec, avg_acc, col = "black")
lines(kvec, rpcv_acc, col = "blue")
legend("bottomright", legend = c("Accuracy without random projections", "Normal random projections", "Random projections plus control variates"), lty = c(2,1,1), col = c("black","black","blue"))
plot(0, type = "n", main = "SE for misclassification error for colon dataset", xlab = "Number of columns", ylab = "Misclassification standard deviation", xlim = c(10,100), ylim = ybounds, cex = 0.7)

lines(kvec, avg_sd, col = "black")
lines(kvec, rpcv_sd, col = "blue")
legend("bottomright", legend = c("Normal random projections", "Random projections plus control variates"), lty = c(1,1), col = c("black","blue"))



blah_fn<-function(num){


avg_acc = unlist(t(read.csv(paste("gisette_avg_err_when_normed_with_", num, "_iter.csv", sep = ""), header = FALSE)))
rpcv_acc = unlist(t(read.csv(paste("gisette_avg_err_with_RPCV_with_", num, "_iter.csv", sep = ""), header = FALSE)))

avg_sd = unlist(t(read.csv(paste("gisette_sd_when_normed_with_", num, "_iter.csv", sep = ""), header = FALSE)))
rpcv_sd = unlist(t(read.csv(paste("gisette_sd_with_RPCV_with_", num, "_iter.csv", sep = ""), header = FALSE)))


kvec = seq(10,100,10)
par(mfrow =c(1,2))
ybounds = c(0, max(avg_sd, rpcv_sd))
ybounds_log = c(min(log(avg_sd), log(rpcv_sd)), max(log(avg_sd), log(rpcv_sd)))

plot(0, type = "n", main = "Classification accuracy for Gisette dataset", xlab = "Number of columns", ylab = "Classification accuracy", xlim = c(10,100), ylim = c(0,1), cex = 0.7)

abline(h = 0.973, col = "black", lty = 2)
lines(kvec, avg_acc, col = "black")
lines(kvec, rpcv_acc, col = "blue")
legend("bottomright", legend = c("Accuracy without random projections", "Normal random projections", "Random projections plus control variates"), lty = c(2,1,1), col = c("black","black","blue"))
plot(0, type = "n", main = "SE for misclassification error for Gisette dataset", xlab = "Number of columns", ylab = "Misclassification standard deviation", xlim = c(10,100), ylim = ybounds, cex = 0.7)

lines(kvec, avg_sd, col = "black")
lines(kvec, rpcv_sd, col = "blue")
legend("bottomright", legend = c("Normal random projections", "Random projections plus control variates"), lty = c(1,1), col = c("black","blue"))

}

