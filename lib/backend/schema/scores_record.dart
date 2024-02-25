import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScoresRecord extends FirestoreRecord {
  ScoresRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "scheduleRef" field.
  DocumentReference? _scheduleRef;
  DocumentReference? get scheduleRef => _scheduleRef;
  bool hasScheduleRef() => _scheduleRef != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "time" field.
  int? _time;
  int get time => _time ?? 0;
  bool hasTime() => _time != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _scheduleRef = snapshotData['scheduleRef'] as DocumentReference?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _time = castToType<int>(snapshotData['time']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('scores')
          : FirebaseFirestore.instance.collectionGroup('scores');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('scores').doc(id);

  static Stream<ScoresRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ScoresRecord.fromSnapshot(s));

  static Future<ScoresRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ScoresRecord.fromSnapshot(s));

  static ScoresRecord fromSnapshot(DocumentSnapshot snapshot) => ScoresRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ScoresRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ScoresRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ScoresRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ScoresRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createScoresRecordData({
  DocumentReference? scheduleRef,
  DateTime? createdTime,
  int? time,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'scheduleRef': scheduleRef,
      'created_time': createdTime,
      'time': time,
    }.withoutNulls,
  );

  return firestoreData;
}

class ScoresRecordDocumentEquality implements Equality<ScoresRecord> {
  const ScoresRecordDocumentEquality();

  @override
  bool equals(ScoresRecord? e1, ScoresRecord? e2) {
    return e1?.scheduleRef == e2?.scheduleRef &&
        e1?.createdTime == e2?.createdTime &&
        e1?.time == e2?.time;
  }

  @override
  int hash(ScoresRecord? e) =>
      const ListEquality().hash([e?.scheduleRef, e?.createdTime, e?.time]);

  @override
  bool isValidKey(Object? o) => o is ScoresRecord;
}
