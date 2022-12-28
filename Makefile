
PROJECT := thesis

BUILDDIR := texbuild
RES := resources
REF := references

BIB_ZOTERO := zotero_export
BIB_CUSTOM := custom
BIB_OUTPUT := processed
BIB_TMP := tmp
BIB_PARSER := src/parse_bib.py

MAIN := index
SUBNAMES := intro méthodes res_chl res_pft res_global conclusion
SUBFILES = $(foreach sn,$(SUBNAMES),tex/$(sn).tex)

AUXDIR_FLAGS := -auxdir="$(BUILDDIR)" -emulate-aux-dir
LMK_FLAGS := -pdfxe -recorder -quiet

$(foreach file,ZOTERO CUSTOM,$(eval BIB_$(file) = $(REF)/$(BIB_$(file)).bib))
$(foreach file,TMP OUTPUT,$(eval BIB_$(file) = $(BUILDDIR)/$(BIB_$(file)).bib))

.PHONY: all clean $(MAIN) $(SUBNAMES)

all: index

bib: $(BIB_OUTPUT)

$(BIB_OUTPUT): $(BIB_ZOTERO) $(BIB_CUSTOM) $(BIB_PARSER)
	mkdir -p $(BUILDDIR)
	cat $(BIB_ZOTERO) $(BIB_CUSTOM) > $(BIB_TMP)
	python $(BIB_PARSER) $(BIB_TMP) $(BIB_OUTPUT)


$(SUBNAMES):%: tex/%.tex $(MAIN).tex bib
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) $<

$(MAIN): $(MAIN).tex $(SUBFILES) $(BIB_OUTPUT)
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) $<

clean:
	rm -rf $(BUILDDIR)
	rm -f $(MAIN).fls
	rm -f $(foreach sf,$(SUBFILES),$(sf).fls)
