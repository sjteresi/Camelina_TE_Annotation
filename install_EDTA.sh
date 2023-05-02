module purge
module load Conda/3
conda create -n Camelina_EDTA
conda activate Camelina_EDTA

conda install -c bioconda -c conda-forge edta
