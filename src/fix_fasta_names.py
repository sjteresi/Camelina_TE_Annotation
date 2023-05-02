#!/usr/bin/env python3

"""
Reformat regular fasta files for EDTA usage
"""

__author__ = "Scott Teresi"

import argparse
import os
import logging
import coloredlogs
from Bio import SeqIO
import csv


def reformat_fasta_seq_iq(input_fasta, genome_name, output_dir, new_fasta, logger):
    """
    Reformat a regular FASTA file to have shorter sequence ID names for EDTA

    Args:
        input_fasta (str): String path to input fasta file

        genome_name (str): String for genome name, used for custom filtering on
            a genome by genome basis

         (str): Path to output dir

        logger (logging.Logger): Object to log information to

    Returns:
        None, just saves the edited FASTA file to disk. Also writes a
        conversion table to disk for the old names and their new name
        counterparts
    """
    # TODO fill out updated docstring for new_fasta

    # MAGIC file suffixes
    name_key = os.path.join(output_dir, (genome_name + "_FASTA_Seq_ID_Conversion.txt"))
    # clarity

    ptg_counter = 0
    with open(input_fasta, "r") as input_fasta:
        with open(new_fasta, "w") as new_fasta_output:
            for s_record in SeqIO.parse(input_fasta, "fasta"):

                if genome_name == "AR":
                    s_record.id = s_record.id.split(" ")[0]

                if genome_name == "CS":
                    s_record.id = s_record.id.split(" ")[0]

                if genome_name == "CN":
                    s_record.id = s_record.id.split(" ")[0]
                    ugly_prefix = "JARBDP"
                    if ugly_prefix in s_record.id:
                        s_record.id = s_record.id.split(ugly_prefix)[1]

                if genome_name == "CH":
                    s_record.id = s_record.id.split(" ")[0]
                    ugly_prefix = "JALGBY"
                    if ugly_prefix in s_record.id:
                        s_record.id = s_record.id.split(ugly_prefix)[1]

                if genome_name == "CL":
                    s_record.id = s_record.id.split(" ")[0]
                    ugly_prefix = "JALLKC"
                    if ugly_prefix in s_record.id:
                        s_record.id = s_record.id.split(ugly_prefix)[1]

                if genome_name == "AR_CDS":
                    s_record.id = s_record.id.split(" ")[0]
                    if "uORF" in s_record.id:
                        # If this string of questionable rigin is in the
                        # gene name, just go to the next iteration of the loop.
                        # The string makes the gene names longer and there are
                        # less than 100 genes with this weird format. Just
                        # going to remove the genes to avoid having to
                        # arbirarily rename the genes and track them with a
                        # decoder throughout the process. The names were too
                        # long for EDTA
                        continue

                s_record.description = ""  # NB edit the description to be short

                if len(s_record.id) > 13:  # NB sanity check for EDTA
                    # compliance
                    print(f"Current genome ID: {genome_name}")
                    print(f"Offending sequence ID: {s_record.id}")
                    logger.critical(
                        """Sequence ID greater than 13, EDTA will
                                     not like this."""
                    )

                SeqIO.write(s_record, new_fasta_output, "fasta")

    logger.info("Finished writing new fasta to: %s" % new_fasta)


if __name__ == "__main__":

    path_main = os.path.abspath(__file__)
    dir_main = os.path.dirname(path_main)
    parser = argparse.ArgumentParser(description="Reformat FASTA for EDTA")

    parser.add_argument("fasta_input_file", type=str, help="parent path of fasta file")
    parser.add_argument("genome_id", type=str, help="name of genome")
    parser.add_argument(
        "output_dir",
        type=str,
        help="Parent directory to output results",
    )

    parser.add_argument(
        "new_fasta_file",
        type=str,
        help="Parent path to output new fasta file",
    )
    parser.add_argument(
        "-v", "--verbose", action="store_true", help="set debugging level to DEBUG"
    )
    args = parser.parse_args()
    args.fasta_input_file = os.path.abspath(args.fasta_input_file)
    args.new_fasta_file = os.path.abspath(args.new_fasta_file)

    log_level = logging.DEBUG if args.verbose else logging.INFO
    logger = logging.getLogger(__name__)
    coloredlogs.install(level=log_level)

    reformat_fasta_seq_iq(
        args.fasta_input_file,
        args.genome_id,
        args.output_dir,
        args.new_fasta_file,
        logger,
    )
