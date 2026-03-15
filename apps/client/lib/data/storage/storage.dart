import 'key_value_store.dart';
import 'storage_io.dart' if (dart.library.html) 'storage_web.dart' as impl;

KeyValueStore createStore() => impl.createStore();
