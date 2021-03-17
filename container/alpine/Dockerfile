FROM scratch
ADD alpine-minirootfs-3.13.2-x86_64.tar.gz /
RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add bash tini
ENTRYPOINT ["/sbin/tini", "--","/bin/bash"]