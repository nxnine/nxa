FROM scratch as libgcc
ADD ubuntu-focal-core-cloudimg-amd64-root.tar.gz /
RUN chmod +x /lib/x86_64-linux-gnu/libz.so.1.2.11

FROM nxa/alpine:3.13.2 as base

ENV LANG=C.UTF-8

# this is originally the work of Vlad Frolov and Sasha Gerrand
# https://github.com/Docker-Hub-frolvlad/docker-alpine-glibc
# with some tweaks from Xavier Fournet
# https://github.com/xfournet/jready

COPY --from=libgcc /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libz.so.1.2.11 /usr/glibc-compat/lib/

RUN ALPINE_GLIBC_BASE_URL="https://github.com/nxnine/nxa/raw/master/alpine-glibc" \
    && ALPINE_GLIBC_PACKAGE_VERSION="2.33-r0" \
    && ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
    && ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
    && ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
    && apk add --no-cache --virtual=.build-dependencies wget ca-certificates \
    && echo \
        "-----BEGIN PUBLIC KEY-----\
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApZ2u1KJKUu/fW4A25y9m\
        y70AGEa/J3Wi5ibNVGNn1gT1r0VfgeWd0pUybS4UmcHdiNzxJPgoWQhV2SSW1JYu\
        tOqKZF5QSN6X937PTUpNBjUvLtTQ1ve1fp39uf/lEXPpFpOPL88LKnDBgbh7wkCp\
        m2KzLVGChf83MS0ShL6G9EQIAUxLm99VpgRjwqTQ/KfzGtpke1wqws4au0Ab4qPY\
        KXvMLSPLUp7cfulWvhmZSegr5AdhNw5KNizPqCJT8ZrGvgHypXyiFvvAH5YRtSsc\
        Zvo9GI2e2MaZyo9/lvb+LbLEJZKEQckqRj4P26gmASrZEPStwc+yqy1ShHLA0j6m\
        1QIDAQAB\
        -----END PUBLIC KEY-----" | sed 's/   */\n/g' > "/etc/apk/keys/sgerrand.rsa.pub" \
    && wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
    && apk add --no-cache \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
    \
    && rm "/etc/apk/keys/sgerrand.rsa.pub" \
    && /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true \
    && echo "export LANG=$LANG" > /etc/profile.d/locale.sh \
    \
    && apk del glibc-i18n \
    \
    # Fix ldconfig
    #&& rm /usr/glibc-compat/lib/ld-linux-x86-64.so.2 \
    #&& ln -s /usr/glibc-compat/lib/ld-2.30.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2 \
    #\
    ## Fix ldd
    #&& sed -i -e 's#/bin/bash#/bin/sh#' /usr/glibc-compat/bin/ldd \
    #&& sed -i -e 's#RTLDLIST=.*#RTLDLIST="/usr/glibc-compat/lib/ld-linux-x86-64.so.2"#' /usr/glibc-compat/bin/ldd \
    #\
    # Isolate the glibc lib's from musl-libc lib's
    #&& rm \
    #    /lib/ld-linux-x86-64.so.2 \
    #    /etc/ld.so.cache \
    #&& echo "/usr/glibc-compat/lib" > /usr/glibc-compat/etc/ld.so.conf \
    #&& /usr/glibc-compat/sbin/ldconfig -i \
    #&& rm -r \
    #    /var/cache/ldconfig/aux-cache \
    #    /var/cache/ldconfig \
    #\
    && rm "/root/.wget-hsts" \
    && apk del .build-dependencies \
    && rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"
