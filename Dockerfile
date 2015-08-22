# VERSION latest
# AUTHOR:       Thomas Harning Jr <harningt@gmail.com>
# DESCRIPTION:  Alpine linux base image with s6-overlay injected

FROM alpine:3.2
MAINTAINER Thomas Harning Jr <harningt@gmail.com>

# Add in base configuration
COPY overlay-rootfs /

# Patch in source for testing sources...
# Update, install necessary packages, fixup permissions, delete junk
RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@edge http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk add --update skalibs@edge execline@edge s6@edge s6-portable-utils@testing && \
    rm -rf /var/cache/apk/* && \
    /prepare-files && \
    rm /prepare-files

ENTRYPOINT [ "/init" ]
