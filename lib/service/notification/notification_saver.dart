// ignore_for_file: cascade_invocations

import '../../utils/tools/file_importers.dart';

class NotificationSaver {
  //bool

  Box getBox(String boxName) => Hive.box(boxName);

  void saveBool(String boxName, String key, bool value) {
    final box = getBox(boxName);
    box.put(key, value);
    debugPrint('Saved boolean value $value with key $key in box $boxName');
  }

  bool getBool(String boxName, String key, {bool? defaultValue = false}) {
    final box = getBox(boxName);
    final value = box.get(key);
    // if (value == null) {
    //   debugPrint('Failed to get boolean value with key $key in box $boxName');
    // } else {
    //   debugPrint('Got boolean value $value with key $key in box $boxName');
    // }
    return value ?? defaultValue;
  }

  void deleteBool(String boxName, String key) {
    final box = getBox(boxName);
    box.delete(key);
    debugPrint('Deleted boolean value with key $key in box $boxName');
  }

  //int

  void saveInt(String boxName, String key, int value) {
    final box = getBox(boxName);
    box.put(key, value);
    // debugPrint('Saved integer value $value with key $key in box $boxName');
  }

  int? getInt(String boxName, String key) {
    final box = getBox(boxName);
    final value = box.get(key);
    // if (value == null) {
    //   debugPrint('Failed to get integer value with key $key in box $boxName');
    // } else {
    //   debugPrint('Got integer value $value with key $key in box $boxName');
    // }
    return value;
  }

  void deleteInt(String boxName, String key) {
    final box = Hive.box<int>(boxName);
    box.delete(key);
    // debugPrint('Deleted integer value with key $key in box $boxName');
  }

  //String

  void saveString(String boxName, String key, String value) {
    final box = getBox(boxName);
    box.put(key, value);
    debugPrint('Saved string value "$value" with key $key to box $boxName');
  }

  String getString(String boxName, String key) {
    final box = getBox(boxName);

    final value = box.get(key);
    // if (value != null) {
    //   debugPrint('Retrieved string value "$value" for key $key from box $boxName');
    // } else {
    //   debugPrint('String value not found for key $key in box $boxName');
    // }
    return value ?? '';
  }

  void deleteString(String boxName, String key) {
    final box = getBox(boxName);
    box.delete(key);
    //debugPrint('Deleted string value with key $key from box $boxName');
  }

  void addToBox(String boxName, dynamic value) {
    final box = getBox(boxName);
    box.add(value);
    //debugPrint('Added  value "$value" with to box $boxName');
  }

  List getFromBox(String boxName) {
    final box = getBox(boxName);

    return box.values.toList();
  }

  void deleteFromBox(String boxName, dynamic index) {
    final box = getBox(boxName);
    box.deleteAt(index);
    // debugPrint('Deleted  $index from box $boxName');
  }

  void deleteBox(
    String boxName,
  ) {
    final box = getBox(boxName);
    box.clear();
    // debugPrint('Deleted  $index from box $boxName');
  }
}
