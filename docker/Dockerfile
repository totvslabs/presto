FROM openjdk:8u151-jdk-alpine3.7

ENV LANG en_US.UTF-8 PRESTO_VERSION

COPY presto-cli/target/presto-cli-${PRESTO_VERSION}}-executable.jar /usr/bin/presto
COPY --chown=presto:presto presto-server/target/presto-server-${PRESTO_VERSION}.tar.gz /usr/lib/presto

EXPOSE 8080
USER presto:presto
CMD ["/usr/lib/presto/bin/run-presto"]
