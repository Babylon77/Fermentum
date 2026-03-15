// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'key_value_store.dart';

class WebKeyValueStore implements KeyValueStore {
  @override
  Future<String?> read(String key) async {
    return html.window.localStorage[key];
  }

  @override
  Future<void> write(String key, String value) async {
    html.window.localStorage[key] = value;
  }
}

KeyValueStore createStore() => WebKeyValueStore();
