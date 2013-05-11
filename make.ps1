$files = @(
	"src\version.js",
	"src\identity.js",
	"src\permute.js",
	"src\bisect.js",
	"src\heap.js",
	"src\heapselect.js",
	"src\insertionsort.js",
	"src\quicksort.js",
	"src\array.js",
	"src\filter.js",
	"src\null.js",
	"src\zero.js",
	"src\reduce.js",
	"src\crossfilter.js")

if (test-path crossfilter.js) {
	remove-item crossfilter.js
}

add-content crossfilter.js "define([""lodash""], function (_) {"
foreach ($item in $files) {
	add-content crossfilter.js (get-content $item)
}
add-content crossfilter.js "return crossfilter;"
add-content crossfilter.js "});"