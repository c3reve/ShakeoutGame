// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuizDataStruct extends FFFirebaseStruct {
  QuizDataStruct({
    String? question,
    List<String>? answers,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _question = question,
        _answers = answers,
        super(firestoreUtilData);

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  set question(String? val) => _question = val;
  bool hasQuestion() => _question != null;

  // "answers" field.
  List<String>? _answers;
  List<String> get answers => _answers ?? const [];
  set answers(List<String>? val) => _answers = val;
  void updateAnswers(Function(List<String>) updateFn) =>
      updateFn(_answers ??= []);
  bool hasAnswers() => _answers != null;

  static QuizDataStruct fromMap(Map<String, dynamic> data) => QuizDataStruct(
        question: data['question'] as String?,
        answers: getDataList(data['answers']),
      );

  static QuizDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? QuizDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'question': _question,
        'answers': _answers,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'question': serializeParam(
          _question,
          ParamType.String,
        ),
        'answers': serializeParam(
          _answers,
          ParamType.String,
          true,
        ),
      }.withoutNulls;

  static QuizDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuizDataStruct(
        question: deserializeParam(
          data['question'],
          ParamType.String,
          false,
        ),
        answers: deserializeParam<String>(
          data['answers'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'QuizDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is QuizDataStruct &&
        question == other.question &&
        listEquality.equals(answers, other.answers);
  }

  @override
  int get hashCode => const ListEquality().hash([question, answers]);
}

QuizDataStruct createQuizDataStruct({
  String? question,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuizDataStruct(
      question: question,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

QuizDataStruct? updateQuizDataStruct(
  QuizDataStruct? quizData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    quizData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addQuizDataStructData(
  Map<String, dynamic> firestoreData,
  QuizDataStruct? quizData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (quizData == null) {
    return;
  }
  if (quizData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && quizData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final quizDataData = getQuizDataFirestoreData(quizData, forFieldValue);
  final nestedData = quizDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = quizData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getQuizDataFirestoreData(
  QuizDataStruct? quizData, [
  bool forFieldValue = false,
]) {
  if (quizData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(quizData.toMap());

  // Add any Firestore field values
  quizData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuizDataListFirestoreData(
  List<QuizDataStruct>? quizDatas,
) =>
    quizDatas?.map((e) => getQuizDataFirestoreData(e, true)).toList() ?? [];
