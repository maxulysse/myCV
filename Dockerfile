FROM ubuntu:16.04
MAINTAINER Maxime Garcia <max@ithake.eu>

# Install pre-requistes and textlive-xetex
RUN apt-get update && apt-get install -y \
  git \
  fontconfig \
  texlive-xetex

# Install Academicons
RUN git clone --depth 1 https://github.com/jpswalsh/academicons.git academicons
RUN mkdir -p /usr/share/fonts/truetype/academicons/
RUN find $PWD/academicons/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/academicons/ \; || return 1
RUN rm -rf $PWD/academicons

# Update fonts cache
RUN fc-cache -f -v

# Install ModernCV
RUN git clone --depth 1 https://github.com/xdanaux/moderncv.git /usr/share/texmf/tex/latex/moderncv

# Install AltaCV
RUN git clone --depth 1 https://github.com/liantze/AltaCV.git /usr/share/texmf/tex/latex/AltaCV

# Update TeX cache
RUN texhash
