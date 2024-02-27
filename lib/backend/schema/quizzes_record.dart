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

  // "correct" field.
  int? _correct;
  int get correct => _correct ?? 0;
  bool hasCorrect() => _correct != null;

  // "no" field.
  int? _no;
  int get no => _no ?? 0;
  bool hasNo() => _no != null;

  // "input_question" field.
  String? _inputQuestion;
  String get inputQuestion => _inputQuestion ?? '';
  bool hasInputQuestion() => _inputQuestion != null;

  // "answers" field.
  TranslateStringStruct? _answers;
  TranslateStringStruct get answers => _answers ?? TranslateStringStruct();
  bool hasAnswers() => _answers != null;

  // "input_answers" field.
  String? _inputAnswers;
  String get inputAnswers => _inputAnswers ?? '';
  bool hasInputAnswers() => _inputAnswers != null;

  // "input_explanation" field.
  String? _inputExplanation;
  String get inputExplanation => _inputExplanation ?? '';
  bool hasInputExplanation() => _inputExplanation != null;

  // "explanation" field.
  TranslateStringStruct? _explanation;
  TranslateStringStruct get explanation =>
      _explanation ?? TranslateStringStruct();
  bool hasExplanation() => _explanation != null;

  void _initializeFields() {
    _question = TranslateStringStruct.maybeFromMap(snapshotData['question']);
    _correct = castToType<int>(snapshotData['correct']);
    _no = castToType<int>(snapshotData['no']);
    _inputQuestion = snapshotData['input_question'] as String?;
    _answers = TranslateStringStruct.maybeFromMap(snapshotData['answers']);
    _inputAnswers = snapshotData['input_answers'] as String?;
    _inputExplanation = snapshotData['input_explanation'] as String?;
    _explanation =
        TranslateStringStruct.maybeFromMap(snapshotData['explanation']);
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
  int? no,
  String? inputQuestion,
  TranslateStringStruct? answers,
  String? inputAnswers,
  String? inputExplanation,
  TranslateStringStruct? explanation,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question': TranslateStringStruct().toMap(),
      'correct': correct,
      'no': no,
      'input_question': inputQuestion,
      'answers': TranslateStringStruct().toMap(),
      'input_answers': inputAnswers,
      'input_explanation': inputExplanation,
      'explanation': TranslateStringStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "question" field.
  addTranslateStringStructData(firestoreData, question, 'question');

  // Handle nested data for "answers" field.
  addTranslateStringStructData(firestoreData, answers, 'answers');

  // Handle nested data for "explanation" field.
  addTranslateStringStructData(firestoreData, explanation, 'explanation');

  return firestoreData;
}

class QuizzesRecordDocumentEquality implements Equality<QuizzesRecord> {
  const QuizzesRecordDocumentEquality();

  @override
  bool equals(QuizzesRecord? e1, QuizzesRecord? e2) {
    return e1?.question == e2?.question &&
        e1?.correct == e2?.correct &&
        e1?.no == e2?.no &&
        e1?.inputQuestion == e2?.inputQuestion &&
        e1?.answers == e2?.answers &&
        e1?.inputAnswers == e2?.inputAnswers &&
        e1?.inputExplanation == e2?.inputExplanation &&
        e1?.explanation == e2?.explanation;
  }

  @override
  int hash(QuizzesRecord? e) => const ListEquality().hash([
        e?.question,
        e?.correct,
        e?.no,
        e?.inputQuestion,
        e?.answers,
        e?.inputAnswers,
        e?.inputExplanation,
        e?.explanation
      ]);

  @override
  bool isValidKey(Object? o) => o is QuizzesRecord;
}
