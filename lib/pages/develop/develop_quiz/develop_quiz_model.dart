import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/quiz/quiz_widget.dart';
import '/components/quiz_result_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'develop_quiz_widget.dart' show DevelopQuizWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DevelopQuizModel extends FlutterFlowModel<DevelopQuizWidget> {
  ///  Local state fields for this page.

  QuizzesRecord? psQuiz;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in develop_quiz widget.
  int? quizCount;
  // Stores action output result for [Firestore Query - Query a collection] action in develop_quiz widget.
  QuizzesRecord? randomQuiz;
  // Model for Quiz component.
  late QuizModel quizModel;
  // Model for QuizResult component.
  late QuizResultModel quizResultModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    quizModel = createModel(context, () => QuizModel());
    quizResultModel = createModel(context, () => QuizResultModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    quizModel.dispose();
    quizResultModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
