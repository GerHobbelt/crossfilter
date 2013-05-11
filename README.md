# Crossfilter

**Crossfilter** is a JavaScript library for exploring large multivariate datasets in the browser. Crossfilter supports extremely fast (<30ms) interaction with coordinated views, even with datasets containing a million or more records; we built it to power analytics for Square Register, allowing merchants to slice and dice their payment history fluidly.

Since most interactions only involve a single dimension, and then only small adjustments are made to the filter values, incremental filtering and reducing is significantly faster than starting from scratch. Crossfilter uses sorted indexes (and a few bit-twiddling hacks) to make this possible, dramatically increasing the perfor­mance of live histograms and top-K lists. Crossfilter is available under the [Apache License](/square/crossfilter/blob/master/LICENSE).

Want to learn more? [See the wiki.](https://github.com/square/crossfilter/wiki)



## About this fork

This is a fork of [Square's Crossfilter](https://github.com/square/crossfilter) javascript library for exploring large multivariate datasets in the browser. See the [full introduction](http://square.github.com/crossfilter/).

This fork combines [Jason Davies' fork of custom filters](https://github.com/jasondavies/crossfilter/tree/filter-custom) (see [here for discussion](https://github.com/square/crossfilter/pull/36)) with [zackham's fork to support IE7/8 via underscore](https://github.com/zackham/crossfilter/tree/ie8compatible).

It replaces underscore with [Lo-Dash](http://lodash.com/) and adds support for loading Crossfilter with [RequireJS](http://requirejs.org/).



## Extras

- 'data can be NaN' support, thanks to Jason Davies

- `filter(range)` now accepts multiple ranges, which are processed as a _union_ of multiple range filters, thanks to Zack Ham

- `bottom()` next to the existing `top()` method, thanks to John Alexis Guerra Gómez

