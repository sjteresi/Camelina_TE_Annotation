INPUT_DIR=/mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/data/raw_input
OUTPUT_DIR=/mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/data/cleaned_input
#--------------------------------------------------------
# PREPARE THE FASTA files
# NOTE: fasta files with renamed sequence IDs have the MAGIC prefix of 'renamed' to the original filename
# NOTE: Genome name argument to `fix_fasta_names.py` is a MAGIC arg

AR="AR"
AR_REG_FASTA=$INPUT_DIR/Athaliana_447_TAIR10.fa
AR_NEW_REG_FASTA=$OUTPUT_DIR/renamed_Athaliana_447_TAIR10.fa
AR_CDS_FASTA=$INPUT_DIR/Athaliana_447_Araport11.cds.fa
AR_NEW_CDS_FASTA=$OUTPUT_DIR/renamed_Athaliana_447_Araport11.cds.fa

# NOTE the new fasta now has the ".fa" extension instead of "fasta"
CS="CS"
CS_REG_FASTA=$INPUT_DIR/CsSunv4.fasta
CS_NEW_REG_FASTA=$OUTPUT_DIR/renamed_CsSunv4.fa

# NOTE the new fasta now has the ".fa" extension instead of "fna"
CL="CL"
CL_REG_FASTA=$INPUT_DIR/Claxa_ASM2403449v1_genomic.fna
CL_NEW_REG_FASTA=$OUTPUT_DIR/renamed_Claxa_ASM2403449v1_genomic.fa

# NOTE the new fasta now has the ".fa" extension instead of "fna"
CH="CH"
CH_REG_FASTA=$INPUT_DIR/Chispida_ASM2386411v1_genomic.fna
CH_NEW_REG_FASTA=$OUTPUT_DIR/renamed_Chispida_ASM2386411v1_genomic.fa

# NOTE the new fasta now has the ".fa" extension instead of "fna"
CN="CN"
CN_REG_FASTA=$INPUT_DIR/Cneglecta_GCA_029034625.1_genomic.fna
CN_NEW_REG_FASTA=$OUTPUT_DIR/renamed_Cneglecta_GCA_029034625.1_genomic.fa
#--------------------------------------------------------
# Load modules for Python work (FASTA renaming)
module purge
module load GCCcore/11.3.0 Python/3.10.4 && source /mnt/research/edgerpat_lab/Scotty/venvs/Camelina_TE_Annotation/bin/activate

#--------------------------------------------------------
# Preparing Regular FASTAs
# This must be done because the names are too long
python /mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/src/fix_fasta_names.py $AR_REG_FASTA $AR $OUTPUT_DIR $AR_NEW_REG_FASTA

# NOTE the CS genome doesn't need to be altered!!!
# SO we will just make a symbolic link in order to get the file with the appropriate name and keep our filesystem format
# NOTE Don't run the python
#python /mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/src/fix_fasta_names.py $CS_REG_FASTA $CS $OUTPUT_DIR $CS_NEW_REG_FASTA
ln -sf $CS_REG_FASTA $CS_NEW_REG_FASTA

python /mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/src/fix_fasta_names.py $CL_REG_FASTA $CL $OUTPUT_DIR $CL_NEW_REG_FASTA

python /mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/src/fix_fasta_names.py $CH_REG_FASTA $CH $OUTPUT_DIR $CH_NEW_REG_FASTA

python /mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/src/fix_fasta_names.py $CN_REG_FASTA $CN $OUTPUT_DIR $CN_NEW_REG_FASTA

#--------------------------------------------------------
# Alter the Arabidopsis CDS FASTA
python /mnt/research/edgerpat_lab/Scotty/Camelina_TE_Annotation/src/fix_fasta_names.py $AR_CDS_FASTA "AR_CDS" $OUTPUT_DIR $AR_NEW_CDS_FASTA
