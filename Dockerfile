FROM alpine:3.17
ARG TZ='Asia/Tokyo'

ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=utf-8 \
    CODON_PYTHON=/usr/lib/libpython3.so \
    CODON_VERSION=0.15.5

LABEL maintainer="yuruto"

RUN    apk update \
    \
    # Install basic libraries and setup timezone
    \
    && apk add --no-cache bash tzdata gcc musl-dev zlib-dev zstd-libs \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && ln -s ${TZ} /etc/timezone \
    \
    # install temporary libraries
    \
    && apk add --no-cache --virtual .build-deps \
               libffi-dev g++ libgcc libstdc++ libxslt-dev python3-dev libc-dev linux-headers \
               openssl-dev curl cmake automake make llvm-dev llvm-static alpine-sdk \
    \
    # install python3 and pip3
    \
    && apk add --no-cache python3 \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip setuptools \
    \
    # create symbolic link
    \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && ln -sf /usr/bin/pip3 /usr/bin/pip \
    \
    # install codon
    \
    && curl -fsSL https://github.com/exaloop/codon/archive/refs/tags/v${CODON_VERSION}.tar.gz --output /tmp/v${CODON_VERSION}.tar.gz \
    && cd /tmp \
    && tar zxvf v${CODON_VERSION}.tar.gz \
    && cd codon-${CODON_VERSION} \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j 4 \
    && make install \
    && cd / \
    && apk --purge del .build-deps \
    && mkdir /code \
    && rm -rf /root/.cache /var/cache/apk/* /tmp/*

# add shell script
COPY ./start.sh /start.sh
RUN chmod 777 /start.sh

WORKDIR /code

CMD ["/start.sh"]
