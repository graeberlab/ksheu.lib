#' Plot PCA projection only
#' 
#' Plots projection from rotated.scores file (output of intersect_do_PCA_and_project_second_dataset)
#' 
#' @param rotated.file2 File containing scores matrix
#' @param info.name Vector of sample names
#' @param info.type Vector of sample types in the same order
#' @param title Title of the plot
#' @param labels default=T
#' @param PCx,PCy PCs to display
#' @param ellipse Construct confidence region based on groups in info.type, default = T
#' @param conf default = 0.95 
#' 
# @importFrom ggplot2 ggplot aes aes_string element_rect element_text geom_point geom_text labs margin theme theme_bw
#' @export
#'
#'
plot_pca_projection_only =function (rotated.file2, info.name, info.type, title = "Projection", 
                                    labels = TRUE, PCx = "PC1", PCy = "PC2", ellipse = F, conf = 0.95) 
{
  require(ggplot2)
  require(vegan)
  projected_data = read.delim(rotated.file2)
  projected_data$type = info.type[match(projected_data$Sample, 
                                        info.name)]
 
  pcx.y <- ggplot(projected_data, aes_string(x = PCx, y = PCy)) + 
    geom_point(size = I(2), aes(color = factor(type))) + 
    theme(legend.position = "right", plot.title = element_text(size = 30), 
          legend.text = element_text(size = 22), legend.title = element_text(size = 20), 
          axis.title = element_text(size = 30), legend.background = element_rect(), 
          axis.text.x = element_text(margin = margin(b = -2)), 
          axis.text.y = element_text(margin = margin(l = -14))) + 
    guides(color = guide_legend(title = "Type")) + labs(title = title) + 
    coord_equal(ratio=1) +
    theme_bw() + if (labels == TRUE) {
      geom_text(data = projected_data, mapping = aes(label = Sample), 
                check_overlap = TRUE, size = 3)
    }
  
  
  if(ellipse==TRUE){
    plot(projected_data[,c(PCx, PCy)], main=title)
    ord = ordiellipse(projected_data[,c(PCx, PCy)],projected_data$type, kind = "sd", conf = conf) 
    
    cov_ellipse<-function (cov, center = c(0, 0), scale = 1, npoints = 100) 
    {
      theta <- (0:npoints) * 2 * pi/npoints
      Circle <- cbind(cos(theta), sin(theta))
      t(center + scale * t(Circle %*% chol(cov)))
    }
    
    df_ell <- data.frame(matrix(ncol = 0, nrow = 0))
    for(g in (droplevels(projected_data$type))){
      df_ell <- rbind(df_ell, cbind(as.data.frame(with(projected_data[projected_data$type==g,],
                                                       cov_ellipse(ord[[g]]$cov,ord[[g]]$center,ord[[g]]$scale)))
                                    ,type=g))
    }
    
    pcx.y2 = pcx.y + geom_path(data=df_ell, aes(x=df_ell[,PCx], y=df_ell[,PCy], colour = type), size=1, linetype=1)
    pcx.y2
  }else{
    pcx.y
  }
  
}