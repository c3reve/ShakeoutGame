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

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "scheduleRef" field.
  DocumentReference? _scheduleRef;
  DocumentReference? get scheduleRef => _scheduleRef;
  bool hasScheduleRef() => _scheduleRef != null;

  // "time" field.
  int? _time;
  int get time => _time ?? 0;
  bool hasTime() => _time != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "score" field.
  ScoreSetStruct? _score;
  ScoreSetStruct get score => _score ?? ScoreSetStruct();
  bool hasScore() => _score != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _scheduleRef = snapshotData['scheduleRef'] as DocumentReference?;
    _time = castToType<int>(snapshotData['time']);
    _createdTime = snapshotData['created_time'] as DateTime?;
    _score = ScoreSetStruct.maybeFromMap(snapshotData['score']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('scores');

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
  DocumentReference? userRef,
  DocumentReference? scheduleRef,
  int? time,
  DateTime? createdTime,
  ScoreSetStruct? score,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'scheduleRef': scheduleRef,
      'time': time,
      'created_time': createdTime,
      'score': ScoreSetStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "score" field.
  addScoreSetStructData(firestoreData, score, 'score');

  return firestoreData;
}

class ScoresRecordDocumentEquality implements Equality<ScoresRecord> {
  const ScoresRecordDocumentEquality();

  @override
  bool equals(ScoresRecord? e1, ScoresRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.scheduleRef == e2?.scheduleRef &&
        e1?.time == e2?.time &&
        e1?.createdTime == e2?.createdTime &&
        e1?.score == e2?.score;
  }

  @override
  int hash(ScoresRecord? e) => const ListEquality()
      .hash([e?.userRef, e?.scheduleRef, e?.time, e?.createdTime, e?.score]);

  @override
  bool isValidKey(Object? o) => o is ScoresRecord;
}
