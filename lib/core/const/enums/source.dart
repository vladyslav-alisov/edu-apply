import 'package:collection/collection.dart';

enum Source {
  website("WEBSITE"),
  dashboard("DASHBOARD");

  final String json;

  const Source(this.json);

  static Source? fromString(String? value) {
    if (value == null) return null;
    return Source.values.firstWhereOrNull((e) => e.json == value.toUpperCase());
  }
}
