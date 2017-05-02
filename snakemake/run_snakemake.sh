#!/bin/bash

export cluster_config="cluster.yaml"

if uname -a | grep "raijin"
	then
		export PATH="/short/rl2/miniconda3/envs/snakemake/bin/":$PATH;
		export cluster_config="raijin.yaml"
fi

$snakemake_bin_path/snakemake --dag | dot -Tpdf > dag.pdf
$snakemake_bin_path/snakemake --rulegraph | dot -Tpdf > rulegraph.pdf

$snakemake_bin_path/snakemake -p --configfile config.yaml \
	  			--snakefile Snakefile \
	  			--jobs 10 \
	  			--printshellcmds \
	  			--cluster "qsub -pe threads {threads} \
                          	-q {cluster.queue} \
                          	-l virtual_free={cluster.virtual_free} \
                          	-l h_vmem={cluster.h_vmem} \
                          	-o {cluster.outstream} \
                          	-e {cluster.errorstream}" \
          			--cluster-config $cluster_config
	  
