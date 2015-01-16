# -*- makefile -*-

.PHONY: all sig-alternate.pdf.once sig-alternate.pdf.atleastonce sig-alternate.pdf.recursive sig-alternate.bbl.once sig-alternate.bbl.maybe

SHELL=zsh

MAIN_MASTER=sig-alternate.tex

MAIN_OTHER_SOURCES=introduction.tex \
		   relwork.tex \
		   suctrees.tex \
		   dym.tex \
		   multicoreST.tex \
		   multicoreSTIdea.tex \
		   multicoreSTAlgorithm.tex \
		   theoreticalAnalysis.tex \
		   parenthesesAlgorithm.tex \
		   exps.tex \
		   setup.tex \
		   resultsDiscussion.tex \
		   conclusion.tex

MAIN_FIGURES=images/Range-min-max-tree.png \
	     images/Min-Max-array.png \
	     images/Speedup.png

all: sig-alternate.pdf

sig-alternate.pdf: $(MAIN_MASTER) $(MAIN_OTHER_SOURCES) $(MAIN_FIGURES) sig-alternate.bbl
	$(MAKE) $(@).once
	$(MAKE) $(@:.pdf=.bbl.maybe)
	$(MAKE) $(@).recursive
	-killall -HUP mupdf

sig-alternate.pdf.atleastonce:
	$(MAKE) $(@:.atleastonce=.once)
	$(MAKE) $(@:.atleastonce=.recursive)

sig-alternate.pdf.once:
	echo "LATEX  $(@:.once=)"
	pdflatex "\\batchmode \\input{$(MAIN_MASTER)}" > /dev/null

sig-alternate.pdf.recursive:
	grep "Rerun to get cross-references right" $(@:.pdf.recursive=.log) > /dev/null 2>&1; \
	if [[ $${?} == 0 ]]; then                                                             \
	  $(MAKE) $(@:.recursive=.once);                                                      \
	  $(MAKE) $(@);                                                                       \
	fi

sig-alternate.bbl: sigproc.bib
	$(MAKE) $(@).once

sig-alternate.bbl.once:
	echo "BIBTEX $(@:.once=)"
	bibtex $(@:.bbl.once=.aux) > /dev/null

sig-alternate.bbl.maybe:
	if [[ -f $(@:.bbl.maybe=.refs) ]]; then                                   \
	  mv $(@:.bbl.maybe=.refs) $(@:.bbl.maybe=.oldrefs);                      \
	fi
	grep "\\citation" $(@:.bbl.maybe=.aux) | sort -u > $(@:.bbl.maybe=.refs); \
	if [[ ! -f $(@:.bbl.maybe=.refs) ]]; then                                 \
	  $(MAKE) $(@:.maybe=.once);                                              \
	  $(MAKE) $(@:.bbl.maybe=.pdf.atleastonce);                               \
	else                                                                      \
	  diff $(@:.bbl.maybe=.refs) $(@:.bbl.maybe=.oldrefs) > /dev/null 2>&1;   \
	  if [[ $${?} == 1 ]]; then                                               \
	    $(MAKE) $(@:.maybe=.once);                                            \
	    $(MAKE) $(@:.bbl.maybe=.pdf.atleastonce);                             \
	  fi;                                                                     \
	fi
