import 'dart:convert';
import 'dart:math';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:collection/collection.dart';
import 'package:json_equals/json_equals.dart';

import 'json_maps.dart';

abstract class JsonEqualsBenchmarkBase extends BenchmarkBase {
  JsonEqualsBenchmarkBase(String name, this.json1, this.json2) : super(name);

  Map<String, dynamic> json1;
  Map<String, dynamic> json2;
}

class DeepCollectionEqualityBenchmark extends JsonEqualsBenchmarkBase {
  DeepCollectionEqualityBenchmark(
      Map<String, dynamic> json1, Map<String, dynamic> json2)
      : super('DeepCollectionEquality', json1, json2);

  @override
  void run() {
    const DeepCollectionEquality().equals(json1, json2);
  }
}

class JsonEqualsBenchmark extends JsonEqualsBenchmarkBase {
  JsonEqualsBenchmark(Map<String, dynamic> json1, Map<String, dynamic> json2)
      : super('json_equals', json1, json2);

  @override
  void run() {
    jsonMapEquals(json1, json2);
  }
}

class JsonEncodeBenchmark extends JsonEqualsBenchmarkBase {
  JsonEncodeBenchmark(Map<String, dynamic> json1, Map<String, dynamic> json2)
      : super('json_encode', json1, json2);

  @override
  void run() {
    jsonEncode(json1) == jsonEncode(json2);
  }
}

bool deepEquality(dynamic a, dynamic b) {
  if (identical(a, b)) {
    return true;
  }

  if (a is Iterable && b is Iterable) {
    final Iterator<dynamic> it1 = a.iterator;
    final Iterator<dynamic> it2 = b.iterator;

    while (it1.moveNext()) {
      if (!it2.moveNext() || !deepEquality(it1.current, it2.current)) {
        return false;
      }
    }

    // checks if both iterators have the same length
    return !(it1.moveNext() || it2.moveNext());
  } else if (a is Map && b is Map) {
    if (a.length != b.length) {
      return false;
    }

    for (final String key in a.keys) {
      if (!b.containsKey(key) || !deepEquality(a[key], b[key])) {
        return false;
      }
    }

    return true;
  }

  return a == b;
}

class DeepEqualityBenchmark extends JsonEqualsBenchmarkBase {
  DeepEqualityBenchmark(Map<String, dynamic> json1, Map<String, dynamic> json2)
      : super('deep_equality', json1, json2);

  @override
  void run() {
    deepEquality(json1, json2);
  }
}

class BenchmarksPrinter {
  final List<BenchmarkBase> benchmarks;

  BenchmarksPrinter(this.benchmarks);

  void run() {
    final results = <String, double>{
      for (final benchmark in benchmarks) benchmark.name: benchmark.measure()
    };

    final maxNameLength = results.keys.map((e) => e.length).reduce(max);
    final bestResult = results.values.reduce(min);

    for (final entry in results.entries) {
      final name = entry.key.padRight(maxNameLength);
      final result = entry.value;
      final resultString = result.toStringAsFixed(0).padLeft(8);
      final relative = (result / bestResult).toStringAsFixed(2).padLeft(8);
      print('$name: $resultStringμs ${relative}x');
    }
  }
}

void main() {
  final levels = 10;

  final jsons = {
    for (var i = 0; i < levels; i++) "level $i": jsonMapOfNestedLevel(i)
  };

  for (final key in jsons.keys) {
    final json = jsons[key]!;
    final copyJson = jsonDecode(jsonEncode(json));
    final benchmarks = [
      DeepCollectionEqualityBenchmark(json, copyJson),
      JsonEqualsBenchmark(json, copyJson),
      JsonEncodeBenchmark(json, copyJson),
      DeepEqualityBenchmark(json, copyJson),
    ];
    print('Benchmarking json map with nesting level $key\n');
    //print(JsonEncoder.withIndent(' ').convert(json));
    BenchmarksPrinter(benchmarks).run();
    print('=' * 80);
  }
}
