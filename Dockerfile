FROM debian:8.6

MAINTAINER Maxime Garcia <max.u.garcia@gmail.com>

# Install pre-requistes
RUN apt-get update && apt-get install -y \
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

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Install Academicons
RUN wget http://mirrors.ctan.org/fonts/academicons.zip -O academicons.zip \
	&& unzip academicons.zip -d /usr/share/texmf/tex/latex \
	&& rm academicons.zip

 # Install Academicons fonts
RUN mkdir -p /usr/share/fonts/truetype/academicons/
RUN git clone --depth 1 https://github.com/jpswalsh/academicons.git \
	&& find academicons/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/academicons/ \; || return 1 \
	&& rm -rf academicons

# Install AltaCV
RUN git clone --depth 1 https://github.com/liantze/AltaCV.git /usr/share/texmf/tex/latex/AltaCV

# Install biber
COPY bin/biber-linux_x86_64.tar.gz biber-linux_x86_64.tar.gz
RUN tar -xvzf biber-linux_x86_64.tar.gz -C /usr/local/bin \
	&& rm -rf biber-linux_x86_64.tar.gz

# Install biblatex
RUN mkdir -p /usr/share/texmf/tex/latex/biblatex \
	&& mkdir -p /usr/share/texmf/bibtex/bst/biblatex \
	&& mkdir -p /usr/share/texmf/bibtex/bib/biblatex \
	&& wget http://mirrors.ctan.org/macros/latex/contrib/biblatex.zip -O biblatex.zip \
	&& unzip biblatex.zip \
	&& mv biblatex/latex/* /usr/share/texmf/tex/latex/biblatex \
	&& mv biblatex/bibtex/bst/* /usr/share/texmf/bibtex/bst/biblatex \
	&& mv biblatex/bibtex/bib/* /usr/share/texmf/bibtex/bib/biblatex \
	&& rm -rf biblatex.zip

# Install Font awesome
RUN wget http://mirrors.ctan.org/fonts/fontawesome.zip -O fontawesome.zip \
	&& unzip fontawesome.zip -d /usr/share/texmf/tex/latex \
	&& rm fontawesome.zip

# Install Font awesome fonts
RUN mkdir -p /usr/share/fonts/truetype/fontawesome/
RUN git clone --depth 1 https://github.com/FortAwesome/Font-Awesome/ Font-Awesome \
	&& find Font-Awesome/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/fontawesome/ \; || return 1 \
	&& rm -rf Font-Awesome

# Install logreq
RUN wget http://mirrors.ctan.org/macros/latex/contrib/logreq.zip -O logreq.zip \
	&& unzip logreq.zip -d /usr/share/texmf/tex/latex \
	&& rm -rf logreq.zip

# Install ModernCV
RUN git clone --depth 1 https://github.com/xdanaux/moderncv.git /usr/share/texmf/tex/latex/moderncv

# Update TeX and fonts cache
RUN texhash && \
  fc-cache -f -v
