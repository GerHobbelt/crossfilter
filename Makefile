# See the README for installation instructions.

NODE_PATH ?= ./node_modules
JS_UGLIFY = $(NODE_PATH)/.bin/uglifyjs -c -m
JS_BEAUTIFIER = $(NODE_PATH)/.bin/uglifyjs -b -i 2 -nm -ns
JS_TESTER = $(NODE_PATH)/.bin/vows
PACKAGE_JSON = package.json
LOCALE ?= en_US

# when node or any of these tools has not been installed, ignore them.
ifeq ($(wildcard $(JS_UGLIFY)),)
JS_UGLIFY = cat
NODE_PATH =
PACKAGE_JSON =
endif
ifeq ($(wildcard $(JS_BEAUTIFIER)),)
JS_BEAUTIFIER = cat
NODE_PATH =
PACKAGE_JSON =
endif
ifeq ($(wildcard $(JS_TESTER)),)
JS_TESTER = echo "no test rig installed"
NODE_PATH =
PACKAGE_JSON =
endif

.PHONY: test benchmark

all: crossfilter.js minified

minified: crossfilter.min.js $(PACKAGE_JSON)

# Modify this rule to build your own custom release.

.INTERMEDIATE crossfilter.js: \
	src/start.js \
	src/version.js \
	src/identity.js \
	src/permute.js \
	src/bisect.js \
	src/heap.js \
	src/heapselect.js \
	src/insertionsort.js \
	src/quicksort.js \
	src/array.js \
	src/filter.js \
	src/null.js \
	src/zero.js \
	src/reduce.js \
	src/crossfilter.js \
	src/end.js

%.min.js: %.js Makefile
	@rm -f $@
	cat $< | $(JS_UGLIFY) > $@
	@chmod a-w $@

crossfilter.js: Makefile
	@rm -f $@
	cat $(filter %.js,$^) > $@
	@chmod a-w $@

$(PACKAGE_JSON): crossfilter.js src/package.js
	@rm -f $@
	node src/package.js > $@
	@chmod a-w $@

clean:
	rm -f crossfilter.js crossfilter.min.js $(PACKAGE_JSON)

test: all
	@$(JS_TESTER)

benchmark: all
	@node test/benchmark.js
