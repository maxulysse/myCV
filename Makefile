MAIN	= myCV
CV		= ${MAIN}.pdf

all: remove ${CV}

${CV}:
	pdflatex ${MAIN}
	@while ( grep "Rerun to get cross-references" ${MAIN}.log > /dev/null ); \
	do \
		bibtex ${MAIN}; \
		pdflatex ${MAIN}; \
	done
	makeindex ${MAIN}; \
	pdflatex ${MAIN}
	@while ( grep "Rerun to get outlines " ${MAIN}.log > /dev/null ); \
	do \
		pdflatex ${MAIN}; \
	done
	rm -f *.aux *.bbl *.blg *.ilg *.ind *.log *.out

remove:
	rm -f *.pdf

clean: remove
	rm -f *.aux *.bbl *.blg *.ilg *.ind *.log *.out

rebuild: clean all