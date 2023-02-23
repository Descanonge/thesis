
PROJECT := thesis

BUILD_DIR := texbuild
RES := resources
REF := references

MAIN := master
SUB_NAMES := intro méthodes res_chl res_phénologie conclusion
SUB_FILES = $(foreach sn,$(SUB_NAMES),tex/$(sn).tex)

AUXDIR_FLAGS := -auxdir="$(BUILD_DIR)" -emulate-aux-dir
LMK_FLAGS := -lualatex -interaction=batchmode -recorder -quiet
# LMK_FLAGS := -lualatex -interaction=nonstopmode -recorder

# Always put those in the \includeonly
INCLUDE_DEF := tex/front_page, tex/front_matter, tex/annexes_autres

.PHONY: all clean $(MAIN) $(SUB_NAMES)

all: $(MAIN)

$(SUB_NAMES):%: tex/%.tex
	mkdir -p $(BUILD_DIR)/tex
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) \
		-jobname="$*" \
		-usepretex="\includeonly{\
		$(INCLUDE_DEF), tex/$*}" \
		$(MAIN).tex

$(MAIN): $(MAIN).tex
	mkdir -p $(BUILD_DIR)/tex
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) $<

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(MAIN).fls
	rm -f $(foreach sf,$(SUB_NAMES),tex/$(sf).fls)
