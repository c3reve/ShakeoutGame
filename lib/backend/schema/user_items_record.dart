import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserItemsRecord extends FirestoreRecord {
  UserItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "itemRef" field.
  DocumentReference? _itemRef;
  DocumentReference? get itemRef => _itemRef;
  bool hasItemRef() => _itemRef != null;

  // "scheduleRef" field.
  DocumentReference? _scheduleRef;
  DocumentReference? get scheduleRef => _scheduleRef;
  bool hasScheduleRef() => _scheduleRef != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "passUrl" field.
  String? _passUrl;
  String get passUrl => _passUrl ?? '';
  bool hasPassUrl() => _passUrl != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _itemRef = snapshotData['itemRef'] as DocumentReference?;
    _scheduleRef = snapshotData['scheduleRef'] as DocumentReference?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _passUrl = snapshotData['passUrl'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_items');

  static Stream<UserItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserItemsRecord.fromSnapshot(s));

  static Future<UserItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserItemsRecord.fromSnapshot(s));

  static UserItemsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserItemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserItemsRecordData({
  DocumentReference? userRef,
  DocumentReference? itemRef,
  DocumentReference? scheduleRef,
  DateTime? createdTime,
  String? passUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'itemRef': itemRef,
      'scheduleRef': scheduleRef,
      'created_time': createdTime,
      'passUrl': passUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserItemsRecordDocumentEquality implements Equality<UserItemsRecord> {
  const UserItemsRecordDocumentEquality();

  @override
  bool equals(UserItemsRecord? e1, UserItemsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.itemRef == e2?.itemRef &&
        e1?.scheduleRef == e2?.scheduleRef &&
        e1?.createdTime == e2?.createdTime &&
        e1?.passUrl == e2?.passUrl;
  }

  @override
  int hash(UserItemsRecord? e) => const ListEquality().hash(
      [e?.userRef, e?.itemRef, e?.scheduleRef, e?.createdTime, e?.passUrl]);

  @override
  bool isValidKey(Object? o) => o is UserItemsRecord;
}
