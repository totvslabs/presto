#!/bin/bash
set -e
image="totvslabs/presto"

echo "~~~ build"
mvn clean install -DskipTests -T1C -ntp --builder smart
version="$(mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.version -q -DforceStdout)"

echo "~~~ upload to gcs"
gsutil -m cp "presto-server/target/presto-server-$version.tar.gz" "gs://labs-dataproc-1/lib/presto-server/$version/presto-server-$version.tar.gz"
gsutil -m cp "presto-cli/target/presto-cli-$version-executable.jar" "gs://labs-dataproc-1/lib/presto-cli/$version/presto-cli-$version-executable.jar"

echo "~~ create docker image"
tag="${version/-SNAPSHOT/}"
docker build --file docker/Dockerfile --tag "$image:latest" --tag "$image:$tag" --build-arg PRESTO_VERSION="$version" .

echo "~~ push docker image"
docker push "$image":latest
docker push "$image:$tag"
