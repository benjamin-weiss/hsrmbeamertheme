
LATEX=lualatex
TARGET=presentation.tex

DOT=$(wildcard figs/*.dot)
SVG=$(wildcard figs/*.svg)

all: paper

%.pdf: %.svg
	inkscape --export-pdf $(@) $(<)

%.aux: paper

%.svg: %.dot

	twopi -Tsvg -o$(@) $(<)

thumbs:

	python make_video_preview.py ${TARGET}

bib: $(TARGET:.tex=.aux)

	BSTINPUTS=:./sty bibtex $(TARGET:.tex=.aux)

paper: $(TARGET) $(SVG:.svg=.pdf) $(DOT:.dot=.pdf)

	TEXINPUTS=:./sty $(LATEX) $(TARGET)

clean:
	rm -f *.spl *.idx *.aux *.log *.snm *.out *.toc *.nav *intermediate *~ *.glo *.ist *.bbl *.blg $(SVG:.svg=.pdf) $(DOT:.dot=.svg) $(DOT:.dot=.pdf)

distclean: clean
	rm -f $(TARGET:.tex=.pdf)
