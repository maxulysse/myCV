MAIN	= myCV

all: pdf

dvi:
	latex ${MAIN}.tex \
	while grep -q "Rerun to get cross-references" ${MAIN}.log; \
	do \
		latex ${MAIN}.tex \
	done \

ps:
	dvips -q -t a4 $< -o ${MAIN}.ps

pdf: log remove

log:
	pdflatex ${MAIN}
	@while ( grep "Rerun to get cross-references" ${MAIN}.log > /dev/null ); \
	do \
		echo '** Re-running LaTeX **'; \
		bibtex ${MAIN}; \
		pdflatex ${MAIN}; \
	done
	makeindex ${MAIN}; \
	pdflatex ${MAIN}
	@while ( grep "Rerun to get outlines " ${MAIN}.log > /dev/null ); \
	do \
		echo '** Re-running LaTeX **'; \
		pdflatex ${MAIN}; \
	done

clean: remove
	rm -f ${MAIN}.pdf

remove:
	rm -f \
	${MAIN}.aux \
	${MAIN}.bbl \
	${MAIN}.blg \
	${MAIN}.log \
	${MAIN}.out