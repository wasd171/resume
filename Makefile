.PHONY: examples oksana clean

XELATEX ?= /Library/TeX/texbin/xelatex
TEXFLAGS = -file-line-error -interaction=nonstopmode -synctex=1
BUILD_DIR = .build

CC = $(XELATEX)
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

examples: $(foreach x, coverletter cv resume, $x.pdf)

oksana:
	mkdir -p $(BUILD_DIR)
	$(XELATEX) $(TEXFLAGS) -output-directory=$(BUILD_DIR) oksana-nesterova-cv.tex
	cp $(BUILD_DIR)/oksana-nesterova-cv.pdf oksana-nesterova-cv.pdf

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf $(BUILD_DIR)
