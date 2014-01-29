MAIN	= myCV
CV		= ${MAIN}.pdf
LOG		= ${MAIN}.aux ${MAIN}.bbl ${MAIN}.blg ${MAIN}.log ${MAIN}.out

all: ${CV}

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
	rm -f ${LOG}

clean:
	rm -f ${LOG} ${MAIN}.pdf

rebuild: clean all