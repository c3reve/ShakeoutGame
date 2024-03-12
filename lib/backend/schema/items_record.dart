import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ItemsRecord extends FirestoreRecord {
  ItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "rarity" field.
  int? _rarity;
  int get rarity => _rarity ?? 0;
  bool hasRarity() => _rarity != null;

  // "imagePath" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  bool hasImagePath() => _imagePath != null;

  // "input_name" field.
  String? _inputName;
  String get inputName => _inputName ?? '';
  bool hasInputName() => _inputName != null;

  // "name" field.
  TranslateStringStruct? _name;
  TranslateStringStruct get name => _name ?? TranslateStringStruct();
  bool hasName() => _name != null;

  // "input_description" field.
  String? _inputDescription;
  String get inputDescription => _inputDescription ?? '';
  bool hasInputDescription() => _inputDescription != null;

  // "description" field.
  TranslateStringStruct? _description;
  TranslateStringStruct get description =>
      _description ?? TranslateStringStruct();
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _rarity = castToType<int>(snapshotData['rarity']);
    _imagePath = snapshotData['imagePath'] as String?;
    _inputName = snapshotData['input_name'] as String?;
    _name = TranslateStringStruct.maybeFromMap(snapshotData['name']);
    _inputDescription = snapshotData['input_description'] as String?;
    _description =
        TranslateStringStruct.maybeFromMap(snapshotData['description']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('items');

  static Stream<ItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ItemsRecord.fromSnapshot(s));

  static Future<ItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ItemsRecord.fromSnapshot(s));

  static ItemsRecord fromSnapshot(DocumentSnapshot snapshot) => ItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ItemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createItemsRecordData({
  int? rarity,
  String? imagePath,
  String? inputName,
  TranslateStringStruct? name,
  String? inputDescription,
  TranslateStringStruct? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'rarity': rarity,
      'imagePath': imagePath,
      'input_name': inputName,
      'name': TranslateStringStruct().toMap(),
      'input_description': inputDescription,
      'description': TranslateStringStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "name" field.
  addTranslateStringStructData(firestoreData, name, 'name');

  // Handle nested data for "description" field.
  addTranslateStringStructData(firestoreData, description, 'description');

  return firestoreData;
}

class ItemsRecordDocumentEquality implements Equality<ItemsRecord> {
  const ItemsRecordDocumentEquality();

  @override
  bool equals(ItemsRecord? e1, ItemsRecord? e2) {
    return e1?.rarity == e2?.rarity &&
        e1?.imagePath == e2?.imagePath &&
        e1?.inputName == e2?.inputName &&
        e1?.name == e2?.name &&
        e1?.inputDescription == e2?.inputDescription &&
        e1?.description == e2?.description;
  }

  @override
  int hash(ItemsRecord? e) => const ListEquality().hash([
        e?.rarity,
        e?.imagePath,
        e?.inputName,
        e?.name,
        e?.inputDescription,
        e?.description
      ]);

  @override
  bool isValidKey(Object? o) => o is ItemsRecord;
}
