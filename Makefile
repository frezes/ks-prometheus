.PHONY: all
all: test ksapiserver- ks-controller-manager;$(info $(M)...Begin to test and build to generate manifests files.) @ ## Test and build to generate manifests files.

help:
	@grep -hE '^[ a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-17s\033[0m %s\n", $$1, $$2}'

.PHONY: update
# Update dependencies
update: ; $(info $(M)...Update dependencies.) @ ## Update dependencies.
	jb update

.PHONY: update
# Build to generate manifests files
manifests: ; $(info $(M)...Begin to build to generate manifests files.)  @ ## Build to generate manifests files
	./build.sh main.jsonnet

.PHONY: test
# Run tests
test: ; $(info $(M)...Begin to build to run tests.)  @ ## Run tests.
	echo "test"