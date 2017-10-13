FROM debian:stretch-slim

LABEL \
  author="Maxime Garcia" \
  description="Image for myCV compiler" \
  maintainer="max.u.garcia@gmail.com"

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Install pre-requistes
ARG DEBIAN_FRONTEND=noninteractive
RUN \
	apt-get update && apt-get install -y \
		bzip2 \
		ca-certificates \
		fontconfig \
		git \
		lmodern \
		texlive-fonts-recommended \
		texlive-xetex \
		unzip \
		wget \
	&& rm -rf /var/lib/apt/lists/*

# Install Fonts, modernCV and update fonts/Tex cache
COPY bin/biber-linux_x86_64.tar.gz biber-linux_x86_64.tar.gz
RUN \
	mkdir -p \
		/usr/share/fonts/truetype/academicons \
		/usr/share/fonts/truetype/fontawesome \
		/usr/share/texmf/bibtex/bib/biblatex \
		/usr/share/texmf/bibtex/bst/biblatex \
		/usr/share/texmf/tex/latex/biblatex \
	&& wget http://mirrors.ctan.org/fonts/academicons.zip \
		-O academicons.zip \
	&& unzip academicons.zip -d /usr/share/texmf/tex/latex \
	&& git clone https://github.com/jpswalsh/academicons.git \
	&& find academicons/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/academicons/ \; || return 1 \
	&& tar -xvzf biber-linux_x86_64.tar.gz -C /usr/local/bin \
	&& wget http://mirrors.ctan.org/macros/latex/contrib/biblatex.zip \
	-O biblatex.zip \
	&& unzip biblatex.zip \
	&& mv biblatex/latex/* /usr/share/texmf/tex/latex/biblatex \
	&& mv biblatex/bibtex/bst/* /usr/share/texmf/bibtex/bst/biblatex \
	&& mv biblatex/bibtex/bib/* /usr/share/texmf/bibtex/bib/biblatex \
	&& wget http://mirrors.ctan.org/fonts/fontawesome.zip \
		-O fontawesome.zip \
	&& unzip fontawesome.zip -d /usr/share/texmf/tex/latex \
	&& git clone https://github.com/FortAwesome/Font-Awesome/ \
	&& find Font-Awesome/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/fontawesome/ \; || return 1 \
	&& wget http://mirrors.ctan.org/macros/latex/contrib/logreq.zip \
	-O logreq.zip \
	&& unzip logreq.zip -d /usr/share/texmf/tex/latex \
	&& git clone https://github.com/xdanaux/moderncv.git \
		/usr/share/texmf/tex/latex/moderncv \
	&& rm -rf \
		academicons* \
		biber-linux_x86_64.tar.gz \
		biblatex* \
		fontawesome.zip \
		Font-Awesome \
		logreq.zip \
	&& texhash \
	&& fc-cache -f -v
