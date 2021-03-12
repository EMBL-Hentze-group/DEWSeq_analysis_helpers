## Generate volcano plot from DEWSeq results

The Rscript `volcanoplot.R` can be used to generate volcano plot for enriched windows, from DEWSeq analysis.

### Dependencies

* [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)
* [ggrepel](https://cran.r-project.org/web/packages/ggrepel/index.html)

Make sure to install the dependecies before sourcing the script.

### Usage

Before using this script, please make sure to run the DEWSeq analysis steps.

For additional details, please refer to the [DEWSeq vignette](https://bioconductor.org/packages/release/bioc/vignettes/DEWSeq/inst/doc/DEWSeq.html) or the SLBP analysis example [available here](https://github.com/EMBL-Hentze-group/DEWSeq_analysis_helpers/tree/master/SLBP_example).

```R
source(https://raw.githubusercontent.com/EMBL-Hentze-group/DEWSeq_analysis_helpers/master/Volcano_plot/volcanoplot.R)
volcanoplot(resultWindows,padj_col = p_adj_col_name)
```