import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SchedulesRecord extends FirestoreRecord {
  SchedulesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sentCount" field.
  int? _sentCount;
  int get sentCount => _sentCount ?? 0;
  bool hasSentCount() => _sentCount != null;

  // "sliderValue" field.
  double? _sliderValue;
  double get sliderValue => _sliderValue ?? 0.0;
  bool hasSliderValue() => _sliderValue != null;

  // "quizRef" field.
  DocumentReference? _quizRef;
  DocumentReference? get quizRef => _quizRef;
  bool hasQuizRef() => _quizRef != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "start_time" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "end_time" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "done_time" field.
  DateTime? _doneTime;
  DateTime? get doneTime => _doneTime;
  bool hasDoneTime() => _doneTime != null;

  void _initializeFields() {
    _sentCount = castToType<int>(snapshotData['sentCount']);
    _sliderValue = castToType<double>(snapshotData['sliderValue']);
    _quizRef = snapshotData['quizRef'] as DocumentReference?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _startTime = snapshotData['start_time'] as DateTime?;
    _endTime = snapshotData['end_time'] as DateTime?;
    _doneTime = snapshotData['done_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('schedules');

  static Stream<SchedulesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SchedulesRecord.fromSnapshot(s));

  static Future<SchedulesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SchedulesRecord.fromSnapshot(s));

  static SchedulesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SchedulesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SchedulesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SchedulesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SchedulesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SchedulesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSchedulesRecordData({
  int? sentCount,
  double? sliderValue,
  DocumentReference? quizRef,
  DateTime? createdTime,
  DateTime? startTime,
  DateTime? endTime,
  DateTime? doneTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sentCount': sentCount,
      'sliderValue': sliderValue,
      'quizRef': quizRef,
      'created_time': createdTime,
      'start_time': startTime,
      'end_time': endTime,
      'done_time': doneTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class SchedulesRecordDocumentEquality implements Equality<SchedulesRecord> {
  const SchedulesRecordDocumentEquality();

  @override
  bool equals(SchedulesRecord? e1, SchedulesRecord? e2) {
    return e1?.sentCount == e2?.sentCount &&
        e1?.sliderValue == e2?.sliderValue &&
        e1?.quizRef == e2?.quizRef &&
        e1?.createdTime == e2?.createdTime &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.doneTime == e2?.doneTime;
  }

  @override
  int hash(SchedulesRecord? e) => const ListEquality().hash([
        e?.sentCount,
        e?.sliderValue,
        e?.quizRef,
        e?.createdTime,
        e?.startTime,
        e?.endTime,
        e?.doneTime
      ]);

  @override
  bool isValidKey(Object? o) => o is SchedulesRecord;
}
