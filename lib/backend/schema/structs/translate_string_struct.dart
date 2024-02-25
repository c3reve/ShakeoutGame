// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TranslateStringStruct extends FFFirebaseStruct {
  TranslateStringStruct({
    String? ja,
    String? en,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ja = ja,
        _en = en,
        super(firestoreUtilData);

  // "ja" field.
  String? _ja;
  String get ja => _ja ?? '';
  set ja(String? val) => _ja = val;
  bool hasJa() => _ja != null;

  // "en" field.
  String? _en;
  String get en => _en ?? '';
  set en(String? val) => _en = val;
  bool hasEn() => _en != null;

  static TranslateStringStruct fromMap(Map<String, dynamic> data) =>
      TranslateStringStruct(
        ja: data['ja'] as String?,
        en: data['en'] as String?,
      );

  static TranslateStringStruct? maybeFromMap(dynamic data) => data is Map
      ? TranslateStringStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ja': _ja,
        'en': _en,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ja': serializeParam(
          _ja,
          ParamType.String,
        ),
        'en': serializeParam(
          _en,
          ParamType.String,
        ),
      }.withoutNulls;

  static TranslateStringStruct fromSerializableMap(Map<String, dynamic> data) =>
      TranslateStringStruct(
        ja: deserializeParam(
          data['ja'],
          ParamType.String,
          false,
        ),
        en: deserializeParam(
          data['en'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TranslateStringStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TranslateStringStruct && ja == other.ja && en == other.en;
  }

  @override
  int get hashCode => const ListEquality().hash([ja, en]);
}

TranslateStringStruct createTranslateStringStruct({
  String? ja,
  String? en,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TranslateStringStruct(
      ja: ja,
      en: en,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TranslateStringStruct? updateTranslateStringStruct(
  TranslateStringStruct? translateString, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    translateString
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTranslateStringStructData(
  Map<String, dynamic> firestoreData,
  TranslateStringStruct? translateString,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (translateString == null) {
    return;
  }
  if (translateString.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && translateString.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final translateStringData =
      getTranslateStringFirestoreData(translateString, forFieldValue);
  final nestedData =
      translateStringData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = translateString.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTranslateStringFirestoreData(
  TranslateStringStruct? translateString, [
  bool forFieldValue = false,
]) {
  if (translateString == null) {
    return {};
  }
  final firestoreData = mapToFirestore(translateString.toMap());

  // Add any Firestore field values
  translateString.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTranslateStringListFirestoreData(
  List<TranslateStringStruct>? translateStrings,
) =>
    translateStrings
        ?.map((e) => getTranslateStringFirestoreData(e, true))
        .toList() ??
    [];
