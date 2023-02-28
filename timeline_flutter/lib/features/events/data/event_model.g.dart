// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Event extends _Event with RealmEntity, RealmObjectBase, RealmObject {
  Event(
    int id,
    String title,
    String description,
    DateTime start,
    DateTime end,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'start', start);
    RealmObjectBase.set(this, 'end', end);
  }

  Event._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => throw RealmUnsupportedSetError();

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) => throw RealmUnsupportedSetError();

  @override
  DateTime get start =>
      RealmObjectBase.get<DateTime>(this, 'start') as DateTime;
  @override
  set start(DateTime value) => throw RealmUnsupportedSetError();

  @override
  DateTime get end => RealmObjectBase.get<DateTime>(this, 'end') as DateTime;
  @override
  set end(DateTime value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Event>> get changes =>
      RealmObjectBase.getChanges<Event>(this);

  @override
  Event freeze() => RealmObjectBase.freezeObject<Event>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Event._);
    return const SchemaObject(ObjectType.realmObject, Event, 'Event', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('start', RealmPropertyType.timestamp),
      SchemaProperty('end', RealmPropertyType.timestamp),
    ]);
  }
}
