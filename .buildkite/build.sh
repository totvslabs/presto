#!/bin/sh
set -e

echo "~~~ build"
mvn clean install -DskipTests -T1C -ntp --builder smart

echo "~~~ upload"
version="$(mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.version -q -DforceStdout)"
gsutil -m cp "presto-server/target/presto-server-$version.tar.gz" "gs://labs-dataproc/lib/presto-server/$version/presto-server-$version.tar.gz"
gsutil -m cp "presto-cli/target/presto-cli-$version-executable.jar" "gs://labs-dataproc/lib/presto-cli/$version/presto-cli-$version-executable.jar"
