import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/quiz_result_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'success_widget.dart' show SuccessWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SuccessModel extends FlutterFlowModel<SuccessWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for QuizResult component.
  late QuizResultModel quizResultModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    quizResultModel = createModel(context, () => QuizResultModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    quizResultModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
