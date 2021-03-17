FROM nxa/alpine-glibc:3.13.2

# based on https://github.com/hayd/deno-docker

ENV DENO_VERSION=1.8.1 \
    DENO_DIR=/deno-dir/ \
    DENO_INSTALL_ROOT=/usr/local

COPY ./_entry.sh /usr/local/bin/docker-entrypoint.sh
RUN apk add --virtual .download --no-cache curl \
 && curl -fsSL https://github.com/nxnine/nxa/raw/master/alpine-deno/deno-v${DENO_VERSION}-x86_64-unknown-linux-gnu.zip \
         --output deno.zip \
 && unzip deno.zip \
 && rm deno.zip \
 && chmod 755 deno \
 && mv deno /bin/deno \
 && apk del .download \
 && addgroup -g 1993 -S deno \
 && adduser -u 1993 -S deno -G deno \
 && mkdir /deno-dir/ \
 && chown deno:deno /deno-dir/ \
 && chmod 755 /usr/local/bin/docker-entrypoint.sh \
 # REMOVE ASAP (this is due to dynamic link in deno 1.8.0) - https://github.com/denoland/deno/issues/9686
 && apk add --no-cache --update libc6-compat libstdc++

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["run", "https://deno.land/std/examples/welcome.ts"]