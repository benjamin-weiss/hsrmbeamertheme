
LATEX=lualatex

TEXTARGETS=$(wildcard ./presentation.tex)

TARGET=$(TEXTARGETS:.tex=.pdf)

DOT=$(wildcard figs/*.dot)
SVG=$(wildcard figs/*.svg)
SVG+=$(wildcard figs/*/*.svg)

MODE ?= batchmode

all: paper

%.pdf: %.svg
	inkscape --export-pdf $(@) $(<)

%.aux: paper

%.svg: %.dot
	twopi -Tsvg -o$(@) $(<)

%.thumbs: %.tex
	./make_video_preview.py $<

bib: $(TARGET:.tex=.aux)
	BSTINPUTS=:./style bibtex $(TARGET:.tex=.aux)

%.pdf: %.tex #%.thumbs
	TEXINPUTS=:./style $(LATEX) --interaction=$(MODE) -shell-escape $<; if [ $$? -gt 0 ]; then echo "Error while compiling $<"; touch $<; fi

paper: $(SVG:.svg=.pdf) $(DOT:.dot=.pdf) $(TARGET)

touch:
	touch $(TEXTARGETS)

force: touch paper

dist: paper
	mkdir -p dist
	cp $(TARGET) dist/
	for f in `./make_video_preview.py $(TARGET:.pdf=.tex) --list | uniq`; do mkdir -p dist/`dirname $$f`;cp $$f dist/$$f;  done

clean:
	rm -f *.vrb *.spl *.idx *.aux *.log *.snm *.out *.toc *.nav *intermediate *~ *.glo *.ist *.bbl *.blg $(SVG:.svg=.pdf) $(DOT:.dot=.svg) $(DOT:.dot=.pdf)
	rm -rf _minted*

distclean: clean
	rm -f $(TARGET:.tex=.pdf)
	rm -rf dist
