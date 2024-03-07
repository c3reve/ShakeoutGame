// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScoreSetStruct extends FFFirebaseStruct {
  ScoreSetStruct({
    double? totalTime,
    double? dropTime,
    double? coverTime,
    double? holdOnTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _totalTime = totalTime,
        _dropTime = dropTime,
        _coverTime = coverTime,
        _holdOnTime = holdOnTime,
        super(firestoreUtilData);

  // "totalTime" field.
  double? _totalTime;
  double get totalTime => _totalTime ?? 0.0;
  set totalTime(double? val) => _totalTime = val;
  void incrementTotalTime(double amount) => _totalTime = totalTime + amount;
  bool hasTotalTime() => _totalTime != null;

  // "dropTime" field.
  double? _dropTime;
  double get dropTime => _dropTime ?? 0.0;
  set dropTime(double? val) => _dropTime = val;
  void incrementDropTime(double amount) => _dropTime = dropTime + amount;
  bool hasDropTime() => _dropTime != null;

  // "coverTime" field.
  double? _coverTime;
  double get coverTime => _coverTime ?? 0.0;
  set coverTime(double? val) => _coverTime = val;
  void incrementCoverTime(double amount) => _coverTime = coverTime + amount;
  bool hasCoverTime() => _coverTime != null;

  // "holdOnTime" field.
  double? _holdOnTime;
  double get holdOnTime => _holdOnTime ?? 0.0;
  set holdOnTime(double? val) => _holdOnTime = val;
  void incrementHoldOnTime(double amount) => _holdOnTime = holdOnTime + amount;
  bool hasHoldOnTime() => _holdOnTime != null;

  static ScoreSetStruct fromMap(Map<String, dynamic> data) => ScoreSetStruct(
        totalTime: castToType<double>(data['totalTime']),
        dropTime: castToType<double>(data['dropTime']),
        coverTime: castToType<double>(data['coverTime']),
        holdOnTime: castToType<double>(data['holdOnTime']),
      );

  static ScoreSetStruct? maybeFromMap(dynamic data) =>
      data is Map ? ScoreSetStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'totalTime': _totalTime,
        'dropTime': _dropTime,
        'coverTime': _coverTime,
        'holdOnTime': _holdOnTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'totalTime': serializeParam(
          _totalTime,
          ParamType.double,
        ),
        'dropTime': serializeParam(
          _dropTime,
          ParamType.double,
        ),
        'coverTime': serializeParam(
          _coverTime,
          ParamType.double,
        ),
        'holdOnTime': serializeParam(
          _holdOnTime,
          ParamType.double,
        ),
      }.withoutNulls;

  static ScoreSetStruct fromSerializableMap(Map<String, dynamic> data) =>
      ScoreSetStruct(
        totalTime: deserializeParam(
          data['totalTime'],
          ParamType.double,
          false,
        ),
        dropTime: deserializeParam(
          data['dropTime'],
          ParamType.double,
          false,
        ),
        coverTime: deserializeParam(
          data['coverTime'],
          ParamType.double,
          false,
        ),
        holdOnTime: deserializeParam(
          data['holdOnTime'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'ScoreSetStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ScoreSetStruct &&
        totalTime == other.totalTime &&
        dropTime == other.dropTime &&
        coverTime == other.coverTime &&
        holdOnTime == other.holdOnTime;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([totalTime, dropTime, coverTime, holdOnTime]);
}

ScoreSetStruct createScoreSetStruct({
  double? totalTime,
  double? dropTime,
  double? coverTime,
  double? holdOnTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ScoreSetStruct(
      totalTime: totalTime,
      dropTime: dropTime,
      coverTime: coverTime,
      holdOnTime: holdOnTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ScoreSetStruct? updateScoreSetStruct(
  ScoreSetStruct? scoreSet, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    scoreSet
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addScoreSetStructData(
  Map<String, dynamic> firestoreData,
  ScoreSetStruct? scoreSet,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (scoreSet == null) {
    return;
  }
  if (scoreSet.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && scoreSet.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final scoreSetData = getScoreSetFirestoreData(scoreSet, forFieldValue);
  final nestedData = scoreSetData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = scoreSet.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getScoreSetFirestoreData(
  ScoreSetStruct? scoreSet, [
  bool forFieldValue = false,
]) {
  if (scoreSet == null) {
    return {};
  }
  final firestoreData = mapToFirestore(scoreSet.toMap());

  // Add any Firestore field values
  scoreSet.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getScoreSetListFirestoreData(
  List<ScoreSetStruct>? scoreSets,
) =>
    scoreSets?.map((e) => getScoreSetFirestoreData(e, true)).toList() ?? [];
