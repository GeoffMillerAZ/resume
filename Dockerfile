FROM debian:latest

ENV HUGO_VERSION 0.45.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb
ENV HUGO_SHA256 e7c8e0b59b11eb3505635eb04a87fdae6c6079f29f85c7b8c68c950a20ecf6c9

# Download
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb
# Make sure checksum matches
RUN echo ${HUGO_SHA256}  /tmp/hugo.deb | sha256sum -c -
# Install Hugo & remove install package
RUN dpkg -i /tmp/hugo.deb && rm /tmp/hugo.deb

# Setup container to expose port and where to look for files
EXPOSE 1313
VOLUME /app
WORKDIR /app

# Start the hugo server which is made available to localhost:1313
CMD ["hugo", "server", "--disableFastRender", "--bind=0.0.0.0"]