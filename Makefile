
PROJECT := thesis

BUILD_DIR := texbuild
RES := resources
REF := references

MAIN := index
SUB_NAMES := intro méthodes res_chl res_phénologie conclusion
SUB_FILES = $(foreach sn,$(SUB_NAMES),tex/$(sn).tex)

AUXDIR_FLAGS := -auxdir="$(BUILD_DIR)" -emulate-aux-dir
LMK_FLAGS := -lualatex -interaction=batchmode -recorder -quiet

.PHONY: all clean $(MAIN) $(SUB_NAMES)

all: index

$(SUB_NAMES):%: tex/%.tex
	mkdir -p $(BUILD_DIR)/tex
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) $<

$(MAIN): $(MAIN).tex
	mkdir -p $(BUILD_DIR)/tex
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) $<

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(MAIN).fls
	rm -f $(foreach sf,$(SUB_NAMES),tex/$(sf).fls)
