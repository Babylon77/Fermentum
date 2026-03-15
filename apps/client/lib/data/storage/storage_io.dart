import 'dart:io';

import 'key_value_store.dart';

class IoKeyValueStore implements KeyValueStore {
  @override
  Future<String?> read(String key) async {
    final file = File('$key.json');
    if (!await file.exists()) {
      return null;
    }
    return file.readAsString();
  }

  @override
  Future<void> write(String key, String value) async {
    final file = File('$key.json');
    await file.writeAsString(value, flush: true);
  }
}

KeyValueStore createStore() => IoKeyValueStore();
