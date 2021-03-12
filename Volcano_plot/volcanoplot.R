#' Volcano plot
#'
#' Visualizing the Log2FoldChange and pvalue of differentially expressed windows as volcano plot 
#'
#' @author Thileepan Sekaran
#' 
#' @param res_obj tibble. The results table from the resultsDEWSeq function
#'
#' @param padj_col character. Name of the column containing padjusted values
#'
#' @param FDR double. The minimum cut-off value for to identify significant windows (Default: 0.05)
#'
#' @param title character. Title of the VolcanoPlot (Default: None)
#'
#' @param label_genes logical. Label genes if TRUE (Default: TRUE). If FALSE only highliht the windows without any label
#'
#' @param gene_names character. A vector of gene names to be labelled inside the plot (Default: None)
#'
#' @param label_genes_color character. Color of the labels (Default: blue)
#' 
#' @return ggplot2 object
volcanoplot<- function(res_obj, 
                       padj_col,
                       FDR = 0.05,
                       title = NULL,
                       label_genes = TRUE, 
                       gene_names = NULL, 
                       label_color = "blue") 
{
  missingLibs <- setdiff(c('ggplot2','ggrepel'),installed.packages()[,1])
  if(length(missingLibs)>0){
    stop('Cannot find all dependencies for this function. Missing package(s): ', paste(missingLibs,collapse=", "),' ')
  }
  require(ggplot2)
  require(ggrepel)
  mydf <- as.data.frame(res_obj)
  reqCols <- c('baseMean','gene_name','log2FoldChange','pvalue',padj_col)
  missingCols <- setdiff(reqCols,colnames(mydf))
  if(length(missingCols)>0){
    stop('Input data.frame is missing required columns, needed columns:
    baseMean,
    gene_name,
    log2FoldChange,
    pvalue,',padj_col,
    'Missing columns: ',paste(missingCols,collapse=", "),' ')
  }
  mydf <- mydf[,reqCols]
  mydf <- mydf[mydf$baseMean > 0, ]
  if(nrow(mydf)==0){
    stop('empty res_obj! Check your input data')
  }
  mydf$significant <- mydf[,padj_col]<=FDR
  if(sum(mydf$significant)==0){
    stop('Cannot find any significant windows in res_obj with',padj_col,' <= ',FDR,'. Please lower this threshold')
  }
  mydf$alpha <- ifelse(mydf$significant,0.75,0.5)
  p <- ggplot(mydf, aes_string(x = "log2FoldChange", y = "-log10(pvalue)")) + 
    geom_point(aes(color = significant, alpha = alpha)) 
  

  Total_sig_windows <- dim(mydf[mydf$significant=="TRUE",])[1]
  
  Total_nonsig_windows <- dim(mydf[mydf$significant=="FALSE",])[1]
  
  if (!is.null(title)) 
    p <- p + ggtitle(title) 
    p <- p + theme_bw() + scale_colour_manual(values = c("black","red",label_color),
                          labels = paste0(c("Non sig. windows = ","Sig. windows = ","Marker genes"),
                          c(Total_nonsig_windows,Total_sig_windows)))+
                          scale_alpha(guide = "none")+
                          theme(axis.title.x = element_text(size = 12,face = "bold"),
                              axis.text.x = element_text(size = 12),
                              axis.text.y = element_text(size = 12),
                              axis.title.y = element_text(size = 12,face = "bold"),
                              legend.text = element_text(size = 10,face = "bold"),
                              legend.title = element_blank(),
                              plot.title = element_text(size = 14,face = "bold",hjust = 0.5))
  
  
  if (!is.null(label_genes)) {
    if ("gene_name" %in% colnames(mydf)) {
      df_intgenes <- mydf[mydf$gene_name %in% gene_names & mydf$significant ==TRUE,]
      df_intgenes$myids <- df_intgenes$gene_name
    }
    else {
      df_intgenes <- mydf[rownames(mydf) %in% gene_names & mydf$significant ==TRUE,]
      df_intgenes$myids <- rownames(df_intgenes)
    }
    
p <- p + geom_point(data = df_intgenes, aes_string("log2FoldChange", 
                 "-log10(pvalue)"), color = label_color)

    if (label_genes) {
      p <- p + geom_text_repel(data = df_intgenes, aes_string("log2FoldChange", 
          "-log10(pvalue)", label = "myids"), color = label_color, hjust = 0.25, vjust = -0.75)
    }
  }
  p
}

