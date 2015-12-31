.PHONY: all coq

all: frap.pdf coq

frap.pdf: frap.tex Makefile
	pdflatex frap
	pdflatex frap
	makeindex frap
	pdflatex frap
	pdflatex frap

coq: Makefile.coq
	$(MAKE) -f Makefile.coq

Makefile.coq: Makefile _CoqProject *.v
	coq_makefile -f _CoqProject -o Makefile.coq

clean:: Makefile.coq
	$(MAKE) -f Makefile.coq clean
	rm -f Makefile.coq
