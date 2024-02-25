import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuizzesRecord extends FirestoreRecord {
  QuizzesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "question" field.
  TranslateStringStruct? _question;
  TranslateStringStruct get question => _question ?? TranslateStringStruct();
  bool hasQuestion() => _question != null;

  // "answers" field.
  List<TranslateStringStruct>? _answers;
  List<TranslateStringStruct> get answers => _answers ?? const [];
  bool hasAnswers() => _answers != null;

  // "correct" field.
  int? _correct;
  int get correct => _correct ?? 0;
  bool hasCorrect() => _correct != null;

  void _initializeFields() {
    _question = TranslateStringStruct.maybeFromMap(snapshotData['question']);
    _answers = getStructList(
      snapshotData['answers'],
      TranslateStringStruct.fromMap,
    );
    _correct = castToType<int>(snapshotData['correct']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('quizzes');

  static Stream<QuizzesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuizzesRecord.fromSnapshot(s));

  static Future<QuizzesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => QuizzesRecord.fromSnapshot(s));

  static QuizzesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuizzesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuizzesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuizzesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuizzesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuizzesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuizzesRecordData({
  TranslateStringStruct? question,
  int? correct,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question': TranslateStringStruct().toMap(),
      'correct': correct,
    }.withoutNulls,
  );

  // Handle nested data for "question" field.
  addTranslateStringStructData(firestoreData, question, 'question');

  return firestoreData;
}

class QuizzesRecordDocumentEquality implements Equality<QuizzesRecord> {
  const QuizzesRecordDocumentEquality();

  @override
  bool equals(QuizzesRecord? e1, QuizzesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.question == e2?.question &&
        listEquality.equals(e1?.answers, e2?.answers) &&
        e1?.correct == e2?.correct;
  }

  @override
  int hash(QuizzesRecord? e) =>
      const ListEquality().hash([e?.question, e?.answers, e?.correct]);

  @override
  bool isValidKey(Object? o) => o is QuizzesRecord;
}
