import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

String translateFromAuthLanguage(TranslateStringStruct target) {
  final language = currentUserDocument?.language != null
      ? currentUserDocument?.language
      : 'ja';
  return target.toMap()[language];
}

List<TranslateStringStruct> translateMapToList(
    List<TranslateStringStruct> data) {
  print(data);
  return (data as dynamic).entries.map((e) => e.value).toList();
}

List<String> splitTranslate(String str) {
  return str.split("\n");
}

String msToString(int ms) {
  // Convert millisecond number to m:s:ms string
  final Duration duration = Duration(milliseconds: ms);
  final int seconds = duration.inSeconds;
  final int milliseconds = duration.inMilliseconds.remainder(1000);
  return '${seconds.toString()}.${milliseconds.toString()}';
}

double? normalizationAlignment(double inputValue) {
  // Function to subtract 50 from the input value, divide by 100, and return as an double type
  double result = 2 * (inputValue - 50) / 100;
  return result;
}

int? returnAdd(int input) {
  return input + 1;
}
