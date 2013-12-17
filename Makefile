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
endif
ifeq ($(wildcard $(JS_BEAUTIFIER)),)
JS_BEAUTIFIER = cat
endif
ifeq ($(wildcard $(JS_TESTER)),)
JS_TESTER = echo "no test rig installed"
endif

.PHONY: all minified test benchmark npm-install clean superclean

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

%.min.js: %.js Makefile npm-install
	@rm -f $@
	cat $< | $(JS_UGLIFY) > $@
	@chmod a-w $@

crossfilter.js: Makefile 
	@rm -f $@
	cat $(filter %.js,$^) > $@
	@chmod a-w $@

# always generate 'a' package.json, even when a lot of the tools are missing now:
$(PACKAGE_JSON): crossfilter.js src/package.js package.json.bootstrap
	@rm -f $@
	-node src/package.js > $@
	@[ -s $@ ] || cp package.json.bootstrap $@
	@chmod a-w $@

npm-install: $(PACKAGE_JSON)
	npm install

clean:
	-rm -f crossfilter.js crossfilter.min.js $(PACKAGE_JSON)

superclean: clean
	-rm -rf node_modules

test: all npm-install
	@$(JS_TESTER)

benchmark: all
	@node test/benchmark.js
