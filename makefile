PAPER=AppGPU
REFSLIB=.
BIBS=$(REFSLIB)/refs.bib
FIGS=*.eps
SECS=section-*.tex

.IGNORE:

$(PAPER).pdf: $(PAPER).tex $(FIGS) 
	latex $(PAPER).tex
	bibtex $(PAPER)
	latex $(PAPER).tex
	latex $(PAPER).tex
	dvips $(PAPER).dvi
	ps2pdf $(PAPER).ps
	-rm -f $(PAPER).aux $(PAPER).bbl $(PAPER).blg $(PAPER).dvi $(PAPER).end $(PAPER).log $(PAPER).ps 
	xpdf $(PAPER).pdf &

TARFLIST = $$ME/makefile \
$$ME/refs.bib \
$$ME/$(PAPER).tex \
$$ME/$(SECS) \
$$ME/$(FIGS) \
$$ME/cicp.cls \

clean:
	rm -f $(PAPER).pdf

tar:
	cd ./ && ME=`basename $$PWD` && cd .. && tar -cf "`date +$(PAPER)_%m_%d_%y.tar`" ${TARFLIST} && \
	gzip "`date +$(PAPER)_%m_%d_%y.tar`" && mv `date +$(PAPER)_%m_%d_%y.tar`.gz $$ME/.
