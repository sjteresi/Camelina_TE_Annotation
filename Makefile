# scripts for development
# __file__ Makefile
# __author__ Scott Teresi

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DEV_DATA := $(ROOT_DIR)/data

setup:
	mkdir -p data \

clean_regular_fasta:
	# Not Implemented
