## DEWSeq analysis helpers

This repository contains helper functions and Rmarkdown files for the analysis is i/eCLIP dataset using data post-processing package [htseq-clip](https://htseq-clip.readthedocs.io/en/latest/) and statistical analysis package [DEWSeq](https://bioconductor.org/packages/release/bioc/html/DEWSeq.html).

This repository is organized as follows:

* `htseq-clip_snakemake` contains snakemake pipleline for post-processing eCLIP datasets using htseq-clip.
* `Parametrized_Rmd` contains an Rmd file called `analyseStudy.Rmd` which can be used to analyze eCLIP datasets. Further details are available in the README file in the folder.
* `SLBP_analysis` contains Rmarkdwon file, and knitted html and pdf outputs for the analysis of ENCODE SLBP eCLIP data using DEWSeq.
* `Volcano_plot` contains an Rscript called `volcanoplot.R`, which can be used to create volcano plots of significant windows. For further details, please read the README file in the folder.
