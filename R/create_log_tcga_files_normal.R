#' create log tcga files
#' 
#' Takes upper norm tcga files creates processed form with coding genes and normal samples only. Goes through all cancers that have upper_norm normalized RNAseq stored on data2 and selects normal files 
#' then removes cancers, log2 x+1 transforms, and restricts to coding genes. Then prints out a file for each.
#' 
# @importFrom ggplot2 ggplot aes aes_string element_rect element_text geom_point geom_text labs margin theme theme_bw
#' 
#' @export
#' 
create_log_tcga_files_normal=function() {
  log2_it=function(data){
    gene=data[,1]
    dat=log2(data[,-1]+ 1)
    dat= cbind(gene,dat)
    return(dat)
  }
  
  coding = read.delim("//10.47.223.100/data2/users/nbalanis/SmallCell/Annotation/protein-coding_gene.txt")
  all.files.short.path=list.files("//10.47.223.100/data2/users/nbalanis/Input_Files_and_Standards/TCGA_TOIL_RECOMPUTE/TOIL_TCGA_norm/",pattern="_norm.txt",full.names=F)
  all.names=as.character(sapply(all.files.short.path, function(x) strsplit(x,"_")[[1]][3]))
  for(name in all.names){
    data=read.delim(paste0("//10.47.223.100/data2/users/nbalanis/Input_Files_and_Standards/TCGA_TOIL_RECOMPUTE/TOIL_TCGA_norm/TOIL_TCGA_",name,"_norm.txt"), header =T, stringsAsFactors = F,check.names=F)
    normal_samples=which(as.numeric(sapply(colnames(data),function(x) strsplit(x,"\\.")[[1]][4])) > 9) 
    if (length(normal_samples)==0){ next }
    data=cbind(data[,1],data[,normal_samples,drop=F]) 
    colnames(data)[1]="gene"  
    data=data[data$gene %in% coding$symbol,]
    data=data[order(data$gene),]
    data=log2_it(data)
    write.table(data,paste0("//10.47.223.100/data2/users/nbalanis/Input_Files_and_Standards/TCGA_TOIL_RECOMPUTE/TOIL_TCGA_norm_normals_coding/",name,"_rsem_genes_upper_norm_counts_normals_coding_log2.txt"),sep="\t",quote=F,row.names = F)
  }
}