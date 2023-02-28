import 'package:realm/realm.dart';

part 'event_model.g.dart';

@RealmModel()
class _Event {
  late final int id;
  late final String title;
  late final String description;
  late final DateTime start;
  late final DateTime end;

  // _Event copyWith({
  //   int? id,
  //   String? title,
  //   String? description,
  //   DateTime? start,
  //   DateTime? end,
  // }) {
  //   return _Event(
  //     id: id ?? this.id,
  //     title: title ?? this.title,
  //     description: description ?? this.description,
  //     start: start ?? this.start,
  //     end: end ?? this.end,
  //   );
  // }

  @override
  String toString() {
    return '_Event(id: $id, title: $title, description: $description, start: $start, end: $end)';
  }
}
