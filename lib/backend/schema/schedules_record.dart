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

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

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

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _sentCount = castToType<int>(snapshotData['sentCount']);
    _sliderValue = castToType<double>(snapshotData['sliderValue']);
    _quizRef = snapshotData['quizRef'] as DocumentReference?;
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
  DateTime? date,
  int? sentCount,
  double? sliderValue,
  DocumentReference? quizRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'sentCount': sentCount,
      'sliderValue': sliderValue,
      'quizRef': quizRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class SchedulesRecordDocumentEquality implements Equality<SchedulesRecord> {
  const SchedulesRecordDocumentEquality();

  @override
  bool equals(SchedulesRecord? e1, SchedulesRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.sentCount == e2?.sentCount &&
        e1?.sliderValue == e2?.sliderValue &&
        e1?.quizRef == e2?.quizRef;
  }

  @override
  int hash(SchedulesRecord? e) => const ListEquality()
      .hash([e?.date, e?.sentCount, e?.sliderValue, e?.quizRef]);

  @override
  bool isValidKey(Object? o) => o is SchedulesRecord;
}
