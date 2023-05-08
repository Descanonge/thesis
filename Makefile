
PROJECT := thesis

BUILD_DIR := build
RES := resources
REF := references

MAIN := master
SUB_NAMES := intro méthodes res_chl res_phénologie conclusion
SUB_FILES = $(foreach sn,$(SUB_NAMES),tex/$(sn).tex)

AUXDIR_FLAGS := -auxdir="$(BUILD_DIR)" -emulate-aux-dir
LMK_FLAGS := -lualatex -shell-escape -interaction=batchmode -recorder -quiet

# Always put those in the \includeonly
INCLUDE_DEF := tex/front_page, tex/front_matter, tex/annexes_autres

export TEXINPUTS := .:src:
export LUAINPUTS := .:src:

.PHONY: all clean $(PROJECT) $(SUB_NAMES) html checkcites

all: $(PROJECT)

$(SUB_NAMES):%: tex/%.tex
	mkdir -p $(BUILD_DIR)/tex
	latexmk $(LMK_FLAGS) $(AUXDIR_FLAGS) \
		-jobname="$*" \
		-usepretex="\includeonly{\
		$(INCLUDE_DEF), tex/$*}" \
		$(MAIN).tex

$(PROJECT): $(MAIN).tex
	mkdir -p $(BUILD_DIR)/tex
	latexmk  $(LMK_FLAGS) $(AUXDIR_FLAGS) \
		-jobname="$(PROJECT)_paper" \
		$(MAIN).tex

html: $(MAIN).tex
	latex2html $(MAIN).tex

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(MAIN).fls
	rm -f $(foreach sf,$(SUB_NAMES),tex/$(sf).fls)

checkcites:
	checkcites -b biber $(BUILD_DIR)/$(PROJECT)
