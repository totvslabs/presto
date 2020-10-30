FROM openjdk:8u151-jdk-alpine3.7

ARG PRESTO_VERSION
ENV LANG en_US.UTF-8

RUN addgroup presto -g 1000 && \
    adduser -D presto -u 1000 -G presto && \
    mkdir -p /usr/lib/presto /data/presto && \
    chown -R "presto:presto" /usr/lib/presto /data/presto

ENV PYTHONUNBUFFERED=1
RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

COPY presto-cli/target/presto-cli-${PRESTO_VERSION}-executable.jar /usr/bin/presto
COPY --chown=presto:presto presto-server/target/presto-server-${PRESTO_VERSION}/presto-server-${PRESTO_VERSION} /usr/lib/presto

USER presto:presto
EXPOSE 8080

ENTRYPOINT ["/usr/lib/presto/bin/launcher.py"]
