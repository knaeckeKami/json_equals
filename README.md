
# json_equals

This is an attempt of finding a performant way to perform a deep comparison of two Maps of JSON-like data, where the keys are strings 
and the values are either null, bools, nums, Strings or Lists/Maps thereof.

`const DeepCollectionEquality().equals(a, b)` works, but is very slow and runs in O(n^2) time where n is the nesting level of the json mao. 
This is an attempt to find a faster way.


Example output when running bin/benchmark.dart in release mode:

```
Benchmarking json map with nesting level level 0

DeepCollectionEquality:       25μs     4.81x
json_equals           :        5μs     1.00x
json_encode           :       28μs     5.39x
deep_equality         :        6μs     1.19x
================================================================================
Benchmarking json map with nesting level level 1

DeepCollectionEquality:      147μs    12.22x
json_equals           :       12μs     1.00x
json_encode           :       59μs     4.93x
deep_equality         :       14μs     1.19x
================================================================================
Benchmarking json map with nesting level level 2

DeepCollectionEquality:      681μs    27.02x
json_equals           :       25μs     1.00x
json_encode           :      126μs     4.99x
deep_equality         :       30μs     1.20x
================================================================================
Benchmarking json map with nesting level level 3

DeepCollectionEquality:     3068μs    59.41x
json_equals           :       52μs     1.00x
json_encode           :      267μs     5.16x
deep_equality         :       69μs     1.33x
================================================================================
Benchmarking json map with nesting level level 4

DeepCollectionEquality:    12346μs   116.90x
json_equals           :      106μs     1.00x
json_encode           :      544μs     5.15x
deep_equality         :      126μs     1.19x
================================================================================
Benchmarking json map with nesting level level 5

DeepCollectionEquality:    51632μs   242.06x
json_equals           :      213μs     1.00x
json_encode           :     1088μs     5.10x
deep_equality         :      252μs     1.18x
================================================================================
Benchmarking json map with nesting level level 6

DeepCollectionEquality:   199651μs   467.35x
json_equals           :      427μs     1.00x
json_encode           :     2215μs     5.18x
deep_equality         :      509μs     1.19x
================================================================================
Benchmarking json map with nesting level level 7

DeepCollectionEquality:   797276μs   921.68x
json_equals           :      865μs     1.00x
json_encode           :     4415μs     5.10x
deep_equality         :     1013μs     1.17x
================================================================================
Benchmarking json map with nesting level level 8

DeepCollectionEquality:  3199949μs  1867.20x
json_equals           :     1714μs     1.00x
json_encode           :     8412μs     4.91x
deep_equality         :     2040μs     1.19x
================================================================================
Benchmarking json map with nesting level level 9

DeepCollectionEquality: 12801026μs  3716.82x
json_equals           :     3444μs     1.00x
json_encode           :    16495μs     4.79x
deep_equality         :     4084μs     1.19x
================================================================================
```