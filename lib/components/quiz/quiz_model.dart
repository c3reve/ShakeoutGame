import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'quiz_widget.dart' show QuizWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuizModel extends FlutterFlowModel<QuizWidget> {
  ///  Local state fields for this component.

  List<Color> csContainerColor = [Color(0), Color(0), Color(0), Color(0)];
  void addToCsContainerColor(Color item) => csContainerColor.add(item);
  void removeFromCsContainerColor(Color item) => csContainerColor.remove(item);
  void removeAtIndexFromCsContainerColor(int index) =>
      csContainerColor.removeAt(index);
  void insertAtIndexInCsContainerColor(int index, Color item) =>
      csContainerColor.insert(index, item);
  void updateCsContainerColorAtIndex(int index, Function(Color) updateFn) =>
      csContainerColor[index] = updateFn(csContainerColor[index]);

  bool isCorrected = false;

  bool showIncorrect = false;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
