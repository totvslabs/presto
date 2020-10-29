FROM openjdk:8u151-jdk-alpine3.7

ARG PRESTO_VERSION
ENV LANG en_US.UTF-8

RUN addgroup presto -g 1000 && \
    adduser -D presto -u 1000 -G presto && \
    mkdir -p /usr/lib/presto /data/presto && \
    chown -R "presto:presto" /usr/lib/presto /data/presto

ADD presto-cli/target/presto-cli-${PRESTO_VERSION}-executable.jar /usr/bin/presto
ADD --chown=presto:presto presto-server/target/presto-server-${PRESTO_VERSION} /usr/lib/presto

USER presto:presto
EXPOSE 8080

CMD ["/usr/lib/presto/bin/run-presto"]
