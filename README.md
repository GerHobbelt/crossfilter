# Crossfilter

This is a fork of [Square's Crossfilter](https://github.com/square/crossfilter) javascript library for exploring large multivariate datasets in the browser. See the [full introduction](http://square.github.com/crossfilter/).

This fork combines [Jason Davies' fork of custom filters](https://github.com/jasondavies/crossfilter/tree/filter-custom) (see [here for discussion](https://github.com/square/crossfilter/pull/36)) with [zackham's fork to support IE7/8 via underscore](https://github.com/zackham/crossfilter/tree/ie8compatible).

It replaces underscore with [Lo-Dash](http://lodash.com/) and adds support for loading Crossfilter with [RequireJS](http://requirejs.org/).