IMG:=gcr.io/labs-ops/presto

.PHONY: build
build:
	docker build -t $(IMG) .

.PHONY: push
push:
	docker push $(IMG):latest
ifdef TAG
	docker tag $(IMG) $(IMG):$(TAG)
	docker push $(IMG):$(TAG)
endif
