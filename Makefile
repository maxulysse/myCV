MAIN	= myCV
CV		= ${MAIN}.pdf
LOG		= ${MAIN}.aux ${MAIN}.bbl ${MAIN}.blg ${MAIN}.log ${MAIN}.out

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
	rm -f ${LOG}

remove:
	rm -f ${CV}

clean: remove
	rm -f ${LOG}

rebuild: clean all