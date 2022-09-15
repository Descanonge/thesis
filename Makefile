
PROJECT=main

BUILDDIR=_build
BIB_FILE=resources/references

AUXDIR_FLAGS=-auxdir="$(BUILDDIR)" -emulate-aux-dir
LMK_FLAGS=-pdflua -recorder -quiet
# 		-interaction=nonstopmode -quiet
#####

BIB_INPUT=$(BIB_FILE)_input.bib

.PHONY: $(PROJECT).pdf all clean

all: $(PROJECT).pdf

$(BIB_FILE).bib: $(BIB_INPUT) ./parse_bib.py
	python ./parse_bib.py $(BIB_INPUT) $(BIB_FILE).bib

$(PROJECT).pdf: $(PROJECT).tex $(BIB_FILE).bib
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) -use-make $<

cleanall:
	latexmk -C $(AUXDIR_FLAGS)
	rm $(BIB_FILE).bib
	rm -r $(BUILDDIR)

clean:
	latexmk -c $(AUXDIR_FLAGS)
