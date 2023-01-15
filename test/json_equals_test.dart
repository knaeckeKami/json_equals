import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:json_equals/json_equals.dart';
import 'package:test/test.dart';

void main() {
  test("identical json maps are equal", () {
    final jsonMap = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 'a string',
      'e': true,
      'f': false,
      'g': null,
    };

    expect(jsonMapEquals(jsonMap, jsonMap), isTrue);
  });

  test("simple, flat json maps are equal", () {
    final jsonMap1 = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 'a string',
      'e': true,
      'f': false,
      'g': null,
    };
    final jsonMap2 = _jsonCopy(jsonMap1);

    expect(jsonMapEquals(jsonMap1, jsonMap2), isTrue);
  });

  test("simple, flat json maps are not equal", () {
    final jsonMap1 = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 'a string',
      'e': true,
      'f': false,
      'g': null,
    };
    final jsonMap2 = {
      ..._jsonCopy(jsonMap1),
      'h': 4,
    };

    expect(jsonMapEquals(jsonMap1, jsonMap2), isFalse);
  });

  test("nested json maps are equal", () {
    final jsonMap1 = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 'a string',
      'e': true,
      'f': false,
      'g': null,
      'h': {
        'a': 1,
        'b': 2,
        'c': 3,
        'd': 'a string',
        'e': true,
        'f': false,
        'g': null,
      },
      'i': [
        1,
        2,
        3,
        'a string',
        true,
        false,
        null,
        {
          'a': 1,
          'b': 2,
          'c': 3,
          'd': 'a string',
          'e': true,
          'f': false,
          'g': null,
        },
        [
          1,
          2,
          3,
          'a string',
          true,
          false,
          null,
        ],
      ],
    };
    final jsonMap2 = jsonDecode(jsonEncode(jsonMap1));

    expect(jsonMapEquals(jsonMap1, jsonMap2), isTrue);
  });

  test("nested json maps are not equal", () {
    final jsonMap1 = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 'a string',
      'e': true,
      'f': false,
      'g': null,
      'h': {
        'a': 1,
        'b': 2,
        'c': 3,
        'd': 'a string',
        'e': true,
        'f': false,
        'g': null,
      },
      'i': [
        1,
        2,
        3,
        'a string',
        true,
        false,
        null,
        {
          'a': 1,
          'b': 2,
          'c': 3,
          'd': 'a string',
          'e': true,
          'f': false,
          'g': null,
        },
        [
          1,
          2,
          3,
          'a string',
          true,
          false,
          null,
        ],
      ],
    };
    final jsonMap2 = {
      ..._jsonCopy(jsonMap1),
      'h': {
        'a': 1,
        'b': 2,
        'c': 3,
        'd': 'a string',
        'e': true,
        'f': false,
        'g': null,
        'h': 4,
      },
    };

    expect(jsonMapEquals(jsonMap1, jsonMap2), isFalse);
  });

  group("NaNs", () {
    test("DeepCollectionEquality NaN", () {
      final nanMap1 = {
        'a': double.nan,
      };

      final nanMap2 = {
        'a': double.nan,
      };

      print(DeepCollectionEquality().equals(nanMap1, nanMap2));
    });
  });
}

Map<String, dynamic> _jsonCopy(Map<String, dynamic> jsonMap) {
  return jsonDecode(jsonEncode(jsonMap));
}
