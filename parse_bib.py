#!/usr/bin/env ipython

import sys

import bibtexparser


args = sys.argv[1:]
if len(args) < 2:
    raise IndexError("Need two arguments")
ifile = args[0]
ofile = args[1]


def set_journal(record):
    if record['ENTRYTYPE'] == 'article':
        if 'journal' not in record:
            record['journal'] = record.pop('journaltitle')
    return record


def pop_url(record):
    record.pop('url', None)
    return record


def customizations(record):
    record = set_journal(record)
    record = pop_url(record)
    return record


with open(ifile, 'r') as bibtex_file:
    parser = bibtexparser.bparser.BibTexParser()
    parser.customization = customizations
    parser.ignore_nonstandard_types = False
    bib_db = bibtexparser.load(bibtex_file, parser=parser)


writer = bibtexparser.bwriter.BibTexWriter()
with open(ofile, 'w') as bibfile:
    bibfile.write(writer.write(bib_db))
