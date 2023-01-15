
# json_equals

This is an attempt of finding a performant way to perform a deep comparison of two Maps of JSON-like data, where the keys are strings 
and the values are either null, bools, nums, Strings or Lists/Maps thereof.

`const DeepCollectionEquality().equals(a, b)` works, but is very slow and runs in O(n^2) time where n is the nesting level of the json mao. 
This is an attempt to find a faster way.


Example output when running bin/benchmark.dart in release mode:

```
Benchmarking json map with nesting level level 0
DeepCollectionEquality:       25μs     4.86x
json_equals           :        5μs     1.00x
json_encode           :       28μs     5.49x
deep_equality         :        6μs     1.20x
================
Benchmarking json map with nesting level level 1
DeepCollectionEquality:      148μs    11.24x
json_equals           :       13μs     1.00x
json_encode           :       66μs     5.00x
deep_equality         :       15μs     1.15x
================
Benchmarking json map with nesting level level 2
DeepCollectionEquality:      778μs    25.68x
json_equals           :       35μs     1.16x
json_encode           :      129μs     4.25x
deep_equality         :       30μs     1.00x
================
Benchmarking json map with nesting level level 3
DeepCollectionEquality:     2975μs    56.24x
json_equals           :       53μs     1.00x
json_encode           :      267μs     5.05x
deep_equality         :       64μs     1.21x
================
Benchmarking json map with nesting level level 4
DeepCollectionEquality:    12246μs   103.89x
json_equals           :      118μs     1.00x
json_encode           :      562μs     4.76x
deep_equality         :      141μs     1.20x
================
Benchmarking json map with nesting level level 5
DeepCollectionEquality:    53334μs   236.07x
json_equals           :      226μs     1.00x
json_encode           :     1086μs     4.81x
deep_equality         :      255μs     1.13x
================
Benchmarking json map with nesting level level 6
DeepCollectionEquality:   198532μs   429.53x
json_equals           :      462μs     1.00x
json_encode           :     2201μs     4.76x
deep_equality         :      548μs     1.19x
================
Benchmarking json map with nesting level level 7
DeepCollectionEquality:   815381μs   927.66x
json_equals           :      879μs     1.00x
json_encode           :     4428μs     5.04x
deep_equality         :     1034μs     1.18x
================
Benchmarking json map with nesting level level 8
DeepCollectionEquality:  3315974μs  1872.99x
json_equals           :     1770μs     1.00x
json_encode           :     9014μs     5.09x
deep_equality         :     2119μs     1.20x
================
Benchmarking json map with nesting level level 9
DeepCollectionEquality: 13004378μs  3710.51x
json_equals           :     3505μs     1.00x
json_encode           :    16883μs     4.82x
deep_equality         :     4135μs     1.18x
```