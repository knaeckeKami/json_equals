import 'dart:convert';

const flatJsonMap = {
  'a': 1,
  'b': 2,
  'c': 3,
  'd': 'a string',
  'e': 'another string',
  'f': true,
  'g': false,
  'h': null,
  'i': ['list', 'of', 'strings'],
};

Map<String, dynamic> jsonMapOfNestedLevel(int level) {
  Map<String, dynamic> jsonMap = flatJsonMap;
  for (var i = 0; i < level; i++) {
    jsonMap = {
      'a': jsonDecode(jsonEncode(jsonMap)),
      'b': jsonDecode(jsonEncode(jsonMap)),
    };
  }
  return jsonMap;
}

const emptyJsonMap = <String, dynamic>{};
