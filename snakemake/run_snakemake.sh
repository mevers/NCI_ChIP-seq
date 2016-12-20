#!/bin/bash

snakemake --dag | dot -Tpdf > dag.pdf
snakemake --rulegraph | dot -Tpdf > rulegraph.pdf

snakemake --configfile config.yaml \
	  --snakefile Snakefile \
	  --jobs 10 \
	  --cluster "qsub -pe threads {cluster.threads} \
                          -q {cluster.queue} \
                          -l virtual_free={cluster.virtual_free} \
                          -l h_vmem={cluster.h_vmem} \
                          -o {cluster.outstream} \
                          -e {cluster.errorstream}" \
          --cluster-config cluster.yaml


#                          -e {cluster.error_out_dir} \
#                          -o {cluster.std1_out_dir} \

