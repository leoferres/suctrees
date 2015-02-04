# -*- makefile -*-

.PHONY: all sea2015.pdf.once sea2015.pdf.atleastonce sea2015.pdf.recursive sea2015.bbl.once sea2015.bbl.maybe

SHELL=zsh

MAIN_MASTER=sea2015.tex

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
	     images/Min-Max-array.png

all: sea2015.pdf

sea2015.pdf: $(MAIN_MASTER) $(MAIN_OTHER_SOURCES) $(MAIN_FIGURES) sea2015.bbl
	$(MAKE) $(@).once
	$(MAKE) $(@:.pdf=.bbl.maybe)
	$(MAKE) $(@).recursive
	-killall -HUP mupdf

sea2015.pdf.atleastonce:
	$(MAKE) $(@:.atleastonce=.once)
	$(MAKE) $(@:.atleastonce=.recursive)

sea2015.pdf.once:
	echo "LATEX  $(@:.once=)"
	pdflatex "\\batchmode \\input{$(MAIN_MASTER)}" > /dev/null

sea2015.pdf.recursive:
	grep "Rerun to get cross-references right" $(@:.pdf.recursive=.log) > /dev/null 2>&1; \
	if [[ $${?} == 0 ]]; then                                                             \
	  $(MAKE) $(@:.recursive=.once);                                                      \
	  $(MAKE) $(@);                                                                       \
	fi

sea2015.bbl: sigproc.bib
	$(MAKE) $(@).once

sea2015.bbl.once:
	echo "BIBTEX $(@:.once=)"
	bibtex $(@:.bbl.once=.aux) > /dev/null

sea2015.bbl.maybe:
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
