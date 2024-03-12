import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/decimal_time_widget.dart';
import '/components/quiz_result_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'success_widget.dart' show SuccessWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SuccessModel extends FlutterFlowModel<SuccessWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for DecimalTime component.
  late DecimalTimeModel decimalTimeModel1;
  // Model for DecimalTime component.
  late DecimalTimeModel decimalTimeModel2;
  // Model for DecimalTime component.
  late DecimalTimeModel decimalTimeModel3;
  // Model for DecimalTime component.
  late DecimalTimeModel decimalTimeModel4;
  // Model for QuizResult component.
  late QuizResultModel quizResultModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    decimalTimeModel1 = createModel(context, () => DecimalTimeModel());
    decimalTimeModel2 = createModel(context, () => DecimalTimeModel());
    decimalTimeModel3 = createModel(context, () => DecimalTimeModel());
    decimalTimeModel4 = createModel(context, () => DecimalTimeModel());
    quizResultModel = createModel(context, () => QuizResultModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    decimalTimeModel1.dispose();
    decimalTimeModel2.dispose();
    decimalTimeModel3.dispose();
    decimalTimeModel4.dispose();
    quizResultModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
