#!/usr/bin/env ipython

import re

import bibtexparser


ifile = 'resources/references.bib'
ofile = 'resources/references_parsed.bib'


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
    bib_db = bibtexparser.load(bibtex_file, parser=parser)


writer = bibtexparser.bwriter.BibTexWriter()
with open(ofile, 'w') as bibfile:
    bibfile.write(writer.write(bib_db))
